# ==========================================
# 1. Builder Stage: 의존성 설치 및 빌드
# ==========================================
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
ARG BASE_URL
ENV NEXT_PUBLIC_BASE_URL=$BASE_URL
RUN npm run build

# ==========================================
# 2. Runner Stage: 실제 실행할 이미지 
# ==========================================
FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
EXPOSE 3000
CMD ["node", "server.js"]