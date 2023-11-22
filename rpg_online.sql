-- Tabela 'MAPA'
CREATE TABLE MAPA (
    provincia VARCHAR(255) PRIMARY KEY,
    area VARCHAR(255),
    nome VARCHAR(40),
    descricao TEXT,
    coordenadas VARCHAR(255)
);

-- Tabela 'INVENTARIO'
CREATE TABLE INVENTARIO (
    id_inventario INT PRIMARY KEY,
    nome_inventario VARCHAR(40)
);

-- Tabela 'SERVIDOR'
CREATE TABLE SERVIDOR (
    chave VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(40),
    regras TEXT,
    tipo VARCHAR(255),
    descricao TEXT,
    provincia_map VARCHAR(255) NOT NULL REFERENCES MAPA(provincia)
);

-- Tabela 'ITEM'
CREATE TABLE ITEM (
    id_item INT PRIMARY KEY,
    tipo VARCHAR(255),
    nome VARCHAR(40),
    valor INT,
    nivel INT
);

-- Tabela 'MISSOES'
CREATE TABLE MISSOES (
    id_missoes INT PRIMARY KEY,
    nome VARCHAR(40),
    descricao TEXT,
    recompensa VARCHAR(255)
);

-- Tabela 'CONQUISTA'
CREATE TABLE CONQUISTA (
    nome VARCHAR(40) PRIMARY KEY,
    nivel_reputacao INT,
    tipo VARCHAR(255)
);

-- Tabela 'PERSONAGEM'
CREATE TABLE PERSONAGEM (
    nome_personagem VARCHAR(40) PRIMARY KEY,
    classe VARCHAR(30),
    pontos_de_vida INT,
    nivel INT,
    pontos_de_mana INT,
    id_invent INT REFERENCES INVENTARIO(id_inventario),
    chave_serv VARCHAR(255) NOT NULL REFERENCES SERVIDOR(chave)
);

-- Tabela 'JOGADOR'
CREATE TABLE JOGADOR (
    id_jogador INT PRIMARY KEY,
    nome VARCHAR(40),
    senha VARCHAR(255),
    email VARCHAR(255),
    data_ultimologin DATE,
    nome_pers VARCHAR(255) REFERENCES PERSONAGEM(nome_personagem)
);

-- Tabela 'HABILIDADES'
CREATE TABLE HABILIDADES (
    id_habilidade INT PRIMARY KEY,
    nome VARCHAR(40),
    descricao TEXT,
    tipo VARCHAR(255),
    custo_mana INT,
    dano INT,
    area_dano INT,
    nome_pers VARCHAR(255) REFERENCES PERSONAGEM(nome_personagem)
);

-- Tabela 'CORREIO'
CREATE TABLE CORREIO (
    id_correio INT PRIMARY KEY,
    destinatario VARCHAR(40) REFERENCES PERSONAGEM(nome_personagem),
    remetente VARCHAR(40) REFERENCES PERSONAGEM(nome_personagem),
    conteudo TEXT
);

-- Tabela 'RASTREIA_REALIZAÇÕES'
CREATE TABLE RASTREIA_REALIZACOES (
    nome_conquista VARCHAR(40) REFERENCES CONQUISTA(nome),
    id_jogad INT REFERENCES JOGADOR(id_jogador),
    data_conquista DATE,
    PRIMARY KEY (nome_conquista, id_jogad, data_conquista)
);

-- Tabela 'PERSONAGEM_FAZ_MISSOES'
CREATE TABLE PERSONAGEM_FAZ_MISSOES (
    nome_pers VARCHAR(40) REFERENCES PERSONAGEM(nome_personagem),
    id_misso INT REFERENCES MISSOES(id_missoes),
	PRIMARY KEY (nome_pers, id_misso),
    status_missao VARCHAR(255)
);

