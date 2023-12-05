FROM node:18

WORKDIR /app

COPY package*.json ./

# RUN npm install && npm install pm2 -g
RUN npm install 

COPY . .

EXPOSE 8080

CMD [ "node", "app.js"]
# CMD [ "pm2-runtime", "start", "npm", "--", "run", "start" ]
