#!/bin/bash

# Verify a file with a public key using OpenSSL
# Decode the signature from Base64 format
#
# Usage: verify <file> <signature> <public_key>

if [[ $# -lt 12 ]] ; then
  echo "Usage: verify <file> <signature> <public_key>"
  exit 1
fi

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
iterations=100
total_certificate_verification_time=0
total_signature_verification_time=0

#for ((i=1; i<=$iterations; i++)); do
#  echo "Iteration $i"
  
  # Certificate verification
  #start_time_certificate=$(date +%s.%N)
  apps/openssl verify -CAfile $rootcert $zerostage
  apps/openssl verify -CAfile $rootcert $firststage
  #end_time_certificate=$(date +%s.%N)
  #certificate_verification_time=$(echo "$end_time_certificate - $start_time_certificate" | bc -l)
  #total_certificate_verification_time=$(echo "$total_certificate_verification_time + $certificate_verification_time" | bc -l)
  
  # Signature verification
  #start_time_signature=$(date +%s.%N)
  apps/openssl base64 -d -in $signature -out $filename.sha256
  apps/openssl dgst -sha256 -verify $publickey -signature $filename.sha256 $filename
  apps/openssl base64 -d -in $signature1 -out $filename1.sha256
  apps/openssl dgst -sha256 -verify $publickey1 -signature $filename1.sha256 $filename1
  apps/openssl base64 -d -in $signature2 -out $filename2.sha256
  apps/openssl dgst -sha256 -verify $publickey2 -signature $filename2.sha256 $filename2
  #end_time_signature=$(date +%s.%N)
  #signature_verification_time=$(echo "$end_time_signature - $start_time_signature" | bc -l)
  #total_signature_verification_time=$(echo "$total_signature_verification_time + $signature_verification_time" | bc -l)
  
  rm $filename.sha256
  rm $filename1.sha256
  rm $filename2.sha256
#done


#average_certificate_verification_time=$(echo "scale=4; $total_certificate_verification_time / $iterations" | bc -l)
#average_signature_verification_time=$(echo "scale=4; $total_signature_verification_time / $iterations" | bc -l)

#echo "Average time taken for certificate verification: $average_certificate_verification_time seconds"
#echo "Average time taken for signature verification: $average_signature_verification_time seconds"

