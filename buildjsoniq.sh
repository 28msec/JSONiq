#!/bin/bash
SPEC_PATH=/home/gislenius/github/JSONiq

if [ -z $1 ]
then
  SPECS=(JSONiq JSONiqExtensionToXQuery JSONiq-usecases JSONiqExtensionToXQuery-usecases JSound Introduction_to_JSONiq)
else 
  SPECS=$1
fi

for spec in "${SPECS[@]}"
do
  if [ $spec = "JSONiq" -o $spec = "JSONiq-usecases" -o $spec = "Introduction_to_JSONiq" ]
  then
    echo Executing queries...
    docker run -v $SPEC_PATH/$spec:/queries zorba -f -q compute.xq
  fi
  cd $SPEC_PATH/$spec;
  echo Compiling book: $spec...
  publican build -formats pdf,html,html-single --langs en-US;
done
for spec in "${SPECS[@]}"
do
  rm -rf $SPEC_PATH/web/docs/$spec/*
  cp -r $SPEC_PATH/$spec/tmp/en-US/* $SPEC_PATH/web/docs/$spec/
done
