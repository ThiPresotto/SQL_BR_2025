CREATE VIEW resultado_partida AS
SELECT 
    partidas.id_partida,
    times_mandante.nome_time AS mandante,
    partidas.placar_mandante,
    'x' AS " ",
    partidas.placar_visitante,
    times_visitante.nome_time AS visitante
FROM partidas
JOIN times AS times_mandante ON partidas.id_mandante = times_mandante.id_time
JOIN times AS times_visitante ON partidas.id_visitante = times_visitante.id_time;

CREATE VIEW total_gols_por_time AS
SELECT 
    times.nome_time,
    COALESCE(SUM(CASE WHEN partidas.id_mandante = times.id_time THEN partidas.placar_mandante ELSE 0 END), 0) +
    COALESCE(SUM(CASE WHEN partidas.id_visitante = times.id_time THEN partidas.placar_visitante ELSE 0 END), 0) AS total_gols
FROM 
    times
LEFT JOIN 
    partidas ON times.id_time = partidas.id_mandante OR times.id_time = partidas.id_visitante
GROUP BY 
    times.id_time, times.nome_time
ORDER BY 
    total_gols DESC;

CREATE VIEW media_tempo_arbitros AS
SELECT 
    arbitros.nome_arbitro,
    AVG(partidas.tempo_bola_rolando) AS media_tempo_bola_rolando,
    ROUND(AVG(partidas.faltas)) AS media_faltas,
    arbitros.partidas_apitadas
FROM partidas
JOIN arbitros ON partidas.juiz = arbitros.id_arbitro
GROUP BY 
    arbitros.id_arbitro, 
    arbitros.nome_arbitro, 
    arbitros.partidas_apitadas
ORDER BY 
    media_tempo_bola_rolando DESC;
