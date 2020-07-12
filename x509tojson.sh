#!/bin/bash
IFS=''
CERT=$(</dev/stdin)

getCertSubject() {
  echo $CERT | awk 'BEGIN{FS="Subject: "} NF==2{print $2}'
}
getCertNotBefore() {
  echo $CERT | awk 'BEGIN{FS="Not Before: "} NF==2{print $2}'
}
getCertNotAfter() {
  echo $CERT | awk 'BEGIN{FS="Not After : "} NF==2{print $2}'
}

getCertSignatureAlgorithm() {
  echo $CERT | awk 'BEGIN{FS="Signature Algorithm: "} NF==2{print $2}'|head -n 1
}

getCertIssuer() {
  echo $CERT | awk 'BEGIN{FS="Issuer: "} NF==2{print $2}'
}

getCertNotAfter() {
  echo $CERT | awk 'BEGIN{FS="Not After : "} NF==2{print $2}'
}

getCertIssuerURL() {
  echo $CERT | awk 'BEGIN{FS="CA Issuers - URI:"} NF==2{print $2}'
}
getCertDNS() {
  echo $CERT | sed -n '/Subject Alternative Name:/{n;p;}' | xargs
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

getCertSubject
getCertNotBefore
getCertNotAfter
getCertSignatureAlgorithm
getCertIssuer
getCertNotAfter
getCertIssuerURL
getCertDNS
getCertSerialNumber
getCertSubjectKeyIdentifier
getCertAuthorityKeyIdentifier
