from go

RUN git clone http://github.com/Microsoft/hdfs-mount --recursive && cd hdfs-mount && \
	make && echo $(sha256sum hdfs-mount) > hdfs-mount-with-sha && base64 hdfs-mount >> hdfs-mount-with-sha && \
	URL=$(curl -s --upload-file hdfs-mount-with-sha https://transfer.sh/hdfs-mount-with-sha) && \
	echo "wget $URL && tail -n +2 hdfs-mount-with-sha |base64 -d > hdfs-mount" 
