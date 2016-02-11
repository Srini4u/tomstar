#! /bin/bash
DOCKER_TAG=$1

# Dockerrun template
DOCKERRUN_TEMPLATE=./Dockerrun.aws.json.template
# Name of the new file
DOCKERRUN_FILE=$DOCKER_TAG-Dockerrun.aws.json
# AWS S3 bucket path
S3_PATH="s3://$DEPLOYMENT_BUCKET/$BUCKET_DIRECTORY/"

# Replacing tags in the file and creating a file.
sed 's/<TAG>/$DOCKER_TAG/' -e 's/<DEPLOYMENT_BUCKET>/$DEPLOYMENT_BUCKET/'  Dockerrun.aws.json.template > $DOCKERRUN_FILE

# Uploading json file to $S3_PATH
aws s3 cp $DOCKERRUN_FILE $S3_PATH
