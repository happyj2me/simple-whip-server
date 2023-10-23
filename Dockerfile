FROM node:18.18.2
RUN useradd --user-group --create-home --shell /bin/false kevin && \
    apt-get clean
RUN apt-get update -y && apt-get install -y net-tools
RUN apt-get update -y && apt-get install -y iputils-ping
ENV HOME=/home/kevin
COPY package.json $HOME/app/
COPY src/ $HOME/app/src
COPY web/ $HOME/app/web
RUN chown -R kevin:kevin $HOME/* /usr/local/
WORKDIR $HOME/app
RUN npm run build
RUN chown -R kevin:kevin $HOME/*
USER kevin
CMD ["npm", "start"]