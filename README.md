# Grupo 2 - x264

## O que faz? Para que serve?
O x264 é um software de código aberto para codificação de fluxos de vídeo para o formato H.264/MPEG-4 AVC.

## Por que é bom para medir desempenho?
Ao utilizarmos o x264 como benchmark, estamos medindo o quão rapidamente é possível codificar um vídeo de algum formato para o formato x264. Com isso, podemos utilizar diferentes flags para medir tanto o desempenho da CPU, quanto o da GPU. Além disso, como estaremos utilizando arquivos relativamente pesados, poderemos medir as velocidades de escrita e leitura dos computadores a serem testados.

## O que baixar
Basta clonar o [repositório do grupo](https://github.com/henriquefacioli/mc733benchmark). No repositório já estão presentes todos os arquivos necessários para a realização do benchmark, entre eles o [repositório do x264](http://git.videolan.org/) e o vídeo em formato `.y4m` do [Sintel Trailer](https://media.xiph.org/video/derf/y4m/sintel_trailer_2k_480p24.y4m), que será utilizado no teste.

## Como compilar/instalar
O programa é compilado com o auxílio do script. Basta executar o comando `./benchmark.sh`. Esse script já compila e instala o `x264`, através dos comandos `./configure --disable-asm` e `make`, além de já executar os testes, como será visto abaixo.

## Como executar
O script já executa o teste automaticamente, utilizando o vídeo baixado e o convertendo para o formato `.mkv`. Isso é feito através do comando ``. Os dados relevantes do teste, tais como tempo de execução, desempenho de disco, cache misses, entre outros, são obtidos com o auxílio da ferramenta `perf`.

## Como medir o desempenho
O desempenho é medido utilizando as flags `-d` e `-r "N"` do `perf`, que servem para, respectivamente, detalhar a execução e repeti-la "N" vezes. Com isso, obtemos medidas de tempo de execução (`seconds time elapsed`), número de `page-faults`, `L1-dcache-load-misses`, entre outras. Essas 3 medidas citadas são feitas 5 vezes e são retornadas as respectivas médias e desvios-padrão.

## Como apresentar o desempenho
O desempenho será apresentado na forma de várias medições realizadas pelo `perf`, onde são mostradas tanto as médias dessas medições quanto os seus desvios-padrão. Para a nossa análise, o foco será nas medições correspondentes à: tempo de execução (`seconds time elapsed`), número de `page-faults` e cache-load-misses (`L1-dcache-load-misses`).

## Medições base (uma máquina)
Inclua a especificação dos componentes relevantes e os resultados de desempenho.
