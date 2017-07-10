FROM jupyter/datascience-notebook

USER root

RUN  DEBIAN_FRONTEND=noninteractive apt-get update \
     && DEBIAN_FRONTEND=noninteractive apt-get install -y libapparmor1 libedit2 lsb-release libbsd0 \
     && apt-get autoclean -y && rm -rf /var/lib/apt/lists/* \
     && RSTUDIO_VERSION=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) \
	&& RSTUDIO_DEB=rstudio-server-${RSTUDIO_VERSION}-amd64.deb \
	&& wget -q "http://172.17.0.1:8000/${RSTUDIO_DEB}" \
	|| wget -q "http://download2.rstudio.org/${RSTUDIO_DEB}" \
        && ls -alh \

     && dpkg -i ${RSTUDIO_DEB} \
     && echo rsession-which-r=/opt/conda/bin/R >> /etc/rstudio/rserver.conf \
     && sed -e '/echo "Execute the command as $NB_USER"/a \ \ \ \ su $NB_USER -c "nohup /usr/sbin/rstudio-server start 2>&1 >> /tmp/rstudio-server.log&"' \
	    -e '/echo "Execute the command"/a \ \ \ \ nohup /usr/sbin/rstudio-server start 2>&1 >> /tmp/rstudio-server.log&' \
	    -i /usr/local/bin/start.sh \

     && rm -rf ${RSTUDIO_DEB}

USER $NB_USER

EXPOSE 8787
