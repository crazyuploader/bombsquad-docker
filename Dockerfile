#
# Jugal Kishore -- 2020
# Updated for 2025 best practices
# BombSquad Server Multi-Arch
#
FROM fedora:latest

ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}

ARG BOMBSQUAD_VERSION="1.7.43"

# Install required packages and clean up
RUN dnf update -y && \
    dnf install -y python3 curl && \
    dnf clean all && \
    rm -rf /var/cache/dnf /tmp/*

WORKDIR /app

# Download and extract BombSquad Server based on architecture
RUN case "${TARGETARCH}" in \
        "amd64"|"x86_64") ARCH="x86_64" ;; \
        "arm64"|"aarch64") ARCH="Arm64" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    curl -Lo bombsquad.tar.gz "https://files.ballistica.net/bombsquad/builds/old/BombSquad_Server_Linux_${ARCH}_${BOMBSQUAD_VERSION}.tar.gz" && \
    tar -xvf bombsquad.tar.gz && \
    mv BombSquad_Server*/ bombsquad-server && \
    rm -f bombsquad.tar.gz && \
    sed -i 's/#party_name = "FFA"/party_name = "Junglee Server"/' /app/bombsquad-server/config.toml && \
    sed -i 's/#party_is_public = true/party_is_public = true/' /app/bombsquad-server/config.toml && \
    sed -i 's/#max_party_size = 6/max_party_size = 21/' /app/bombsquad-server/config.toml

WORKDIR /app/bombsquad-server

EXPOSE 43210/udp

CMD ["/app/bombsquad-server/bombsquad_server"]
