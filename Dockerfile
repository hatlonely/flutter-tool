FROM cirrusci/flutter:2.2.3 AS build

COPY flutter_tool /flutter/flutter_tool
WORKDIR /flutter/flutter_tool
RUN flutter build web

FROM nginx:1.21.1-alpine

COPY --from=build /flutter/flutter_tool/build/web /web
