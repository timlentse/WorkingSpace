#! /bin/sh

plantform_name=$(python -mplatform | tr '[:upper:]' '[:lower:]') 

get_distribution_name(){
  case "$plantform_name" in
    *darwin*)
      echo 'mac'
      ;;
    *ubuntu*)
      echo 'ubuntu'
      ;;
    *centos*)
      echo 'centos'
  esac
}

distribution_name=$(get_distribution_name)
arch=$(uname -m)

case "$distribution_name" in
  'ubuntu')
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    apt-get install -y apt-transport-https ca-certificates

    # Add our APT repository
    sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
    apt-get update

    # Install Passenger + Nginx
    apt-get install -y nginx-extras passenger
    ;;

  'centos')
    if ! rpm -q epel-release ; then 
      if [[ $arch == *"64"* ]] 
      then
        yum install -y yum-utils http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm; 
      else
        yum install -y yum-utils http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm;

      fi
    fi
    yum-config-manager --enable epel
    yum install -y epel-release yum-utils
    yum install -y pygpgme curl

    curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

    # Install Passenger Nginx
    yum install -y nginx passenger

  esac
