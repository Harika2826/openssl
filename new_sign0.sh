#!/bin/bash
# Sign a file with a private key
# Encode the signature in Base64 format
#
# Usage: sign <file> <private_key>


filename=$1
filenamea=$2
filenameb=$3
privatekey=$4
privatekeya=$5
privatekeyb=$6


if [[ $# -lt 6 ]] ; then
  echo "Usage: sign <file> <private_key>"
  exit 1
fi

TIMEFORMAT='Signature generation time %R seconds.'
time { 
apps/openssl dgst -sha256 -sign $privatekey -out $filename.sha256 $filename
apps/openssl dgst -sha256 -sign $privatekeya -out $filenamea.sha256 $filenamea
apps/openssl dgst -sha256 -sign $privatekeyb -out $filenameb.sha256 $filenameb

apps/openssl base64 -in $filename.sha256 -out signature.sha256
apps/openssl base64 -in $filenamea.sha256 -out signaturea.sha256
apps/openssl base64 -in $filenameb.sha256 -out signatureb.sha256

}
rm $filename.sha256 $filenamea.sha256 $filenameb.sha256

