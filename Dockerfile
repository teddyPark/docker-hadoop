FROM teamsprint/jdk:8

MAINTAINER Jooho Kim

USER root
  
# install dev tools
RUN yum -y install openssh-server openssh-clients rsync netstat wget
RUN yum -y update libselinux

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# hadoop
RUN wget http://mirror.23media.de/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
RUN tar -zxvf hadoop-2.7.3.tar.gz -C /opt
RUN rm -f hadoop-2.7.3.tar.gz
RUN ln -s /opt/hadoop-2.7.3 /opt/hadoop

ENV HADOOP_PREFIX /opt/hadoop
ENV HADOOP_COMMON_HOME $HADOOP_PREFIX
ENV HADOOP_HDFS_HOME $HADOOP_PREFIX
ENV HADOOP_MAPRED_HOME $HADOOP_PREFIX
ENV HADOOP_YARN_HOME $HADOOP_PREFIX
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX

ENV PATH $PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin

RUN sed -i "/^export JAVA_HOME/ s:.*:export JAVA_HOME=$JAVA_HOME:" $HADOOP_CONF_DIR/hadoop-env.sh
RUN sed -i "/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=$HADOOP_CONF_DIR:" $HADOOP_CONF_DIR/hadoop-env.sh

# pseudo distributed
ADD conf/core-site.xml $HADOOP_CONF_DIR/core-site.xml
ADD conf/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
ADD conf/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml
ADD conf/yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
ADD script/start-hadoop.sh /start-hadoop.sh
ADD script/test-hadoop.sh /test-hadoop.sh

RUN $HADOOP_PREFIX/bin/hdfs namenode -format

# sshd
ADD conf/ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

# workingaround docker.io build error
RUN ls -la $HADOOP_CONF_DIR/*-env.sh
RUN chmod +x $HADOOP_CONF_DIR/*-env.sh
RUN ls -la $HADOOP_CONF_DIR/*-env.sh

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

#CMD ["/etc/bootstrap.sh", "-bash"]
CMD ["/bin/bash"]

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090

# Mapred ports
EXPOSE 19888

# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088

# Other ports
EXPOSE 49707 2122  

