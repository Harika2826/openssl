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
privatekeyc=$7
privatekeyd=$8
privatekeye=$9


if [[ $# -lt 9 ]] ; then
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

openssl dgst -sha256 -out hash_filename.sha256 $filename
openssl dgst -sha256 -out hash_filenamea.sha256 $filenamea
openssl dgst -sha256 -out hash_filenameb.sha256 $filenameb


cat hash_filename.sha256 signature.sha256 > combined_zero_stage_sig.sha256
cat hash_filenamea.sha256 signaturea.sha256 > combined_first_stage_sig.sha256
cat hash_filenameb.sha256 signatureb.sha256 > combined_second_stage_sig.sha256

apps/openssl dgst -sha256 -sign $privatekeyc -out double_sign_zero_stage.sha256 combined_zero_stage_sig.sha256
apps/openssl dgst -sha256 -sign $privatekeyd -out double_sign_first_stage.sha256 combined_first_stage_sig.sha256
apps/openssl dgst -sha256 -sign $privatekeye -out double_sign_second_stage.sha256 combined_second_stage_sig.sha256

apps/openssl base64 -in double_sign_zero_stage.sha256 -out double_sign_zero_stage1.sha256
apps/openssl base64 -in double_sign_first_stage.sha256 -out double_sign_first_stage2.sha256
apps/openssl base64 -in double_sign_second_stage.sha256 -out double_sign_second_stage3.sha256

}
rm $filename.sha256 $filenamea.sha256 $filenameb.sha256
