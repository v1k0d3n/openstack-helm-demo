#!/bin/bash
# Copyright 2017 Charter DNA Team (CTEC).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
### Declare colors to use during the running of this script:
declare -r GREEN="\033[0;32m"
declare -r RED="\033[0;31m"
declare -r YELLOW="\033[0;33m"

function echo_green {
  echo -e "${GREEN}$1"; tput sgr0
}
function echo_red {
  echo -e "${RED}$1"; tput sgr0
}
function echo_yellow {
  echo -e "${YELLOW}$1"; tput sgr0
}

HOST_IP=$(ip route get 1 | awk '{print $NF;exit}')
export OS_IMAGE_TAG=3.0.3

IMAGES[0]=quay.io/stackanetes/kubernetes-entrypoint:v0.2.1
IMAGES[1]=ubuntu:16.04
IMAGES[2]=kolla/ubuntu-source-rally:4.0.0
IMAGES[3]=quay.io/attcomdev/ceph-daemon:tag-build-master-jewel-ubuntu-16.04
IMAGES[4]=port/ceph-config-helper:v1.7.5
IMAGES[5]=quay.io/external_storage/rbd-provisioner:v0.1.1
IMAGES[6]=kolla/ubuntu-source-cinder-api:${OS_IMAGE_TAG}
IMAGES[7]=kolla/ubuntu-source-cinder-scheduler:${OS_IMAGE_TAG}
IMAGES[8]=kolla/ubuntu-source-cinder-volume:${OS_IMAGE_TAG}
IMAGES[9]=kolla/ubuntu-source-cinder-backup:${OS_IMAGE_TAG}
IMAGES[10]=gcr.io/google_containers/etcd-amd64:2.2.5
IMAGES[11]=kolla/ubuntu-source-glance-api:${OS_IMAGE_TAG}
IMAGES[12]=kolla/ubuntu-source-glance-registry:${OS_IMAGE_TAG}
IMAGES[13]=kolla/ubuntu-source-glance-api:${OS_IMAGE_TAG}
IMAGES[14]=kolla/ubuntu-source-glance-registry:${OS_IMAGE_TAG}
IMAGES[15]=kolla/ubuntu-source-heat-engine:${OS_IMAGE_TAG}
IMAGES[16]=kolla/ubuntu-source-heat-api:${OS_IMAGE_TAG}
IMAGES[17]=kolla/ubuntu-source-horizon:4.0.0
IMAGES[18]=gcr.io/google_containers/nginx-ingress-controller:0.9.0-beta.8
IMAGES[19]=gcr.io/google_containers/defaultbackend:1.0
IMAGES[20]=kolla/ubuntu-source-keystone:${OS_IMAGE_TAG}
IMAGES[21]=kolla/ubuntu-source-nova-libvirt:${OS_IMAGE_TAG}
IMAGES[22]=mariadb:10.1.23
IMAGES[23]=memcached:1.4
IMAGES[24]=kolla/ubuntu-source-neutron-server:${OS_IMAGE_TAG}
IMAGES[25]=kolla/ubuntu-source-neutron-dhcp-agent:${OS_IMAGE_TAG}
IMAGES[26]=kolla/ubuntu-source-neutron-metadata-agent:${OS_IMAGE_TAG}
IMAGES[27]=kolla/ubuntu-source-neutron-l3-agent:${OS_IMAGE_TAG}
IMAGES[28]=kolla/ubuntu-source-neutron-openvswitch-agent:${OS_IMAGE_TAG}
IMAGES[29]=kolla/ubuntu-source-neutron-linuxbridge-agent:${OS_IMAGE_TAG}
IMAGES[30]=kolla/ubuntu-source-nova-api:${OS_IMAGE_TAG}
IMAGES[31]=kolla/ubuntu-source-nova-conductor:${OS_IMAGE_TAG}
IMAGES[32]=kolla/ubuntu-source-nova-scheduler:${OS_IMAGE_TAG}
IMAGES[33]=kolla/ubuntu-source-nova-novncproxy:${OS_IMAGE_TAG}
IMAGES[34]=kolla/ubuntu-source-nova-consoleauth:${OS_IMAGE_TAG}
IMAGES[35]=kolla/ubuntu-source-nova-compute:${OS_IMAGE_TAG}
IMAGES[36]=kolla/ubuntu-source-nova-ssh:${OS_IMAGE_TAG}
IMAGES[37]=kolla/ubuntu-source-openvswitch-db-server:${OS_IMAGE_TAG}
IMAGES[38]=kolla/ubuntu-source-openvswitch-vswitchd:${OS_IMAGE_TAG}
IMAGES[39]=quay.io/attcomdev/fuel-mcp-rabbitmq:ocata-unstable
IMAGES[40]=kolla/ubuntu-source-kolla-toolbox:${OS_IMAGE_TAG}

echo_yellow "\nTagging Container Images:"
for IMAGE in "${IMAGES[@]}"
do
sudo docker tag $IMAGE $HOST_IP/library/$IMAGE
done
echo_yellow "\nAttempting to upload images into container registry:"
for IMAGE in "${IMAGES[@]}"
do
sudo docker push $HOST_IP/library/$IMAGE
done

echo_green "\nCOMPLETE!"
