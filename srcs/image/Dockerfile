FROM debian:latest

RUN mkdir folder/ && cd folder/ && touch file.txt && echo "hello" > file.txt


RUN cd folder/ && touch file2.txt && echo "file 2 hello from it" > file2.txt

RUN cd folder/ && touch test.txt && echo "youssef lagzouli" >> test.txt

ENTRYPOINT [ "sleep", "100000" ]