-- Tabela 'GUARDA_INV'
CREATE TABLE GUARDA_INV (
    id_invent INT REFERENCES INVENTARIO(id_inventario),
    id_ite INT REFERENCES ITEM(id_item),
    PRIMARY KEY (id_invent, id_ite)
);

-- INSERT DE MAPA

INSERT INTO MAPA (provincia, area, nome, descricao, coordenadas) VALUES
('Montanha do Trovão', 'Região Montanhosa', 'Pico da Tempestade', 'Uma montanha onde tempestades mágicas acontecem frequentemente', '40.123, -75.456'),
('Floresta HP', 'Região Florestal', 'Floresta Proibida', 'Uma densa e sombria floresta repleta de criaturas mágicas perigosas.', '35.789, -80.567'),
('Cidade Abandonada', 'Região Urbana', 'Distrito dos Esquecidos', 'Uma cidade outrora grandiosa, agora abandonada e assombrada por presenças sinistras', '41.789, -65.012');

-- INSERT DE INVENTARIO

INSERT INTO INVENTARIO (id_inventario, nome_inventario) VALUES
(1, 'Guerreiro'),
(2, 'Arqueiro'),
(3, 'Mago'),
(4, 'Assassino'),
(5, 'Necromante'),
(6, 'Ninja');

-- INSERT DE SERVIDOR

INSERT INTO SERVIDOR (chave, nome, regras, tipo, descricao, provincia_map) VALUES
('ABCDE', 'Invictus', 'Proibido xingar, humilhar, brigar com jogadores!', 'PvP', 'Servidor sobre lutas constantes', 'Montanha do Trovão'),
('FGHIJ', 'Aventura Épica', 'Respeite outros jogadores e divirta-se explorando!', 'PvE', 'Servidor voltado para missões e exploração', 'Floresta HP'),
('KLMNO', 'Cidade Fantasma', 'Sem regras, sobreviva se puder!', 'PvPvE', 'Servidor em uma cidade abandonada cheia de criaturas mágicas', 'Cidade Abandonada');

-- INSERT DE ITEM
INSERT INTO ITEM (id_item, tipo, nome, valor, nivel) VALUES
(1, 'Arma', 'Nunchaku de Trovão', 400, 7),
(2, 'Arma', 'Espada Mística', 300, 6),
(3, 'Consumível', 'Poção de Cura', 50, 2),
(4, 'Acessório', 'Anel da Invisibilidade', 500, 8),
(5, 'Mágico', 'Cajado Elemental', 350, 7),
(6, 'Mágico', 'Livro de Feitiços Antigo', 250, 6),
(7, 'Arma', 'Adaga Envenenada', 220, 4),
(8, 'Arma', 'Arco das Sombras', 400, 8),
(9, 'Armadura', 'Manto do Espectro Sombrio', 200, 8),
(10, 'Armadura', 'Armadura de Escamas de Dragão', 150, 5),
(11, 'Mágico', 'Orbe da Vida Profana', 420, 9);

-- INSERT DE MISSOES

INSERT INTO MISSOES (id_missoes, nome, descricao, recompensa) VALUES
(1, 'Jungle Bungle!', 'Entre na floresta e enfrente os inimigos que aparecer!', '100 ouros'),
(2, 'Ruína Perdida', 'Explore as antigas ruínas e descubra seus segredos.', '200 ouros e uma poção de cura'),
(3, 'Ameaça nas Montanhas', 'Enfrente criaturas nas Montanhas do Trovão para garantir a segurança da região.', '150 ouros e um item mágico'),
(4, 'Caminho da Sabedoria', 'Complete uma série de desafios intelectuais para ganhar conhecimento e recompensas.', '300 ouros e um livro de habilidades'),
(5, 'Caça aos Monstros', 'Receba recompensas por derrotar monstros específicos na Floresta HP.', '120 ouros e um medalhão mágico'),
(6, 'Tesouro Subterrâneo', 'Explore cavernas profundas em busca de tesouros esquecidos.', '250 ouros e uma arma rara');

-- INSERT DE CONQUISTA

