#! /bin/bash

DOCKER_TAG=$1
DOCKERRUN_FILE=$DOCKER_TAG-Dockerrun.aws.json
EB_BUCKET=$DEPLOYMENT_BUCKET/$BUCKET_DIRECTORY

echo "REGION=$REGION"
echo "AWS_APPLICATION_NAME=$AWS_APPLICATION_NAME"
echo "DOCEKR_TAG=$DOCKER_TAG"
echo "DOCKERRUN_FILE=$DOCKERRUN_FILE"
echo "DEPLOYMENT_BUCKET=$DEPLOYMENT_BUCKET"
echo "BUCKET_DIRECTORY=$BUCKET_DIRECTORY"
echo "IMAGE_NAME=$IMAGE_NAME"

# Run aws command to create a new EB application with label
# aws elasticbeanstalk create-application-version --region=$REGION --application-name $AWS_APPLICATION_NAME \
    # --version-label $DOCKER_TAG --source-bundle S3Bucket=$DEPLOYMENT_BUCKET,S3Key=$BUCKET_DIRECTORY/$DOCKERRUN_FILE

    aws elasticbeanstalk create-application-version \
      --application-name tomstar \
      --version-label $DOCKER_TAG \
      --source-bundle S3Bucket=$DEPLOYMENT_BUCKET,S3Key=$BUCKET_DIRECTORY/$DOCKERRUN_FILE \
      --region us-east-1

    # Update Elastic Beanstalk environment to new version
    aws elasticbeanstalk update-environment \
      --environment-name tomstar \
      --version-label $DOCKER_TAG \
      --region us-east-1

# Update Elastic Beanstalk environment to new version (in case we want continuous delivery)
# aws elasticbeanstalk update-environment --region=us-east-1 --environment-name idsp-management-prod --version-label $SHA1
