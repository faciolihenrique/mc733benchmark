# !/bin/bash/

# Download x264 and lshw if not yet
if ! [ -f ./x264/configure ]; then 
    echo Downloanding x264
    git submodule update --init --recursive
fi

# Compiling lshw
if ! [ -f ./lshw-bin ]; then
    echo Compiling lswh
    (cd lshw && make)
    mv ./lshw/src/lshw ./lshw-bin
fi

# Compiling x264
if ! [ -f ./x264-bin ]; then
    echo Compiling x264
    (cd ./x264 && ./configure --disable-asm)
    (cd ./x264 && make)
    mv ./x264/x264 ./x264-bin 
    (cd ./x264 && make clean)
fi

# Downloading Video
if ! [ -f sintel_trailer_2k_480p24.y4m ]; then
    echo Downloading Sintel Trailer in raw format
    wget https://media.xiph.org/video/derf/y4m/sintel_trailer_2k_480p24.y4m
fi

# Saving PC's specs in specs.txt
./lshw-bin -short > specs.txt

# Now we're doing the stats
perf stat -d -r 5 ./x264-bin -o video.mkv sintel_trailer_2k_480p24.y4m