INSERT INTO CONQUISTA (nome, nivel_reputacao, tipo) VALUES
('Manuseio perfeito', 5, 'Combate'),
('Domínio de habilidade', 8, 'Habilidade'),
('Explorador Intrépido', 10, 'Exploração'),
('Senhor das Feras', 7, 'Domínio sobre Animais'),
('Mestre dos Enigmas', 6, 'Solução de Quebra-Cabeças'),
('Colecionador de Relíquias', 9, 'Busca por Artefatos');

-- INSERT DE PERSONAGEM
INSERT INTO PERSONAGEM (nome_personagem, classe, pontos_de_vida, nivel, pontos_de_mana, id_invent, chave_serv) VALUES
('Akemiistch', 'Ninja', 1250, 10, 200, 6, 'ABCDE'),
('GilPhoenix', 'Mago', 1000, 10, 600, 3, 'ABCDE'),
('Samuca', 'Guerreiro', 1500, 10, 50, 1, 'ABCDE');

INSERT INTO PERSONAGEM (nome_personagem, classe, pontos_de_vida, nivel, pontos_de_mana, id_invent, chave_serv) VALUES
('ED1EhComigo', 'Guerreiro', 1700, 6, 150, 1, 'ABCDE'),
('BancoMinhaVida', 'Guerreiro', 2000, 8, 100, 1, 'ABCDE');

-- INSERT DE JOGADOR
INSERT INTO JOGADOR (id_jogador, nome, senha, email, data_ultimologin, nome_pers) VALUES
(12, 'Julia Akemi Koba', 123, 'Julia@gmail.com', to_date('30112023','DDMMYYYY'),'Akemiistch'),
(11, 'Gil Antony', 456, 'GilAntony@gmail.com', to_date('04042004','DDMMYYYY'),'GilPhoenix'),
(10, 'Samuel', 789, 'Samuel@gmail.com', to_date('07072007','DDMMYYYY'),'Samuca');

INSERT INTO JOGADOR (id_jogador, nome, senha, email, data_ultimologin, nome_pers) VALUES
(9, 'Ana Claúdia', 123, 'anaclaudia@gmail.com', to_date('12052022','DDMMYYYY'),'ED1EhComigo'),
(8, 'Alessandra Paulino', 123, 'alessandra@gmail.com', to_date('12052022','DDMMYYYY'),'BancoMinhaVida');


-- INSERT HABILIDADE
INSERT INTO HABILIDADES (id_habilidade, nome, descricao, tipo, custo_mana, dano, area_dano, nome_pers) VALUES
(01, 'Magia da Água', 'Controle total de partículas de água em qualquer estado da matéria', 'Magia Elemental', 40, 222, 500, 'GilPhoenix'),
(02, 'Teleporte Dimensional', 'Se teleporta instantaneamente para qualquer lugar que tenha visitado antes e que se lembra', 'Habilidade Mágica', 150, 0, 0, 'GilPhoenix'),
(03, 'Sombra Veloz', 'Move-se rapidamente nas sombras, atacando o inimigo com golpes rápidos e precisos', 'Habilidade Física', 7, 120, 20, 'Akemiistch'),
(04, 'Lâmina Envenenada', 'Envolve a lâmina com veneno mortal, causando dano ao longo do tempo', 'Habilidade Física', 12, 80, 15, 'Akemiistch'),
(05, 'Investida Furiosa', 'Realiza uma investida poderosa contra o inimigo, causando dano e atordoamento', 'Habilidade Física', 2, 150, 20, 'Samuca'),
(06, 'Escudo Protetor', 'Ergue o escudo para bloquear ataques inimigos, reduzindo o dano recebido', 'Habilidade Defensiva', 15, 0, 0, 'Samuca');

