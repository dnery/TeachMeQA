#!/usr/bin/env bash

# redeploy.sh
#   1. stop tomcat server
#   2. clean out deployed archives
#   2. re-compile solution, deploy to war-file
#   2. move application to webapps folder, restart tomcat

# make sure glob expansion works alright
shopt -s globstar

tmqa_war_file_name="onboarding.war"
apache_base="apache-tomcat-9.0.13"
apache_bin_dir="${apache_base}/bin"
apache_webapps_dir="${apache_base}/webapps"

# stop tomcat server
if [[ $(curl -s -X GET http://localhost:8080/ | grep Tomcat | wc -l) > 0 ]]; then
    echo "Tomcat server running, shutting it down"
    ("./${apache_bin_dir}/shutdown.sh")
fi

# clean out already compiled objects
[[ -f "target/${tmqa_war_file_name}" ]] && mvn clean

# clean out already deployed archives
tmqa_war_file_basename=$(basename "$tmqa_war_file_name" ".war")
[[ -f "${apache_webapps_dir}/${tmqa_war_file_name}" ]] && rm "${apache_webapps_dir}/${tmqa_war_file_name}"
[[ -d "${apache_webapps_dir}/${tmqa_war_file_basename}/" ]] && rm -r "${apache_webapps_dir}/${tmqa_war_file_basename}/"

# rebuild maven project and move war file
mvn install
if [[ ! -f "target/${tmqa_war_file_name}" ]]; then
    echo "Error: ran mvn install but war file not found"
    exit 1
fi
cp "target/${tmqa_war_file_name}" "${apache_webapps_dir}/"

# re-start tomcat server
if [[ $(ss -ltn | grep 8080 | wc -l) > 0 ]]; then
    echo "Error: port 8080 is already in use"
    exit 2
fi
("./${apache_bin_dir}/startup.sh")
