FROM selenium/standalone-chrome-debug:latest
RUN sudo apt-get update -y ; sudo apt-get -y install libnss3-tools
COPY ca-certificate-rsa.cer /usr/local/share/ca-certificates/
RUN sudo openssl x509 -inform PEM -in /usr/local/share/ca-certificates/ca-certificate-rsa.cer -out /usr/local/share/ca-certificates/ca-certificate-rsa.crt
RUN sudo update-ca-certificates
RUN mkdir -p $HOME/.pki/nssdb
RUN certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n GoAgent -i '/usr/local/share/ca-certificates/ca-certificate-rsa.crt'
RUN sudo apt-get clean && sudo apt-get autoclean
