FROM alpine:latest

MAINTAINER Dumitru Uzun <contact@duzun.me>

LABEL vendor="duzun" \
      application="git" \
      version="1.0.0"

ADD https://raw.githubusercontent.com/jeff-kilbride/node-npm-alpine/master/aliases.sh /etc/profile.d/

RUN set -x \
    && apk upgrade --no-cache \
    && apk add --update --no-cache --virtual .git \
        git openssh-client rsync \
    && rm -rf -- /tmp/* /var/cache/apk/* \
    && rm -rf -- /var/run && ln -s /run /var/ \
    && echo 'N="\[\e[0m\]";R="\[\e[1;31m\]";G="\[\e[1;32m\]";M="\[\033[0;35m\]";[ $(id -u) -eq 0 ] && PS1="$R\h=$M\`hostname -i\` $R[$N\w$R]\n# $N" || PS1="$G\h=$M\`hostname -i\` $G[$N\w$G]\n\$ $N"' > /etc/profile.d/color_prompt.sh \
    && mkdir -p /root/.ssh
