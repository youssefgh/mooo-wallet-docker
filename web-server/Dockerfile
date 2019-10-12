FROM docker.pkg.github.com/youssefgh/docker-git/git:2.18.1-r0  as source-downloader

ARG VERSION

MAINTAINER Youssef GHOUBACH <ghoubach.youssef@gmail.com>

WORKDIR /home

RUN git clone https://github.com/youssefgh/tcp-rest-proxy.git app

RUN git -C app checkout $VERSION

FROM docker.pkg.github.com/youssefgh/docker-maven/maven:3.6.1-r0 as builder

COPY --from=source-downloader /home/app /home/app-source

WORKDIR /home/app-source

RUN mvn package

FROM docker.pkg.github.com/youssefgh/docker-payara/payara:5.193.1

MAINTAINER Youssef GHOUBACH <ghoubach.youssef@gmail.com>

COPY --from=builder /home/app-source/target/app.war /home/

RUN echo "deploy --contextroot / /home/app.war" > /home/postbootcommand

CMD /opt/payara5/glassfish/bin/asadmin start-domain -v --postbootcommandfile=/home/postbootcommand production
