#!/bin/bash

CURRENT_DATE=$(date "+%m.%d.%Y")

echo " "
echo "Creating new bucket for $CURRENT_DATE..."

aws s3 mb s3://$CURRENT_DATE-brandt13-backups --region us-west-2

echo " "
echo "Bucket made."

cd /Users/brandtleeds/Documents/CodingNomads/scripts/uploadToS3

echo "Copying .txt files to new bucket..."

aws s3 cp . s3://$CURRENT_DATE-brandt13-backups/ --recursive --exclude "*" --include "*.txt"

echo "Done."

echo "Copying image files to new bucket..."

aws s3 cp . s3://$CURRENT_DATE-brandt13-backups/ --recursive --exclude "*" --include "*.jpg"
aws s3 cp . s3://$CURRENT_DATE-brandt13-backups/ --recursive --exclude "*" --include "*.png"

echo "Done."

rm -r *.txt
rm -r *.jpg
rm -r *.png

echo "Making new directory..."

mkdir $CURRENT_DATE

echo "Done."

cd $CURRENT_DATE

echo "Copying from AWS..."

aws s3 cp s3://$CURRENT_DATE-brandt13-backups/ . --recursive --exclude "*" --include "*.txt"
aws s3 cp s3://$CURRENT_DATE-brandt13-backups/ . --recursive --exclude "*" --include "*.jpg"
aws s3 cp s3://$CURRENT_DATE-brandt13-backups/ . --recursive --exclude "*" --include "*.png"

echo "Done."

echo "End of script."
