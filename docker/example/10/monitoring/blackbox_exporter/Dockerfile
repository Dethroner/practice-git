FROM prom/blackbox-exporter:master

COPY blackbox.yml       /etc/blackbox_exporter/config.yml

EXPOSE      9115

ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]
