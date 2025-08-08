FROM node:18-alpine

# Installiamo globalmente le dipendenze necessarie
RUN npm install -g @shopify/dev-mcp @latitude-data/supergateway

# Imposta la porta su cui il server ascolterà (Render la passerà come env PORT)
ENV PORT=8802

# Comando di avvio:
# - @latitude-data/supergateway fa da bridge MCP <-> SSE
# - "--sse" attiva la modalità Server-Sent Events (compatibile con n8n httpStreamable)
# - "npx @shopify/dev-mcp" lancia il server Shopify MCP
CMD ["sh", "-c", "npx @latitude-data/supergateway --sse --port $PORT 'npx @shopify/dev-mcp'"]

# Espone la porta per Render
EXPOSE 8802
