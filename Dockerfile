FROM ubuntu:24.04

WORKDIR /app

RUN apt-get update 
RUN apt-get upgrade 
RUN apt-get -y install curl tar vim build-essential

RUN mkdir /appInstall

RUN curl -o /appInstall/libc6-i386_2.39-0ubuntu8.3_amd64.deb  http://security.ubuntu.com/ubuntu/pool/main/g/glibc/libc6-i386_2.39-0ubuntu8.3_amd64.deb 
RUN dpkg -i /appInstall/libc6-i386_2.39-0ubuntu8.3_amd64.deb

RUN curl -o /appInstall/linux64.hla.tar.gz https://www.plantation-productions.com/Webster/HighLevelAsm/HLAv2.16/linux64.hla.tar.gz

RUN tar -xvzf /appInstall/linux64.hla.tar.gz -C /appInstall

ENV hlalib=/appInstall/usr/hla/hlalib \
    hlainc=/appInstall/usr/hla/include \
    hlatemp=/tmp

RUN cp /appInstall/usr/hla/hla /usr/bin
RUN cp /appInstall/usr/hla/hlaparse /usr/bin

ENTRYPOINT [ "hla", "index.hla" ]
