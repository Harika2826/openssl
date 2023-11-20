#!/bin/bash


filename=$1
filename1=$2
filename2=$3
signature=$4
signature1=$5
signature2=$6
publickey=$7
publickey1=$8
publickey2=$9
filename3=${10}
filename4=${11}
filename5=${12}
signature3=${13}
signature4=${14}
signature5=${15}
publickey3=${16}
publickey4=${17}
publickey5=${18}


if [[ $# -lt 18 ]] ; then
  echo "Usage: verify <file> <signature> <public_key>"
  exit 1
fi

TIMEFORMAT='Signature verification time %R seconds.'
time { 
apps/openssl base64 -d -in $signature -out $filename.sha256
apps/openssl dgst -sha256 -verify $publickey -signature $filename.sha256 $filename


apps/openssl base64 -d -in $signature1 -out $filename1.sha256
apps/openssl dgst -sha256 -verify $publickey1 -signature $filename1.sha256 $filename1

apps/openssl base64 -d -in $signature2 -out $filename2.sha256
apps/openssl dgst -sha256 -verify $publickey2 -signature $filename2.sha256 $filename2


apps/openssl base64 -d -in $signature3 -out $filename3.sha256
apps/openssl dgst -sha256 -verify $publickey3 -signature $filename3.sha256 $filename3


apps/openssl base64 -d -in $signature4 -out $filename4.sha256
apps/openssl dgst -sha256 -verify $publickey4 -signature $filename4.sha256 $filename4

apps/openssl base64 -d -in $signature5 -out $filename5.sha256
apps/openssl dgst -sha256 -verify $publickey5 -signature $filename5.sha256 $filename5
}


rm $filename.sha256 $filename1.sha256 $filename2.sha256 $filename3.sha256 $filename4.sha256 $filename5.sha256



