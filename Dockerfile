FROM amazonlinux:2 as packager

RUN yum -y update \
    && yum install -y tar zip gzip bzip2-devel ed gcc gcc-c++ gcc-gfortran \
    less libcurl-devel openssl openssl-devel readline-devel xz-devel \
    zlib-devel glibc-static libcxx libcxx-devel llvm-toolset-7 zlib-static binutils \
    && rm -rf /var/cache/yum

ENV JDK_VERSION "17.0.4.9.1"
ENV JDK_FILENAME "amazon-corretto-${JDK_VERSION}-linux-x64.tar.gz"
ENV JDK_FOLDERNAME "amazon-corretto-${JDK_VERSION}-linux-x64"

RUN curl -4 -L https://corretto.aws/downloads/resources/${JDK_VERSION}/${JDK_FILENAME} | tar -xzv
RUN mv $JDK_FOLDERNAME /usr/lib/jdk17
RUN rm -rf $JDK_FOLDERNAME
ENV PATH="/usr/lib/jdk17/bin:$PATH"
RUN jlink --add-modules "$(java --list-modules | cut -f1 -d'@' | tr '\n' ',')" --compress 0 --no-man-pages --no-header-files --strip-debug --output /opt/jre17-slim
RUN find /opt/jre17-slim/lib -name *.so -exec strip -p --strip-unneeded {} \;
RUN java -Xshare:dump -version
RUN rm /opt/jre17-slim/lib/classlist
RUN cp /usr/lib/jdk17/lib/server/classes.jsa /opt/jre17-slim/lib/server/classes.jsa
RUN cd /opt/ && zip -r jre-17-slim.zip jre17-slim