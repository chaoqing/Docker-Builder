FROM ubuntu:16.04

ARG UID=1000
ARG GID=1000
ARG PROXY=

ENV USERNAME firefox

RUN test -z PROXY || echo "Acquire::http { Proxy \"${PROXY}\"; };" >> /etc/apt/apt.conf.d/01proxy \
	&& apt-get update \
	&& apt-get install -y firefox language-pack-zh-hans ttf-wqy-microhei --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /home/${USERNAME} /etc/sudoers.d \
	&& echo "${USERNAME}:x:${UID}:${GID}:Developer,,,:/home/${USERNAME}:/bin/bash" >> /etc/passwd \
	&& echo "${USERNAME}:x:${UID}:" >> /etc/group \
	&& echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME} \
	&& chmod 0440 /etc/sudoers.d/${USERNAME} \
	&& chown ${UID}:${GID} -R /home/${USERNAME}

USER ${USERNAME}
ENV HOME /home/${USERNAME}
CMD /usr/bin/firefox
