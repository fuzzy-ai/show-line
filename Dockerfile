FROM node:6-onbuild

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/bin/node", "server.js"]
