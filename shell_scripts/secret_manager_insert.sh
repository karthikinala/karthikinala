#!/bin/bash
#Script to insert secret manager secrts from a file

PROJECT_ID=
gcloud config set project $PROJECT_ID
while read -r secretid secretvalue
do
  echo $secretvalue | sed -e "s/ //g"
  version=($(gcloud secrets versions list $secretid | awk '{if(NR>1)print}' | awk 'NR==1{print $1}'))
  gcloud secrets versions disable $version --secret=$secretid
  echo -n $secretvalue | gcloud secrets versions add $secretid --data-file=-
  echo "-------------------------------------------------------"
done < secret.txt

