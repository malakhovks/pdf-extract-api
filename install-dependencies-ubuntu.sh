#!/usr/bin/env bash

#Check dependencies
#Check Node
if ! type "node" > /dev/null 2>&1;
 then
    printf >&2 "node not found! Install? (y/n):";
    read -n1 REPLY
    case $REPLY in
      y|Y) printf "\n Installing lts Node.js v8.x . . . \n";
            sudo apt-get update
            sudo apt-get upgrade
            curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
            sudo apt-get install -y nodejs
            sudo apt-get install -y build-essential
            sudo npm install npm@latest -g
            sudo npm install -g n
            sudo n lts
            node -v
            npm -v ;;
      n|N) printf "\n Abort \n";
           exit 1 ;;
      *) exit 1 ;;
    esac
 else  printf "\n node + \n"
fi

#Check pdftotext
if ! type "pdftotext" > /dev/null 2>&1;
 then
    printf >&2 "pdftotext not found! Install? (y/n):";
    read -n1 REPLY
    case $REPLY in
      y|Y) printf "\ nInstalling poppler-utils . . . \n";
           sudo apt-get update
           sudo apt-get upgrade
           sudo apt-get install poppler-utils ;;
      n|N) printf "\n Abort \n";
           exit 1 ;;
      *) exit 1 ;;
    esac
 else printf "\n pdftotext + \n"
fi

#Install node_modules
printf "\n Install node_modules . . . \n"
npm install