-- INSERT CORREIO
INSERT INTO CORREIO (id_correio, destinatario, remetente, conteudo) VALUES
(1, 'GilPhoenix', 'Akemiistch', 'Convite para o servidor Cidade Fantasma (PvPvE) em uma cidade abandonada com criaturas mágicas. A chave de entrada é KLMNO. Local de encontro UFU. Não se esqueça de sobreviver ao semestre letivo!'),
(2, 'Akemiistch', 'GilPhoenix', 'Obrigado pelo convite! Te encontro lá as 710 da manhã!'),
(3, 'Samuca', 'Akemiistch', 'Olá Samuca! Eu e o GilPhoenix estamos online na Cidade Fantasma! A chave é KLMNO. Estamos te esperando dentro da UFU!'),
(4, 'Akemiistch', 'Samuca', 'Bom dia Júlia! Já estou dentro da UFU! Estou sobrevivendo aqui a um tempo já! Estou no Lab 8, montei uma fogueira com as CPUs para afastar as criaturas mágicas perigosas. Venham me encontrar, se conseguirem, claro.'),
(5, 'Samuca', 'Akemiistch', 'Ok! Estamos indo a seu encontro!'),
(6, 'Samuca', 'GilPhoenix', 'Olá Samuca! Estamos no Lab 8, mas não existe nenhuma fogueira por aqui! E onde estão as CPUs'),
(7, 'GilPhoenix', 'Samuca', 'As CPUs estão comigo! Estou as protegendo de umas criaturas invisíveis que apareceram do nada, acabei com todas elas, agora estou nas Kits afiando minha espada'),
(8, 'Samuca', 'GilPhoenix', 'Vou nos teleportar até aí!'),
(9, 'Samuca', 'Akemiistch', 'Cuide bem das CPUs! Elas podem ser itens valiosos!');

-- INSERT RASTREIA_REALIZAÇÕES
INSERT INTO RASTREIA_REALIZACOES (nome_conquista, id_jogad, data_conquista) VALUES
('Manuseio perfeito', 12, to_date('20112023','DDMMYYYY')),
('Domínio de habilidade', 11, to_date('19032004','DDMMYYYY')),
('Senhor das Feras', 10, to_date('13052007','DDMMYYYY'));

-- INSERT PERSONAGEM_FAZ_MISSOES

INSERT INTO PERSONAGEM_FAZ_MISSOES (nome_pers, id_misso, status_missao) VALUES
('Akemiistch', 4, 'Em andamento'),
('GilPhoenix', 2, 'Concluída'),
('Samuca', 5, 'Em andamento');

INSERT INTO PERSONAGEM_FAZ_MISSOES (nome_pers, id_misso, status_missao) VALUES
('Akemiistch', 1, 'Em andamento');

DELETE FROM PERSONAGEM_FAZ_MISSOES WHERE id_misso = 1;

-- INSERT GUARDA_INV
INSERT INTO GUARDA_INV (id_invent, id_ite) VALUES
(6, 1),
(6, 7),
(6, 9),
(3, 3),
(3, 5),
(3, 6),
(1, 2),
(1, 4),
(1, 10);

-- ALTER TABLE

ALTER TABLE CORREIO ADD COLUMN data_correio DATE;

-- UPDATES

UPDATE JOGADOR SET email = 'SamuelSilva@gmail.com' WHERE email = 'Samuel@gmail.com';
UPDATE ITEM SET valor = 470 WHERE valor = 200;
UPDATE MISSOES SET nome = 'Selva Selvagem' WHERE nome = 'Jungle Bungle!';
UPDATE CORREIO SET data_correio = to_date('06102001','DDMMYYYY') WHERE id_correio = 1;
UPDATE CORREIO SET data_correio = to_date('06102001','DDMMYYYY') WHERE data_correio IS NULL;

-- CONSULTAS

-- 1. Listar o nome dos jogadores e nomes dos seus personagens e em que servidores eles estão.
SELECT J.nome, J.nome_pers, S.nome
FROM JOGADOR AS J JOIN PERSONAGEM AS PERS ON J.nome_pers = PERS.nome_personagem, SERVIDOR AS S
WHERE S.chave = PERS.chave_serv;

