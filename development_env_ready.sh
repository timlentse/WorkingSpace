platform_name=$(python -mplatform | tr '[:upper:]' '[:lower:]')

get_distribution_name(){
  case "$platform_name" in
    *darwin*)
      echo "mac"
      ;;
    *ubuntu*)
      echo "ubuntu"
      ;;
    *centos*)
      echo "centos"
  esac
}

distribution_name=$(get_distribution_name)

# Install redis by compiling source code

install_redis(){
  echo "Which redis version you want to install?\n"
  read -p "-->: " redis_version
  echo "Install redis by compiling from source code...\nversion: $redis_version\n"
  if [ -f "redis-$redis_version.tar.gz" ];then
    tar -xzvf redis-$redis_version.tar.gz -C /usr/local/
  else
    wget "http://download.redis.io/releases/redis-$redis_version.tar.gz"
    tar -xzvf redis-$redis_version.tar.gz -C /usr/local/
  fi
  cd "/usr/local/redis-$redis_version"
  make 
  make install
  cd 
}

# Install ruby 2.3.1 by compiling source code 

install_ruby(){
  echo "Which Ruby version you want to install?\n"
  read -p "-->: " ruby_version
  echo "Install ruby by compiling from source code...\nversion: $ruby_version\n"
  if [ -f "ruby-$ruby_version.tar.gz" ];then
    tar -xzvf ruby-$ruby_version.tar.gz
  else
    wget "https://cache.ruby-lang.org/pub/ruby/${ruby_version:0:3}/ruby-$ruby_version.tar.gz"
    tar -xzvf ruby-$ruby_version.tar.gz
  fi
  cd ruby-$ruby_version
  ./configure
  make 
  make install
  cd 
}

# Install some important gems when ruby is ready

install_gems(){
  gem install bundler
}

# Install amazing tool `oh-my-zsh` 

install_oh_my_zsh(){
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

# Install stuff (zsh, mosh, git, nginx, mysql, redis, openssl ruby)

install_stuff(){
  case "$distribution_name" in
    'mac')
      brew update
      brew install mosh zsh git nginx mysql redis ruby nodejs openssl
      install_gems
      ;;
    'ubuntu')
      apt-get update
      apt-get -y install build-essential
      apt-get -y install mosh zsh git nginx mysql-client mysql-server
      apt-get -y install zlib1g zlib1g-dev
      apt-get -y install libmysql++-dev
      apt-get -y install openssl libssl-dev nodejs
      install_redis
      install_ruby
      install_gems
      ;;
    'centos')
      yum update
      yum -y install gcc mosh zsh git nginx mysql-client mysql-server
      yum -y install openssl openssl-devel nodejs
      install_redis
      install_ruby
      install_gems
      ;;
  esac
}

install_stuff
install_oh_my_zsh
