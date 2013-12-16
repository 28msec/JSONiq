#!/bin/bash
SPEC_PATH=/Users/systemsgroup/code/box/JSONiq-specs
cd $SPEC_PATH/web
tar czvf jsoniq.tar.gz *
scp -r $SPEC_PATH/web/jsoniq.tar.gz root@jsoniq.org:/var/www/html/
ssh root@jsoniq.org "cd /var/www/html; tar xzvf jsoniq.tar.gz"