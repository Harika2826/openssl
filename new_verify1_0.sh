#!/bin/bash
# Verify a file with a public key using OpenSSL
# Decode the signature from Base64 format
#
# Usage: verify <file> <signature> <public_key>


filename=$1
filename1=$2
filename2=$3
signature=$4
signature1=$5
signature2=$6
publickey=$7
publickey1=$8
publickey2=$9
rootcert=${10}
zerostage=${11}
firststage=${12}

if [[ $# -lt 12 ]] ; then
  echo "Usage: verify <file> <signature> <public_key>"
  exit 1
fi

TIMEFORMAT='Time taken for certificate verification %R seconds.'
time {
apps/openssl verify -CAfile $rootcert $zerostage
apps/openssl verify -CAfile $rootcert $firststage
}
#TIMEFORMAT='Time taken for signature verification %R seconds.'
#time {
apps/openssl base64 -d -in $signature -out $filename.sha256
apps/openssl dgst -sha256 -verify $publickey -signature $filename.sha256 $filename

apps/openssl base64 -d -in $signature1 -out $filename1.sha256
apps/openssl dgst -sha256 -verify $publickey1 -signature $filename1.sha256 $filename1

apps/openssl base64 -d -in $signature2 -out $filename2.sha256
apps/openssl dgst -sha256 -verify $publickey2 -signature $filename2.sha256 $filename2
#}



rm $filename.sha256
