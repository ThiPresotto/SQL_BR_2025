CREATE TABLE arbitros (
id_arbitro SERIAL PRIMARY KEY,
nome_arbitro VARCHAR(50) NOT NULL,
partidas_apitadas INTEGER DEFAULT 0
);

CREATE TABLE times (
id_time SERIAL PRIMARY KEY,
nome_time VARCHAR(50) NOT NULL
);

CREATE TABLE partidas (
id_partida INT PRIMARY KEY,
id_time_mandante INT NOT NULL REFERENCES times(id_time),
id_time_visitante INT NOT NULL REFERENCES times(id_time),
juiz INT NOT NULL REFERENCES arbitros(id_arbitro),
placar_mandante INT NOT NULL CHECK (placar_mandante >= 0),
placar_visitante INT NOT NULL CHECK (placar_visitante >= 0),
faltas INT NOT NULL CHECK (faltas >= 0),
c_amarelo INT NOT NULL CHECK (c_amarelo >=0),
c_vermelho INT NOT NULL CHECK (c_vermelho >=0)
tempo_bola_rolando INTERVAL,
tempo_jogo INTERVAL
rodada INT NOT NULL CHECK (rodada>0)
);

CREATE TABLE gols (
id_gol INT PRIMARY KEY,
id_partida INT NOT NULL REFERENCES partidas(id_partida),
id_time_marcador INT NOT NULL REFERENCES times(id_times),
minuto_gol INT CHECK(minuto_gol >0),
last_goal BOOLEAN,
primeiro_tempo BOOLEAN,
diference INT
);
