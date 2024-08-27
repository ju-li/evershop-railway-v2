FROM node:18-alpine
WORKDIR /app
RUN npm install -g npm@9
COPY package*.json .
COPY translations ./translations
RUN npm install
RUN npm run build


ARG ADMIN_USERNAME
ARG ADMIN_EMAIL
ARG ADMIN_PASSWORD

ENV SUPPRESS_NO_CONFIG_WARNING=true

RUN echo ${ADMIN_USERNAME}
RUN echo ${ADMIN_EMAIL}
RUN echo ${ADMIN_PASSWORD}

RUN npm run user:create -- --email "${ADMIN_EMAIL}" --password "${ADMIN_PASSWORD}" --name "${ADMIN_USERNAME}"

EXPOSE 80
CMD ["npm", "run", "start"]
