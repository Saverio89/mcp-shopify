FROM node:18-alpine

WORKDIR /app

# Copia package.json e installa dipendenze
COPY package.json ./
RUN npm install

# Installa globalmente il server MCP di Shopify
RUN npm install -g @shopify/dev-mcp

# Copia il codice server
COPY server.js .

ENV PORT=8802
EXPOSE 8802

CMD ["npm", "start"]
