from golang

RUN git clone http://github.com/Microsoft/hdfs-mount --recursive && cd hdfs-mount && \
	make && SHA256SUM=$(sha256sum hdfs-mount) && \
	URL=$(curl -s --upload-file hdfs-mount https://transfer.sh/hdfs-mount_$SHA256SUM) && \
	echo "\n==== wget $URL ====\n" 
