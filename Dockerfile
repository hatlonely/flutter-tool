FROM cirrusci/flutter:2.5.3 AS build

COPY flutter_tool /flutter/flutter_tool
WORKDIR /flutter/flutter_tool
RUN flutter build web

FROM nginx:1.21.1-alpine

COPY --from=build /flutter/flutter_tool/build/web /web
COPY ops/docker/default.conf /etc/nginx/conf.d/default.conf
