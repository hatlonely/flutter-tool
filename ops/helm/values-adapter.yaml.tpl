name: "${NAME}"
replicaCount: "${REPLICA_COUNT}"

image:
  repository: "${REGISTRY_ENDPOINT}/${REGISTRY_NAMESPACE}/${IMAGE_REPOSITORY}"
  tag: "${IMAGE_TAG}"
  pullPolicy: Always
  pullSecret: "${PULL_SECRET_NAME}"

ingress:
  enable: true
  host: "${INGRESS_HOST}"
  secretName: "${SECRET_NAME}"

config:
  default.conf: |
    server {
      listen       80;
      server_name  "${INGRESS_HOST}";

      location / {
          root   /web;
          index  index.html index.htm;
      }

      error_page   500 502 503 504  /50x.html;
      location = /50x.html {
          root   /usr/share/nginx/html;
      }
    }