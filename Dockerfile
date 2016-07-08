FROM centos:6.8
MAINTAINER showwin <showwin.czy@gmail.com>

# set timezone JST
RUN /bin/cp -p  /usr/share/zoneinfo/Japan /etc/localtime

RUN yum update -y && \
    rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# install tools
RUN yum -y install epel-release git tar bzip2 gcc make ruby-devel readline-devel openssl-devel qt-devel qt5-qtwebkit-devel patch mysql-devel gcc-c++ libmysqld-dev vim-tiny

# install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build

WORKDIR /app

# Install ruby & base gems
RUN CONFIGURE_OPTS="--disable-install-doc" ruby-build -v 2.2.4 /usr/local && \
    gem install bundler rubygems-bundler --no-rdoc --no-ri && \
    gem regenerate_binstubs && \
    rm -rf /tmp/ruby-build*

# use bundle container & set RAILS_ENV
ENV BUNDLE_GEMFILE=/app/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle \
    RAILS_ENV=development \
    LANG=ja_JP.UTF-8

# bundle
ADD Gemfile* /app/
RUN cp /usr/lib64/qt5/bin/qmake /usr/bin/qmake
RUN bundle install --jobs 20 --retry 5

# Rails app
ADD . /app
