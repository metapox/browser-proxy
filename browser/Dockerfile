FROM ubuntu:latest

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y wget gnupg2 unzip ca-certificates fonts-liberation libappindicator3-1 libasound2 libnspr4 libnss3 lsb-release xdg-utils libxss1

# Chromeのインストール
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
