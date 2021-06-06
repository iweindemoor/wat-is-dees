###   DEEL 1: instructies voor het BUILDen van de IMAGE

FROM ubuntu:18.04 
# We starten vanaf de bestaande “ubuntu”-image (tag: 18.04) 
# deze image wordt van de registry (Docker Hub) gehaald.

RUN apt update 
RUN apt install -y apache2

ENV DEBIAN_FRONTEND=noninteractive 
# Bovenstaande lijn is nodig omdat er anders naar de timezone gevraagd wordt 
# tijdens de installatie van PHP 
RUN apt install -y php

COPY . /var/www/html/ # Kopieer de inhoud van “.” (op de host)
# naar “/var/www/html” (in de image). 
# (“.” betekent “huidige directory”) 
# (hier is dat dus de directory waar de “Dockerfile” staat)  

###   DEEL 2: extra details voor bij het RUNNEN van een CONTAIN

WORKDIR /var/www/html/ 
# Directory waar je terecht komt als je inlogt op een draaiende container 

EXPOSE 80/tcp 
# Binnen deze image/container zal poort 80 (over TCP) gebruikt worden.
# Je kan deze poort beschikbaar maken vanop de host met:
# "docker run –d –t -p [<host-ip>:]<host-port>:80 <image>"
# (vergelijk dit met de port-forwarding bij VirtualBox)

CMD service apache2 start && bash 
# Met CMD geef je het commando op dat moet uitgevoerd worden 
# bij het STARTEN (of RUNNEN) van de CONTAINER. 
# Er kan slechts één CMD-   lijn staan in een Dockerfile. 
# (Verwar CMD niet met RUN) 
# (RUN-lijnen worden uitgevoerd bij het BUILDEN van de IMAGE)
# (de CMD-lijn wordt uitgevoerd bij het RUNNEN van een CONTAINER) 
#
# “systemctl” is niet geïnstalleerd op deze ubuntu, 
# daarom gebruiken we “service” als alternatief. 
# De “&& bash” is belangrijk omdat de container anders zou stoppen 
# na het uitvoeren van “service apache2 start”. 
# Het commando “bash” blijft immers “hangen”, 
# tot je binnen bash “exit” tikt. 
