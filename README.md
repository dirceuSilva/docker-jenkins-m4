# docker-jenkins-m4

You need to have this files in the directory: 
 - config
 - credentials
 - okplugins.list
 - jenkins.version
 - settings.xml

```
# In the case of this: http://askubuntu.com/questions/186847/error-gnutls-handshake-failed-when-connecting-to-https-servers
RUN apt-get update \
    && apt-get install -y build-essential fakeroot dpkg-dev libcurl4-openssl-dev \
    && apt-get build-dep -y git \
    && mkdir ~/git-openssl \
    && cd ~/git-openssl \
    && apt-get source -y git \
    && dpkg-source -x git_`git version | cut -d' ' -f3`-1ubuntu0.3.dsc \
    && cd git-`git version | cut -d' ' -f3` \
    && sed -i 's/libcurl4-gnutls-dev/libcurl4-openssl-dev/g' debian/control \
    && sed -i 's/TEST =test//g' debian/rules \
    && dpkg-buildpackage -rfakeroot -b -d \
    && dpkg -i ../git_`git version | cut -d' ' -f3`_amd64.deb
```
