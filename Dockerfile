FROM ubuntu:20.04
RUN apt update && apt-get -y install curl wget
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && mkdir add-spoof
RUN wget https://raw.githubusercontent.com/bomb-balls-tracker/ratio-bricker/main/ratio-spoof -O ratio-spoof
RUN wget https://raw.githubusercontent.com/bomb-balls-tracker/ratio-bricker/main/main-proc.sh -O MainProc_TEST.sh 

EXPOSE 8080

CMD ["bash", "MainProc_TEST.sh"]
