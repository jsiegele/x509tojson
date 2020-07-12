# x509tojson

Diesem Skript wird über STDIN ein x.509 formatiertes Zertifikat übergeben.
Der Inhalt wird als JSON formatiert auf STDOUT ausgegeben.

# Usage
```
$ cat ../supercert.x509 | x509tojson.sh
```
# Example Output
```
{
  "label": "www.volksbank.at"
  "date": "Sun Jul 12 19:56:22 CEST 2020"
  "subject": {
    "raw": "businessCategory = Private Organization, jurisdictionC = AT, jurisdictionST = Wien, jurisdictionL = Wien, serialNumber = 211524s, C = AT, ST = Wien, L = Wien, O = Volksbank Wien AG, OU = IT 2, CN = www.volksbank.at",
    "common_name": "www.volksbank.at",
    "country": "AT",
    "organization": "Volksbank Wien AG",
    "names": [
      "DNS:www.volksbank.at, DNS:volksbank.at, DNS:banking.volksbank.at"
    ]
  },
  "issuer": {
    "raw": "C = US, O = DigiCert Inc, OU = www.digicert.com, CN = GeoTrust EV RSA CA 2018",
    "common_name": "GeoTrust EV RSA CA 2018",
    "country": "US",
    "organization": "DigiCert Inc",
    "url": "http://cacerts.geotrust.com/GeoTrustEVRSACA2018.crt"
  },
  "serial_number": "0a:45:95:c0:56:7d:81:17:ce:8f:e0:51:d2:da:e6:a6",
  "sans": [
    "DNS:www.volksbank.at, DNS:volksbank.at, DNS:banking.volksbank.at"
  ],
  "not_before": "Jul  4 00:00:00 2019 GMT",
  "not_after": "Jul  3 12:00:00 2021 GMT",
  "sigalg": "sha256WithRSAEncryption",
  "authority_key_id": "keyid:CA:92:67:52:61:DE:AE:FC:BA:22:2B:7F:1C:87:4C:25:FB:6F:99:58",
  "subject_key_id": "F7:9D:A3:E6:99:06:C6:77:A5:90:17:8A:EB:B7:46:8A:00:A5:BD:A6"
}
```
