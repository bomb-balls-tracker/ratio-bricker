FROM ubuntu:20.04
RUN apt update && apt-get -y install curl wget zip unzip
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && mkdir add-spoof
RUN wget https://github.com/ap-pauloafonso/ratio-spoof/releases/download/v1.9/ratio-spoof-v1.9.linux-mac-windows.zip -O ratio-spoof-v1.9.linux-mac-windows.zip && unzip ratio-spoof-v1.9.linux-mac-windows.zip && cp linux/ratio-spoof ratio-spoof
RUN wget --https-only https://raw.githubusercontent.com/bomb-balls-tracker/ratio-bricker/main/main-proc.sh -O MainProc.sh

EXPOSE 8080

CMD ["bash", "MainProc.sh"]
