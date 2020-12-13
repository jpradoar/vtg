FROM alpine:3.11.2
COPY . /app
WORKDIR /app
RUN apk add python3 tcptraceroute iputils nmap py3-pip bind-tools && pip3 install flask
EXPOSE 80
CMD python3 ./wogapi.py
