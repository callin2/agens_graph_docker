FROM node:10.13.0

RUN apt-get update
RUN apt-get install -y build-essential libreadline-dev zlib1g-dev flex bison git

RUN useradd -m -c "AgensGraph User" -U agens -p agens

USER agens

RUN mkdir -p /home/agens/AgensGraph
RUN chown -R agens:agens /home/agens
RUN chmod -R 700 /home/agens

RUN git clone https://github.com/callin2/agensgraph.git /home/agens/AgensGraph

RUN mkdir -p /home/agens/AgensGraph/data

ENV AGDATA=/home/agens/AgensGraph/data \
    PATH=/home/agens/AgensGraph/bin:$PATH \
    LD_LIBRARY_PATH=/home/agens/AgensGraph/lib:$LD_LIBRARY_PATH \
    AGHOME=/home/agens/AgensGraph

RUN cd /home/agens/AgensGraph; ./configure --prefix=$(pwd)
RUN cd /home/agens/AgensGraph; make install


USER root

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN npm i -g pegjs

USER agens


RUN git clone https://github.com/callin2/agens_http.git /home/agens/Agens_Http
RUN npm install --only=prod --prefix /home/agens/Agens_Http/api_server


ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
EXPOSE 3000

RUN set -e;\
    initdb;\
	ag_ctl start; sleep 5;\
	createdb;\
	agens -c "create graph agens_graph";\
	psql -c "alter user agens password 'qwer4321'";\
    ag_ctl stop

RUN sed 's/localhost/\*/' /home/agens/AgensGraph/data/postgresql.conf -i
RUN sed 's/#listen/listen/' /home/agens/AgensGraph/data/postgresql.conf -i

RUN echo "host    all             all              0.0.0.0/0                       md5" >> /home/agens/AgensGraph/data/pg_hba.conf
RUN  echo "host    all             all              ::/0                            md5" >> /home/agens/AgensGraph/data/pg_hba.conf

CMD ["agens"]