FROM node:12-alpine as build

# Dependencies
COPY package*.json ./
RUN npm install

# Build
COPY . .
RUN npm run build


FROM node:9-alpine

# Dependencies
COPY --from=build ./dist ./dist
COPY package.json .
RUN npm install --production --parseable

# Application
USER node
ENV PORT=8080
EXPOSE 8080

ENV NODE_ENV=production

CMD ["node", "dist/main.js"]