#!/bin/sh
#Read the secrets list from secret manager and get the values from GCP secret manager
PROJECT_ID=
gcloud config set project $PROJECT_ID
input="/home/inala_k/shell_scripts/secret_input_list"

while IFS= read -r line
do
  value=$(gcloud secrets versions access latest --secret=$line)
  echo  -e "$line" '\t' "$value" >> secret_output_value
done < "$input"
#sed -i '1ab---------------------------------' secret_output_value
#sed -i '1i SECRET_ID \t SECRET_VALUE' secret_output_value
