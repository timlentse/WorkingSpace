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

# install redis
install_redis(){
  echo "Install redis by compiling from source code...\n
  version: 3.2.0\n"
  wget "http://download.redis.io/releases/redis-3.2.0.tar.gz"
  tar -xzvf redis-3.2.0.tar.gz -C /usr/local/
  cd /usr/local/redis-3.2.0  
  make 
}

# install ruby
install_ruby(){
  echo "Install ruby by compiling from source code...\n
  version: 2.3.1\n"
  wget "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz"
  tar -xzvf ruby-2.3.1.tar.gz 
  cd ruby-2.3.1
  ./configure
  make 
  make install
}

# install stuff (git, nginx, mysql, redis, openssl ruby)
install_stuff(){
  case "$distribution_name" in
    'mac')
      brew update
      brew install git nginx mysql redis
      brew install openssl
      ;;
    'ubuntu')
      apt-get update
      apt-get install build-essential
      apt-get install git nginx mysql-client mysql-server libmysql++-dev libmysqlclient-dev libmysql++3
      install_redis
      apt-get install openssl libssl-dev
      install_ruby
      ;;
    'centos')
      yum update
      yum install git nginx mysql-client mysql-server
      install_redis
      yum install openssl openssl-devel
      ;;
  esac
}

install_stuff
