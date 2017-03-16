# Grupo 2 - x264

## O que faz? Para que serve?
O x264 é um software de código aberto para codificação de fluxos de vídeo para o formato H.264/MPEG-4 AVC.

## Por que é bom para medir desempenho?
Ao utilizarmos o x264 como benchmark, estamos medindo o quão rapidamente é possível codificar um vídeo de algum formato para o formato x264. Com isso, podemos utilizar diferentes flags para medir tanto o desempenho da CPU, quanto o da GPU. Além disso, como estaremos utilizando arquivos relativamente pesados, poderemos medir as velocidades de escrita e leitura dos computadores a serem testados.

## O que baixar
Basta clonar o [repositório do grupo](https://github.com/henriquefacioli/mc733benchmark). No repositório já estão presentes todos os arquivos necessários para a realização do benchmark, entre eles o [repositório do x264](http://git.videolan.org/), o [repositório do lshw](https://github.com/lyonel/lshw) (um programa para detalhar o hardware) e o vídeo em formato `.y4m` do [Sintel Trailer](https://media.xiph.org/video/derf/y4m/sintel_trailer_2k_480p24.y4m), que será utilizado no teste.

## Como compilar/instalar
O programa é compilado com o auxílio do script. Basta executar o comando `./benchmark.sh`. 

Esse script já compila e instala o `x264`, através dos comandos `./configure --disable-asm` e `make`, também compila o lshw, além de já executar os testes, como será visto abaixo.

## Como executar
O script já executa o teste automaticamente, utilizando o vídeo baixado e o convertendo para o formato `.mkv`. Isso é feito através do comando `./x264-bin -o video.mkv <in-video>`. Os dados relevantes do teste, tais como tempo de execução, cache misses, entre outros, são obtidos com o auxílio da ferramenta `perf`.

## Como medir o desempenho
O desempenho é medido utilizando as flags `-d` e `-r "N"` do `perf`, que servem para, respectivamente, detalhar a execução e repeti-la "N" vezes. Com isso, obtemos medidas de tempo de execução (`seconds time elapsed`), número de `page-faults`, `L1-dcache-load-misses`, entre outras. Essas 3 medidas citadas são feitas 5 vezes e são retornadas as respectivas médias e desvios-padrão.

## Como apresentar o desempenho

```
 Performance counter stats for './x264-bin -o video.mkv sintel_trailer_2k_480p24.y4m' (5 runs):

     106151.335082      task-clock:u (msec)       #    3.645 CPUs utilized            ( +-  0.27% )
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
            36,055      page-faults:u             #    0.340 K/sec                    ( +-  0.38% )
   368,650,196,639      cycles:u                  #    3.473 GHz                      ( +-  0.07% )
 1,147,462,172,857      instructions:u            #    3.11  insn per cycle           ( +-  0.00% )
    45,770,825,560      branches:u                #  431.185 M/sec                    ( +-  0.00% )
     1,194,685,535      branch-misses:u           #    2.61% of all branches          ( +-  0.06% )
   262,451,684,544      L1-dcache-loads:u         # 2472.429 M/sec                    ( +-  0.00% )
     3,161,314,859      L1-dcache-load-misses:u   #    1.20% of all L1-dcache hits    ( +-  0.12% )
       719,521,834      LLC-loads:u               #    6.778 M/sec                    ( +-  1.03% )
        95,052,465      LLC-load-misses:u         #   13.21% of all LL-cache hits     ( +-  2.62% )

           29.125216980 seconds time elapsed                                          ( +-  0.63% )
```

O desempenho será apresentado na forma de várias medições realizadas pelo `perf`, onde são mostradas tanto as médias dessas medições quanto os seus desvios-padrão. Para a nossa análise, o foco será nas medições correspondentes à: tempo de execução (`seconds time elapsed`), número de `page-faults` e cache-load-misses (`L1-dcache-load-misses`).

## Medições base (uma máquina)

IH/W path     Device      Class          Description
===================================================
                         system         Computer
/0                       bus            Motherboard
/0/0                     memory         7892MiB System memory
/0/1                     processor      Intel(R) Core(TM) i5-4590 CPU @ 3.30GHz
/0/100                   bridge         4th Gen Core Processor DRAM Controller
/0/100/2                 display        Xeon E3-1200 v3/4th Gen Core Processor Integrated Graphics Controller
/0/100/3                 multimedia     Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller
/0/100/14                bus            8 Series/C220 Series Chipset Family USB xHCI
/0/100/16                communication  8 Series/C220 Series Chipset Family MEI Controller #1
/0/100/19    eno1        network        Ethernet Connection I217-LM
/0/100/1a                bus            8 Series/C220 Series Chipset Family USB EHCI #2
/0/100/1b                multimedia     8 Series/C220 Series Chipset High Definition Audio Controller
/0/100/1d                bus            8 Series/C220 Series Chipset Family USB EHCI #1
/0/100/1f                bridge         Q87 Express LPC Controller
/0/100/1f.2              storage        SATA Controller [RAID mode]
/0/100/1f.3              bus            8 Series/C220 Series Chipset Family SMBus Controller
/0/2         scsi1       storage        
/0/2/0.0.0   /dev/cdrom  disk           DVD+-RW GTA0N
/1           virbr0-nic  network        Ethernet interface
/2           virbr0      network        Ethernet interface.
