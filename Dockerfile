#
# Jugal Kishore -- 2020
#
# BombSquad Server
#
# Base Image: Ubuntu Focal
FROM ubuntu:focal

# Setting Non-Interactive Environment Variable
ARG DEBIAN_FRONTEND="noninteractive"

# BombSquad Version to download
ARG BOMBSQUAD_VERSION="1.6.0"

# Update Packages list
RUN apt-get update

# Install Packages
RUN apt-get install -y wget nano python3 libpython3.8

# Set Working Directory
WORKDIR /app

# Download BombSquad Server
RUN wget -O bombsquad.tar.gz https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_${BOMBSQUAD_VERSION}.tar.gz && \
    tar -xvf bombsquad.tar.gz && \
    mv BombSquad_Server*/ bombsquad-server && \
    rm -f bombsquad.tar.gz && \
    sed -i 's/#party_name: FFA/party_name: Junglee Server/' /app/bombsquad-server/config.yaml && \
    sed -i 's/#party_is_public: true/party_is_public: true/' /app/bombsquad-server/config.yaml && \
    sed -i 's/#max_party_size: 6/max_party_size: 21/' /app/bombsquad-server/config.yaml

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR /app/bombsquad-server

EXPOSE 43210/udp

CMD ["/app/bombsquad-server/bombsquad_server"]
