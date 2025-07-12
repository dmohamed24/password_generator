# base image
FROM node:20.13-alpine AS base 
WORKDIR /usr/src/app
COPY package*.json ./

# development
FROM base AS development
ENV NODE_ENV=development
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]

# production
FROM base AS production
ENV NODE_ENV=production
RUN npm ci --only=production
COPY --chown=node:node src public ./
USER node
EXPOSE 3000
CMD ["node", "index.js"]
