FROM public.ecr.aws/docker/library/alpine:latest as base

RUN apk add --no-cache cmake gcc g++ ninja openssl-dev linux-headers curl-dev util-linux-dev

COPY ./ /var/work

RUN mkdir -p /var/work/build-folder && cd /var/work/build-folder && cmake -GNinja .. && cmake --build .

FROM public.ecr.aws/docker/library/alpine:latest as runtime

RUN apk add --no-cache libstdc++ openssl libcurl

ADD ./resources/security /var/security

ADD ./resources/configs /var/config

COPY --from=base /var/work/build-folder/azure_iot_bridge_app /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/azure_iot_bridge_app"]
