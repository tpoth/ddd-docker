# -[BUILD STAGE]-----------------

FROM node:16.13.0-alpine AS BUILD

USER node
WORKDIR /home/node

ADD --chown=node:node package.json .
ADD --chown=node:node package-lock.json .

RUN npm install

ADD --chown=node:node . .

RUN npx tsc

# -[PRODUCTION STAGE]------------

FROM node:16.13.0-alpine as PROD

USER node
WORKDIR /home/node

COPY --from=BUILD /home/node/package.json ./package.json
COPY --from=BUILD /home/node/package.json ./package.json
COPY --from=BUILD /home/node/build ./build
COPY --from=BUILD /home/node/public ./public

RUN npm install --production

CMD [ "node", "build/app.js" ]
