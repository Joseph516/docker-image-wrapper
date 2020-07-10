#!/bin/bash

# 文件名
# kubeadm config images list
images=(
  k8s.gcr.io/kube-apiserver:v1.15.2
  k8s.gcr.io/kube-controller-manager:v1.15.2
  k8s.gcr.io/kube-scheduler:v1.15.2
  k8s.gcr.io/kube-proxy:v1.15.2
  k8s.gcr.io/pause:3.1
  k8s.gcr.io/etcd:3.3.10
  k8s.gcr.io/coredns:1.3.1
)

i=0;
while (($i<${#images[@]}))
do
  image=${images[$i]} # k8s.gcr.io/kube-apiserver:v1.15.2
  tmp=${image#*/} # kube-apiserver:v1.15.2
  dir=${tmp%:*} # kube-apiserver

  if [ ! -d $dir  ];then
    mkdir $dir
  # else
  #   echo $dir} exist
  fi

  dock_f=$dir/Dockerfile
  # 如果Dockerfile不存在则新建
  # if [ ! -d $dock_f ];then
  #   touch $dock_f
  # fi
  echo -e "FROM $image\nMAINTAINER joe <joe.hyhznx@gmail.com>" > $dock_f
  let i=$i+1
done


