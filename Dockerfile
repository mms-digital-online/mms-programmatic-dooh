FROM python:3.7

ENV PYTHONUNBUFFERED=1
ENV DEV_ENV=0
ENV CONTAINER_ENV=1

RUN pip install --upgrade pip

WORKDIR /usr/src/app

ARG FFMPEG_VERSION=4.1.1
RUN FFMPEG_SOURCE_DIR=/usr/local/src/ffmpeg/ffmpeg-${FFMPEG_VERSION}-64bit-static && \
    mkdir -p ${FFMPEG_SOURCE_DIR} && \
    curl -fsSL https://github.com/smpio/ffmpeg-builds/raw/master/ffmpeg-${FFMPEG_VERSION}-64bit-static.tar.xz  | tar -xJC ${FFMPEG_SOURCE_DIR} --strip 1 && \
    ln -s ${FFMPEG_SOURCE_DIR}/ffmpeg /usr/local/bin/ffmpeg && \
    ln -s ${FFMPEG_SOURCE_DIR}/ffprobe /usr/local/bin/ffprobe && \
    ln -s ${FFMPEG_SOURCE_DIR}/qt-faststart /usr/local/bin/qt-faststart

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT ["./manage.py"]
CMD ["runserver", "--noreload", "0.0.0.0:80"]
