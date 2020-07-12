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
  "label": "*.google.at"
  "date": "Sun Jul 12 20:06:08 CEST 2020"
  "subject": {
    "raw": "C = US, ST = California, L = Mountain View, O = Google LLC, CN = *.google.at",
    "common_name": "*.google.at",
    "country": "US",
    "organization": "Google LLC",
    "names": [
      "DNS:*.google.at, DNS:google.at"
    ]
  },
  "issuer": {
    "raw": "C = US, O = Google Trust Services, CN = GTS CA 1O1",
    "common_name": "GTS CA 1O1",
    "country": "US",
    "organization": "Google Trust Services",
    "url": "http://pki.goog/gsr2/GTS1O1.crt"
  },
  "serial_number": "23:6e:43:6d:08:17:a9:8b:08:00:00:00:00:47:f0:50",
  "sans": [
    "DNS:*.google.at, DNS:google.at"
  ],
  "not_before": "Jun 17 14:32:13 2020 GMT",
  "not_after": "Sep  9 14:32:13 2020 GMT",
  "sigalg": "sha256WithRSAEncryption",
  "authority_key_id": "keyid:98:D1:F8:6E:10:EB:CF:9B:EC:60:9F:18:90:1B:A0:EB:7D:09:FD:2B",
  "subject_key_id": "ED:33:64:97:91:79:6A:9A:6A:AF:20:E7:B9:A5:69:9C:29:3E:2B:03"
}
```
