FROM centos:centos7

RUN yum install -y java-1.8.0-openjdk
RUN yum install -y java-1.8.0-openjdk-devel

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/jre

ENV JAVA=/usr/lib/jvm/java-openjdk/bin/java

ARG jetty_dist=jetty-distribution-9.2.21.v20170120

RUN yum -y install wget



RUN wget http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.2.21.v20170120/${jetty_dist}.tar.gz && tar -xzvf ${jetty_dist}.tar.gz -C /opt/

RUN rm ${jetty_dist}.tar.gz

RUN mv /opt/${jetty_dist} /opt/jetty

RUN groupadd -r jetty && useradd -r -g jetty jetty

RUN chown -R jetty:jetty /opt/jetty/

#RUN ln -s /opt/jetty/bin/jetty.sh /etc/init.d/jetty

#RUN chkconfig --add jetty

#RUN chkconfig --level 345 jetty on

COPY jetty.config /etc/default/jetty
#RUN mkdir /opt/jetty/run

#RUN chown jetty /opt/jetty/run

#COPY jetty.config /opt/jetty/run

EXPOSE 8080

USER jetty

#CMD [ "/opt/jetty/bin/jetty.sh","start" ]
WORKDIR /opt/jetty 
CMD [ "java","-jar","start.jar"]
