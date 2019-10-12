FROM docker.pkg.github.com/youssefgh/docker-git/git:2.18.1-r0  as source-downloader

ARG VERSION

MAINTAINER Youssef GHOUBACH <ghoubach.youssef@gmail.com>

WORKDIR /home

RUN git clone -b $VERSION --depth 1 https://github.com/youssefgh/mooo-wallet.git app

FROM docker.pkg.github.com/youssefgh/docker-angular-cli/angular-cli:8.3.2 as builder

ARG ENV

COPY --from=source-downloader /home/app /home/app-source

WORKDIR /home/app-source

#ignore-scripts is workaround for bitcoinjs dep to not install python
RUN npm install --ignore-scripts

RUN node angular-crypto-patch.js

RUN ng build -c=$ENV --optimization=false

FROM docker.pkg.github.com/youssefgh/docker-httpd-angular/httpd-angular:2.4.34-alpine as final

COPY --from=builder /home/app-source/dist/ /usr/local/apache2/htdocs/
