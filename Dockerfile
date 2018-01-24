FROM ubuntu:16.04

ARG UID=1000
ARG CODE_URL=https://api.github.com/repos/qiyeboy/IPProxyPool/tarball

RUN  apt-get update && apt-get install -y\
         python3-dev python3-pip wget gcc sqlite3 --no-install-recommends && \

     mkdir -p /var/www && wget -qO- ${CODE_URL} | tar xvz -C /var/www --strip-components=1 && \

     pip3 install setuptools && \
     pip3 install chardet \
         gevent \
         greenlet \
         lxml \
         requests \
         SQLAlchemy \
         web.py==0.40.dev0 \
         psutil && \

     apt-get purge -y wget gcc && apt-get autoremove -y --purge && apt-get autoclean -y && \
     rm -rf /var/lib/apt/lists/* && \

     usermod -u ${UID} www-data && chown -R www-data /var/www

WORKDIR /var/www
USER www-data
EXPOSE 8000

CMD ["python3", "IPProxy.py"]
