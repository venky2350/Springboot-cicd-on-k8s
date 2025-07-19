# Base image
FROM nginx:alpine

# Security: drop default site configs
RUN rm -rf /etc/nginx/conf.d/*

# Copy custom site configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy admin dashboard and reports
COPY index.html /usr/share/nginx/html/admin/index.html
COPY reports/ /usr/share/nginx/html/reports/

# Healthcheck (optional but helpful for Docker Compose / monitoring)
HEALTHCHECK --interval=30s --timeout=5s \
  CMD wget --spider -q http://localhost/ || exit 1

# Expose port
EXPOSE 80
