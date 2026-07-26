FROM mwader/static-ffmpeg:8.1.2 AS ffmpeg

FROM n8nio/n8n:2.32.5

USER root

COPY --from=ffmpeg /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg /ffprobe /usr/local/bin/ffprobe

RUN npm install -g emailjs-mime-codec sharp minio

USER node
