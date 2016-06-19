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
  redis_dir_name=/usr/local/redis-3.2.0
  echo "Install redis by compiling from source code...\n
  version: 3.2.0\n"
  if [ -d "$redis_dir_name" ];then
    echo "Already Downloaded!"
  else
    wget "http://download.redis.io/releases/redis-3.2.0.tar.gz"
    tar -xzvf redis-3.2.0.tar.gz -C /usr/local/
  fi
  cd "$redis_dir_name"
  make 
  make install
  cd 
}

# install ruby
install_ruby(){
  ruby_dir_name="ruby-2.3.1"
  echo "Install ruby by compiling from source code...\n
  version: 2.3.1\n"
  if [ -d "$ruby_dir_name" ];then
    echo "Already downloaded!"
  else
    wget "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz"
    tar -xzvf ruby-2.3.1.tar.gz
  fi
  cd $dir_name
  ./configure
  make 
  make install
  cd 
}

# install oh-my-zsh 
install_oh_my_zsh(){
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

}
# install stuff (zsh, mosh, git, nginx, mysql, redis, openssl ruby)
install_stuff(){
  case "$distribution_name" in
    'mac')
      brew update
      brew install mosh zsh git nginx mysql redis
      brew install openssl
      brew install nodejs
      ;;
    'ubuntu')
      apt-get update
      apt-get -y install build-essential
      apt-get -y install imagemagick libmagick++-dev
      apt-get -y install mosh zsh git nginx mysql-client mysql-server libmysql++-dev libmysqlclient-dev libmysql++3
      install_redis
      apt-get -y install openssl libssl-dev
      # for js runtime 
      apt-get -y install nodejs
      install_ruby
      ;;
    'centos')
      yum update
      yum -y install mosh zsh git nginx mysql-client mysql-server
      install_redis
      yum -y install openssl openssl-devel
      yum -y install nodejs
      ;;
  esac
}

install_stuff
install_oh_my_zsh
