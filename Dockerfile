FROM  node:8-alpine

###----------------------------------------------------------------------------
### Variables
###----------------------------------------------------------------------------
ENV appDir '/usr/src/app'
ENV USER 'root'


###----------------------------------------------------------------------------
### OS Maintenance
###----------------------------------------------------------------------------
# Update the apk cache, then upgrade all packages on the system
RUN apk update && apk upgrade


###----------------------------------------------------------------------------
### DEV / Humans
###----------------------------------------------------------------------------
# Add some conveniences
ADD system/bashrc "/$USER/.bashrc"
ADD system/vim-sensible/plugin/sensible.vim "/$USER/.vimrc"

# Add utilities
RUN apk add bash vim coreutils tzdata curl ca-certificates

# Add Dev utilities
RUN apk add bash-completion bash-doc coreutils binutils findutils tree

# Default SHELL: bash; we're not animals
RUN sed -i "/^$USER/ s/ash/bash/1" /etc/passwd


###----------------------------------------------------------------------------
### MAIN
###----------------------------------------------------------------------------
RUN mkdir -p "$appDir"

WORKDIR "$appDir"

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]
