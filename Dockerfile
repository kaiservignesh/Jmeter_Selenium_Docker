FROM alpine

ARG JMETER_VERSION="5.4.1"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV JAVA_OPTS -Dwebdriver.chrome.whitelistedIps


ARG TZ="Europe/London"
ENV TZ ${TZ}
RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk8-jre tzdata curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \
	&& apk add chromium \
	&& apk add chromium-chromedriver
	
#=================================
# Chrome Launch Script Wrapper
#=================================
COPY wrap_chromium_binary /opt/bin/wrap_chromium_binary
RUN chmod 777 /opt/bin/wrap_chromium_binary
RUN /opt/bin/wrap_chromium_binary
	
	
ENV PATH $PATH:${JMETER_BIN}

COPY ./apache-jmeter-5.4.1/. /opt/apache-jmeter-5.4.1/.
COPY entrypoint.sh /
RUN chmod 777 /usr/bin/chromedriver
RUN cp /usr/bin/chromedriver /opt/apache-jmeter-5.4.1/bin/.

WORKDIR ${JMETER_HOME}

RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

