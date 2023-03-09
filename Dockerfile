# addaptation à la situation d'une VM openstack de l'université
# pour apt
RUN echo 'Acquire::http::Proxy "http://proxy.univ-lyon1.fr:3128";' > /etc/apt/apt.conf.d/99proxy
# var d'env
ENV DEBIAN_FRONTEND=noninteractive
ENV HTTP_PROXY=http://proxy.univ-lyon1.fr:3128
ENV HTTPS_PROXY=http://proxy.univ-lyon1.fr:3128
ENV ALL_PROXY=http://proxy.univ-lyon1.fr:3128
ENV http_proxy=http://proxy.univ-lyon1.fr:3128
ENV https_proxy=http://proxy.univ-lyon1.fr:3128
ENV all_proxy=http://proxy.univ-lyon1.fr:3128
ENV NO_PROXY=.univ-lyon1.fr
ENV no_proxy=.univ-lyon1.fr


# -----------------------------------------------------------------------------------
# exemple d'installation d'un utilitaire
# -----------------------------------------------------------------------------------

# Attention, c'est généralement une mauvaise idée d'installe ce type d'utilitaire dans un docker. En effet
# cela signifie qu'un attanquant qui s'introduit dans le docker peut facilement récupérer des outils pour
# les besoins du script de test
RUN apt-get update && apt-get -y install net-tools inetutils-ping inetutils-telnet netcat-openbsd curl >

ADD create-cert.sh authenticator.sh cleanup.sh /dns/

CMD /dns/create-cert.sh
