FROM mwader/static-ffmpeg:8.1.2 AS ffmpeg
FROM alpine:3.24 AS exiftool

RUN apk add --no-cache exiftool

FROM n8nio/n8n:2.33.2

USER root

COPY --from=ffmpeg /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg /ffprobe /usr/local/bin/ffprobe

COPY --from=exiftool /usr/bin/exiftool /usr/local/bin/exiftool
COPY --from=exiftool /usr/bin/perl /usr/bin/perl
COPY --from=exiftool /usr/lib/perl5 /usr/lib/perl5
COPY --from=exiftool /usr/share/perl5 /usr/share/perl5

RUN exiftool -ver && perl -v

RUN npm install -g emailjs-mime-codec sharp

USER node
