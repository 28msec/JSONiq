#!/bin/bash
SPEC_PATH=/Users/systemsgroup/code/box/JSONiq-specs

if [ -z $1 ]
then
  SPECS=(JSONiq JSONiqExtensionToXQuery JSONiq-usecases JSONiqExtensionToXQuery-usecases JSound Introduction_to_JSONiq)
else 
  SPECS=$1
fi

cd /Users/systemsgroup/code/box

echo --------------------
echo Executing queries...
echo --------------------
cd $SPEC_PATH/JSONiq
zorba -f -q compute.xq
cd $SPEC_PATH/JSONiq-usecases
zorba -f -q compute.xq
cd $SPEC_PATH/Introduction_to_JSONiq
zorba -f -q compute.xq

echo ------------------
echo Compiling books...
echo ------------------
cd /Users/systemsgroup/code/box

for spec in "${SPECS[@]}"
do	
  vagrant ssh -c "cd /vagrant/JSONiq-specs/$spec; publican build -formats pdf,html,html-single --langs en-US";
done

echo -------------------
echo Creating archive...
echo -------------------

for spec in "${SPECS[@]}"
do
  rm -rf $SPEC_PATH/web/docs/$spec/*
  cp -r $SPEC_PATH/$spec/tmp/en-US/* $SPEC_PATH/web/docs/$spec/
done