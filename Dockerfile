FROM node:24-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends python3 ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY source.tar.gz /tmp/source.tar.gz
RUN tar -xzf /tmp/source.tar.gz -C /app && rm /tmp/source.tar.gz
RUN npm ci && npm run build:render
ENV NODE_ENV=production PORT=3000
EXPOSE 3000
CMD ["node", "server.mjs"]