-- 2. Encontrar todos os personagens que completaram missões em um servidor PvP.
SELECT nome_personagem
FROM PERSONAGEM, PERSONAGEM_FAZ_MISSOES, SERVIDOR
WHERE nome_personagem = nome_pers AND status_missao = 'Concluída' AND tipo = 'PvP';

-- 3. Listar todos os nomes e tipos de Itens que estão ou não em algum inventário, e para os que estão em algum inventário, mostre o nome do inventário que estão:
SELECT I.tipo, I.nome, COALESCE(INV.nome_inventario, 'Não está no inventário') AS nome_inventario
FROM ITEM AS I
LEFT OUTER JOIN (GUARDA_INV AS GI JOIN INVENTARIO AS INV ON GI.id_invent = INV.id_inventario) ON I.id_item = GI.id_ite;

-- 4. Listar todos os nomes e tipos de Itens que estão ou não em algum inventário, e para os que estão em algum inventário, mostre o nome do inventário que estão.
SELECT tipo, nome, nome_inventario
FROM ITEM LEFT OUTER JOIN (GUARDA_INV INNER JOIN INVENTARIO ON id_inventario=id_invent) ON id_item=id_ite;

-- 5. Listar todos os servidores e os nomes dos personagens associados a eles (se houver).
SELECT nome_personagem, nome AS nome_servidor
FROM PERSONAGEM RIGHT OUTER JOIN SERVIDOR ON chave = chave_serv;

DELETE FROM SERVIDOR WHERE chave = 'FGHIJ';

-- 6. Contar o número de missões por jogador.
SELECT JOGADOR.nome AS nome_jogador, COUNT(PERSONAGEM_FAZ_MISSOES.id_misso) AS numero_missões
FROM JOGADOR JOIN PERSONAGEM_FAZ_MISSOES ON JOGADOR.nome_pers = PERSONAGEM_FAZ_MISSOES.nome_pers
GROUP BY JOGADOR.nome;

-- 7. Calcular a média de nível dos personagens por classe.
SELECT classe, AVG(PERS.nivel) AS media
FROM JOGADOR AS J JOIN PERSONAGEM AS PERS ON J.nome_pers = PERS.nome_personagem
GROUP BY classe;

DELETE FROM JOGADOR WHERE nome_pers = 'ED1EhComigo';

-- 8. Mostrar a média de dano das habilidades dos personagens
SELECT nome_pers, AVG(dano) AS media_dano_habilidades
FROM HABILIDADES
GROUP BY nome_pers;

-- 9. Combinar todos os nomes de personagens de duas tabelas.
SELECT nome
FROM JOGADOR

UNION

SELECT nome_personagem
FROM PERSONAGEM;

-- 10. Obter todos os itens distintos presentes na tabela de itens, excluindo os presentes nos inventários
SELECT nome
FROM ITEM

EXCEPT

SELECT I.nome
FROM GUARDA_INV AS GI JOIN ITEM AS I ON GI.id_ite = I.id_item;

-- 11. Identificar quais missões não foram completadas por nenhum personagem ainda
SELECT nome AS missao_nao_completada
FROM MISSOES
WHERE id_missoes NOT IN (
    SELECT id_misso
    FROM PERSONAGEM_FAZ_MISSOES);

-- 12. Encontrar todos os personagens que possuem pelo menos uma habilidade de dano maior que 140
SELECT nome_personagem
FROM PERSONAGEM AS PERS
WHERE EXISTS (
    SELECT 1
    FROM HABILIDADES AS H
    WHERE H.nome_pers = PERS.nome_personagem
        AND H.dano > 140
);

-- 13. Mostrar o nome, email, data do último login em que a data termina com o dígito 5.
SELECT nome, email, data_ultimologin
FROM JOGADOR
WHERE TO_CHAR(data_ultimologin, 'DDMMYYYY') LIKE '___5%';









