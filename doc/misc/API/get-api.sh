#!/bin/sh

ALL_API_VERSIONS="1.0 1.1 1.2 1.3 1.4 1.5 1.7 1.8 1.9 2.0"

for api in $ALL_API_VERSIONS; do
  rm -f $api.json
  wget -c http://worldoftanks.ru/uc/accounts/19436/api/$api/?source_token=Intellect_Soft-WoT_Mobile-unofficial_stats -O $api.json
done
