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

if ! [ -f sintel_trailer_2k_480p24.y4m ]; then
    echo Downloading Sintel Trailer in raw format
    wget https://media.xiph.org/video/derf/y4m/sintel_trailer_2k_480p24.y4m
fi

# Now we're doing the stats
perf stats -d -r 5 ./x264-bin -o video.mkv sintel_trailer_2k_480p24.y4m
