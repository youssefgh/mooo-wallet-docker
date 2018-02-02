#!/bin/sh
autodeploy_dir=/opt/payara41/glassfish/domains/domain1/autodeploy/
app_dir=/home/app/
archive_name=tcp-rest-proxy.war
if [ -e $autodeploy_dir/$archive_name ]
then
    echo "$archive_name exists"
else
    echo "Searching for $archive_name ..."
    until [ -f $app_dir/maven_done ]
    do
       sleep 1
    done
    echo "$archive_name found"
    mkdir $autodeploy_dir
    mv $app_dir/target/$archive_name $autodeploy_dir
    rm $app_dir/maven_done
fi
./asadmin start-domain -v
