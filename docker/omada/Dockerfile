FROM debian:bookworm
COPY ./omada-install.sh .
RUN chmod +x omada-install.sh;sudo ./omada-install.sh
CMD ["tpeap", "start"]
