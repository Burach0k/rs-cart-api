# FROM node:9-alpine

# COPY . .

# RUN npm i --production --parseable

# RUN npm install typescript

# RUN npx tsc -p tsconfig.build.json

# RUN rm -rfv src && rm -rfv test && rm *.json && rm *.md && rm .gitignore && rm .eslintrc.js && rm .prettierrc

# RUN npm uninstall tsc && npm uninstall typescript && npm cache clean --force

# EXPOSE 8080

# CMD ["ls"]


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

# RUN rm -rfv src && rm -rfv test && rm *.md && rm .gitignore && rm .eslintrc.js && rm .prettierrc
# RUN npm i --production --parseable

# Application
USER node
ENV PORT=8080
EXPOSE 8080

ENV NODE_ENV=production

CMD ["node", "dist/main.js"]