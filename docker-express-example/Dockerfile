FROM node:4

RUN mkdir -p /var/www/
ADD express-sample /var/www/express-sample
RUN cd /var/www/express-sample \
    && npm install

CMD ["node", "/var/www/express-sample/bin/www"]

EXPOSE 80
