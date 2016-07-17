FROM ciandtsoftware/jenkins-aws

MAINTAINER CI&T-TEAM

USER root

RUN apt-get update \
    && apt-get install -y libcurl4-openssl-dev libxml2-dev libxslt1-dev libsqlite3-dev libmysqlclient-dev libpq-dev libevent-dev libreadline-dev build-essential 

RUN gem install pkgr compass

RUN mkdir /home/ubuntu && chown jenkins:jenkins /home/ubuntu

RUN apt-get update && apt-get install -y software-properties-common

# Install Java 8.
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get remove -y openjdk-7-jdk && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

USER jenkins

# In the case of this: http://askubuntu.com/questions/186847/error-gnutls-handshake-failed-when-connecting-to-https-servers
# RUN apt-get update \
#    && apt-get install -y build-essential fakeroot dpkg-dev libcurl4-openssl-dev \
#    && apt-get build-dep -y git \
#    && mkdir ~/git-openssl \
#    && cd ~/git-openssl \
#    && apt-get source -y git \
#    && dpkg-source -x git_`git version | cut -d' ' -f3`-1ubuntu0.3.dsc \
#    && cd git-`git version | cut -d' ' -f3` \
#    && sed -i 's/libcurl4-gnutls-dev/libcurl4-openssl-dev/g' debian/control \
#    && sed -i 's/TEST =test//g' debian/rules \
#    && dpkg-buildpackage -rfakeroot -b -d \
#    && dpkg -i ../git_`git version | cut -d' ' -f3`_amd64.deb

# You need to have this files in the directory: 
# - config
# - credentials
# - okplugins.list
# - jenkins.version
# - settings.xml
