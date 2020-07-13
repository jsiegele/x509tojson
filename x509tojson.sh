#!/bin/bash
IFS=''

CERT=$(cat)
# TODO: INPUT Validierung:
#       Input überhaupt vorhanden?
#       Input valides x509 oder gskit Format?

getCertSubject() {
  echo $CERT | awk 'BEGIN{FS="Subject: "} NF==2{print $2}'
}
getCertSignatureAlgorithm() {
  echo $CERT | awk 'BEGIN{FS="Signature Algorithm: "} NF==2{print $2}'|head -n 1
}
getCertIssuer() {
  echo $CERT | awk 'BEGIN{FS="Issuer: "} NF==2{print $2}'
}
getCertNotBefore() {
  echo $CERT | awk 'BEGIN{FS="Not Before: "} NF==2{print $2}' | sed 's/Jan/1/g;s/Feb/2/g;s/Mar/3/g;s/Apr/4/g;s/May/5/g;s/Jun/6/g;s/Jul/7/g;s/Aug/8/g;s/Sep/9/g;s/Oct/10/g;s/Nev/11/g;s/Dec/12/g'
}
getCertNotAfter() {
  echo $CERT | awk 'BEGIN{FS="Not After : "} NF==2{print $2}' | sed 's/Jan/1/g;s/Feb/2/g;s/Mar/3/g;s/Apr/4/g;s/May/5/g;s/Jun/6/g;s/Jul/7/g;s/Aug/8/g;s/Sep/9/g;s/Oct/10/g;s/Nov/11/g;s/Dec/12/g'
}
getCertIssuerURL() {
  echo $CERT | awk 'BEGIN{FS="CA Issuers - URI:"} NF==2{print $2}'
}
getCertDNS() {
  echo $CERT | sed -n '/Subject Alternative Name:/{n;p;}' | xargs | sed "s/DNS://g" | sed "s/,//g"
}
getCertSerialNumber() {
  echo $CERT | sed -n '/Serial Number:/{n;p;}' | xargs
}
getCertSubjectKeyIdentifier() {
  echo $CERT | sed -n '/Subject Key Identifier:/{n;p;}' | xargs
}
getCertAuthorityKeyIdentifier() {
  echo $CERT | sed -n '/Authority Key Identifier:/{n;p;}' | xargs
}

SUBJECT=$(getCertSubject)
ISSUER=$(getCertIssuer)

getCommonName(){
    echo $1 | awk 'BEGIN{FS="(^| )CN="} NF==2{print $2}' | awk -F, '{print $1}'| xargs
}
getOrganisation(){
    echo $1 | awk 'BEGIN{FS="(^| )O="} NF==2{print $2}' | awk -F, '{print $1}'| xargs
}
getCountry(){
    echo $1 | awk 'BEGIN{FS="(^| )C="} NF==2{print $2}' | awk -F, '{print $1}'| xargs
}
getDNSArray(){
    echo $1 | sed 's/ /\", \"/g;s/^/\"/;s/$/\"/'
}

read -r -d '' JSON << EOM
{
  "label": "$(getCommonName $SUBJECT)",
  "node": "$(hostname)",
  "date": "$(date)",
  "subject": {
    "raw": "$SUBJECT",
    "common_name": "$(getCommonName $SUBJECT)",
    "country": "$(getCountry $SUBJECT)",
    "organization": "$(getOrganisation $SUBJECT)",
    "names": [
       $(getDNSArray $(getCertDNS))
    ]
  },
  "issuer": {
    "raw": "$ISSUER",
    "common_name": "$(getCommonName $ISSUER)",
    "country": "$(getCountry $ISSUER)",
    "organization": "$(getOrganisation $ISSUER)",
    "url": "$(getCertIssuerURL)"
  },
  "serial_number": "$(getCertSerialNumber)",
  "sans": [
    $(getDNSArray $(getCertDNS))
  ],
  "not_before": "$(getCertNotBefore)",
  "not_after": "$(getCertNotAfter)",
  "sigalg": "$(getCertSignatureAlgorithm)",
  "authority_key_id": "$(getCertAuthorityKeyIdentifier)",
  "subject_key_id": "$(getCertSubjectKeyIdentifier)"
}
EOM

echo "$JSON"
