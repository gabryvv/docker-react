FROM node:16-alpine as builder
#as builder indica che siamo nella "builder" phase

USER node 

RUN mkdir -p /home/node/app

WORKDIR '/home/node/app'

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./   

RUN npm run build
#crea cartella build dove copia le cose: "/home/node/app/build" 



FROM nginx
#qui parte la nuova fase, quella prima termina perchè vede "FROM"(nginx è un webserver)

#EXPOSE 80
#questa istruzione serve per il traffico in arrivo sull'elasticbeans di AWS

COPY --from=builder /home/node/app/build /usr/share/nginx/html
#dico di copiare ciò che è stato preso nella fase precedente, da "percorso" a "destinazione"
#(la destinazione è specifica di nginx)

