FROM ubuntu:20.04
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && mkdir add-torrents-to-spoof

EXPOSE 8080

