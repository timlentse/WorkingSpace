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

# Install redis by compiling source code

install_redis(){
  redis_dir_name="redis-3.2.0"
  echo "Install redis by compiling from source code...\n
  version: 3.2.0\n"
  if [ -f "$redis_dir_name.tar.gz" ];then
    echo "Already Downloaded!"
    tar -xzvf redis-3.2.0.tar.gz -C /usr/local/
  else
    wget "http://download.redis.io/releases/redis-3.2.0.tar.gz"
    tar -xzvf redis-3.2.0.tar.gz -C /usr/local/
  fi
  cd "/usr/local/$redis_dir_name"
  make 
  make install
  cd 
}

# Install ruby by compiling source code

install_ruby(){
  ruby_dir_name="ruby-2.3.1"
  echo "Install ruby by compiling from source code...\n
  version: 2.3.1\n"
  if [ -f "$ruby_dir_name.tar.gz" ];then
    echo "Already downloaded!"
    tar -xzvf ruby-2.3.1.tar.gz
  else
    wget "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz"
    tar -xzvf ruby-2.3.1.tar.gz
  fi
  cd $ruby_dir_name
  ./configure
  make 
  make install
  cd 
}

# Install some important gems when ruby is ready

install_gems(){
  gem install bundler rails
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
      brew install openssl
      brew install mosh zsh git nginx mysql redis ruby
      brew install nodejs
      install_gems
      ;;
    'ubuntu')
      apt-get update
      apt-get -y install build-essential
      apt-get -y install imagemagick libmagick++-dev
      apt-get -y install mosh zsh git nginx mysql-client mysql-server libmysql++-dev libmysqlclient-dev libmysql++3
      apt-get -y install openssl libssl-dev
      apt-get -y install nodejs
      install_redis
      install_ruby
      install_gems
      ;;
    'centos')
      yum update
      yum -y install mosh zsh git nginx mysql-client mysql-server ImageMagick ImageMagick-c++-devel 
      yum -y install openssl openssl-devel
      yum -y install nodejs
      install_redis
      install_ruby
      install_gems
      ;;
  esac
}

install_stuff
install_oh_my_zsh
