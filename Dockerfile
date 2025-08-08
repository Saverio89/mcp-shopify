FROM node:18-alpine

RUN npm install -g @shopify/dev-mcp @latitude-data/supergateway

ENV PORT=8802

CMD ["sh", "-c", "npx @latitude-data/supergateway --sse --port $PORT -- npx @shopify/dev-mcp"]

EXPOSE 8802
