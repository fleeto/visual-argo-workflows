FROM node:lts-bookworm-slim AS build
WORKDIR /app
COPY services/ui/ ./
RUN npm install
RUN npm run build

FROM node:lts-bookworm-slim AS production
WORKDIR /app
COPY --from=build /app/package*.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/build ./build
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]