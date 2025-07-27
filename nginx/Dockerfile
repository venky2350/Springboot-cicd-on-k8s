# Use official lightweight Nginx base image
FROM nginx:alpine

# Clean default config for security
RUN rm -rf /etc/nginx/conf.d/*

# Copy custom Nginx site config
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy admin dashboard and reports
COPY index.html /usr/share/nginx/html/admin/index.html
COPY reports/ /usr/share/nginx/html/reports/

# Optional: Add favicon, CSS, JS, etc. if needed
# COPY assets/ /usr/share/nginx/html/assets/

# Healthcheck to verify Nginx is serving
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
  CMD wget --spider -q http://localhost || exit 1

# Expose HTTP port
EXPOSE 80
