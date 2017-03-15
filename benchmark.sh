# !/bin/bash/

# Compile x264 if not yet
if ! [ -f ./x264/configure ]; then 
    echo Downloanding x264
    git submodule update --init --recursive
fi
if ! [ -f ./x264-bin ]; then
    echo Compiling x264
    (cd ./x264 && ./configure --disable-asm)
    (cd ./x264 && make)
    mv ./x264/x264 ./x264-bin 
    (cd ./x264 && make clean)
fi

# Download youtube-downloader
if ! [ -f youtube-downloader ]; then
    echo Downloading youtube downloader
    curl -L https://yt-dl.org/downloads/latest/youtube-dl -o  youtube-downloader
    chmod a+rx youtube-downloader
fi

# Download video from youtube
if ! [ -f video.mp4 ]; then
    echo Downloading Big Bucks Bunny
    ./youtube-downloader https://www.youtube.com/watch\?v\=YE7VzlLtp-4 --youtube-skip-dash-manifest -f 136 -o video.mp4
fi


