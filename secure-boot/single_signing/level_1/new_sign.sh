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
apps/openssl dgst -shake128 -sign $privatekey -out $filename.shake128 $filename
apps/openssl dgst -shake128 -sign $privatekeya -out $filenamea.shake128 $filenamea
apps/openssl dgst -shake128 -sign $privatekeyb -out $filenameb.shake128 $filenameb

apps/openssl base64 -in $filename.shake128 -out signature.shake128
apps/openssl base64 -in $filenamea.shake128 -out signaturea.shake128
apps/openssl base64 -in $filenameb.shake128 -out signatureb.shake128

}
rm $filename.shake128 $filenamea.shake128 $filenameb.shake128
