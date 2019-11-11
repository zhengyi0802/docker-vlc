FROM ubuntu:18.04
MAINTAINER Chevy Lin

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install vlc -y

ENV VIDEOLAN_UID=1000

RUN addgroup --quiet --gid ${VIDEOLAN_UID} puser
RUN adduser --quiet --uid ${VIDEOLAN_UID} --ingroup puser puser

USER puser

