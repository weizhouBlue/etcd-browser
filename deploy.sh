#!/bin/bash


etcd_server_port=12379
etcd_server_ip="10.6.185.110"


hostpath_etcd_ca=`find /etc -name "etcd-ca"`
hostpath_etcd_cert=`find /etc -name "etcd-cert"`
hostpath_etcd_key=`find /etc -name "etcd-key"`

#------------------------------------------

path_etcd_ca=`basename $hostpath_etcd_ca`
path_etcd_cert=`basename $hostpath_etcd_cert`
path_etcd_key=`basename $hostpath_etcd_key`

image_name="weizhoulan/etcd-browser:latest"
docker pull $image_name
docker run  --name etcd-browser -p 0.0.0.0:8000:8000 \
    --env ETCD_HOST=$etcd_server_ip --env ETCD_PORT=$etcd_server_port \
    --env ETCDCTL_KEY_FILE=/var/$path_etcd_key --env ETCDCTL_CA_FILE=/var/$path_etcd_ca --env ETCDCTL_CERT_FILE=/var/$path_etcd_cert  \
    -v $hostpath_etcd_ca:/var/$path_etcd_ca   -v $hostpath_etcd_cert:/var/$path_etcd_cert    -v $hostpath_etcd_key:/var/$path_etcd_key     \
    -t -d -i $image_name



