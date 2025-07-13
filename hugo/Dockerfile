FROM ubuntu:noble
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

RUN apt update  && \
    apt install -y sudo \
    curl \
    wget \
    git \
    lxterminal \
    inetutils-tools \
    net-tools \
    build-essential \
    libssl-dev

COPY hugo/ssh/config /root/.ssh/config

RUN sudo apt update && \
    sudo apt install -y proxychains4 \
    vim
#----------Install nodejs--------------------------
# Use bash for the shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a script file sourced by both interactive and non-interactive bash shells
ENV BASH_ENV /root/.bash_env
RUN touch "${BASH_ENV}"
RUN echo '. "${BASH_ENV}"' >> ~/.bashrc

# Download and install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo node > .nvmrc
# RUN nvm install
RUN nvm install v22.16.0
#---------------------------------------------------

#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
#RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# RUN nvm install v22.16.0
 
RUN wget -c https://github.com/gohugoio/hugo/releases/download/v0.148.0/hugo_extended_0.148.0_linux-amd64.deb  && \
    sudo dpkg -i hugo_extended_0.148.0_linux-amd64.deb

# RUN sudo apt install -y snapd
# RUN sudo snap install hugo
 
# RUN npm install hugo-extended --save-dev
RUN npm install -g postcss-cli && \
    npm install -g autoprefixer
 

WORKDIR /root

COPY hugo/entrypoint.sh /root/entrypoint.sh
RUN sudo chmod a+x /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]

CMD ["bash"]
