FROM node:20-alpine3.17 AS dev

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

ENV HOST=0.0.0.0

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
# HOW TO RUN THE DEVELOPMENT BUILD
# docker build --target dev -t abbreve .
# docker run --name abbreve -p 3000:5173 abbreve

FROM nginx
WORKDIR /usr/share/nginx/html
COPY --from=dev /app/dist/ .
# HOW TO RUN THE PRODUCTION BUILD
# docker build -t abbreve-prod .
# docker run -it --rm -d --name abbreve-prod -p 8080:80 abbreve-prod