FROM mooo.tech/git:2.18.0-r0  as source-downloader

ARG VERSION

MAINTAINER Youssef GHOUBACH <ghoubach.youssef@gmail.com>

WORKDIR /home

RUN git clone -b $VERSION --depth 1 https://github.com/youssefgh/mooo-wallet.git app

FROM mooo.tech/angular-cli:8.3.2 as builder

ARG ENV

COPY --from=source-downloader /home/app /home/app-source

WORKDIR /home/app-source

#ignore-scripts is workaround for bitcoinjs dep to not install python
RUN npm install --ignore-scripts

RUN node angular-crypto-patch.js

RUN ng build -c=$ENV --optimization=false

FROM mooo.tech/httpd-angular:2.4.34-alpine as final

COPY --from=builder /home/app-source/dist/ /usr/local/apache2/htdocs/
