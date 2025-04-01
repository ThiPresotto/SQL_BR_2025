CREATE OR REPLACE FUNCTION gerar_id_partida()
RETURNS TRIGGER AS $$
BEGIN
    NEW.id_partida := 25000000 -- Prefixo fixo do ano 2024
                      + (NEW.rodada * 10000)  -- Rodada (2 dígitos) deslocada
                      + (NEW.id_mandante * 100)  -- ID do mandante (2 dígitos) deslocado
                      + NEW.id_visitante;  -- ID do visitante (2 dígitos);
 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION atualizar_partida_ap()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE arbitros
    SET partidas_apitadas = partidas_apitadas + 1
    WHERE id_arbitro = NEW.juiz;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_id_gol()
RETURNS TRIGGER AS $$
BEGIN

    NEW.id_gol := 
        250000000 +
        (NEW.id_partida % 10000) * 1000 +  
        NEW.minuto_gol * 10 +        
        CASE 
            WHEN NEW.primeiro_tempo THEN 1 
            ELSE 2                          
        END;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
