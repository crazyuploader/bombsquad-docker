#
# Jugal Kishore -- 2020
#
# BombSquad Server
#
# Base Image: fedora:latest
FROM fedora:latest

# BombSquad Version to download
ARG BOMBSQUAD_VERSION="1.7.43"

# Update Packages list
RUN dnf update -y

# Install Packages
RUN dnf install -y python3

# Set Working Directory
WORKDIR /app

# Download BombSquad Server
RUN curl -Lo bombsquad.tar.gz https://files.ballistica.net/bombsquad/builds/old/BombSquad_Server_Linux_x86_64_${BOMBSQUAD_VERSION}.tar.gz && \
    tar -xvf bombsquad.tar.gz && \
    mv BombSquad_Server*/ bombsquad-server && \
    rm -f bombsquad.tar.gz && \
    sed -i 's/#party_name = "FFA"/party_name = "Junglee Server"/' /app/bombsquad-server/config.toml && \
    sed -i 's/#party_is_public = true/party_is_public = true/' /app/bombsquad-server/config.toml && \
    sed -i 's/#max_party_size = 6/max_party_size = 21/' /app/bombsquad-server/config.toml

# Clean up
RUN dnf clean all && \
    rm -rf /var/lib/dnf/yum/* /tmp/*

WORKDIR /app/bombsquad-server

EXPOSE 43210/udp

CMD ["/app/bombsquad-server/bombsquad_server"]
