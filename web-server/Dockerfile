FROM mooo.tech/git:2.18.0-r0  as source-downloader

ARG VERSION

MAINTAINER Youssef GHOUBACH <ghoubach.youssef@gmail.com>

WORKDIR /home

RUN git clone https://github.com/youssefgh/tcp-rest-proxy.git app

RUN git -C app checkout $VERSION

FROM mooo.tech/maven:3.6.1-r0 as builder

COPY --from=source-downloader /home/app /home/app-source

WORKDIR /home/app-source

RUN mvn package

FROM mooo.tech/payara:5.192

ARG CONTEXT

MAINTAINER Youssef GHOUBACH <ghoubach.youssef@gmail.com>

COPY --from=builder /home/app-source/target/app.war /home/

RUN echo "deploy --name $CONTEXT /home/app.war" > /home/postbootcommand

CMD /opt/payara5/glassfish/bin/asadmin start-domain -v --postbootcommandfile=/home/postbootcommand production
