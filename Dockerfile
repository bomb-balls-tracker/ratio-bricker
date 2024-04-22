FROM ubuntu:20.04
RUN apt update && apt-get install curl wget
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && mkdir add-spoof
RUN wget https://github.com/bomb-balls-tracker/ratio-bricker/raw/main/ratio-spoof -O ratio-spoof
RUN wget https://github.com/bomb-balls-tracker/ratio-bricker/raw/main/main-proc.sh -O main-proc.sh

EXPOSE 8080

CMD ["bash", "main-proc.sh"]
