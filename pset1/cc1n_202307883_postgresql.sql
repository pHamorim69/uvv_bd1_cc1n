/**
   BANCO DE DADOS - PSET 
   Professor Abrantes - UVV
   Pedro Henrique dos Santos Amorim - CC1N
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------
/*
 
           CRIAÇÃO DO BANCO DE DADOS, USUÁRIO E MODO DE CONEXÃO

*/

---------------------------------------------------------------------------------------------------------------------------------------------------------	

-- apaga o banco de dados "uvv" caso o mesmo exista
DROP DATABASE IF EXISTS uvv
;

-- apaga o usuário "amorim" caso o mesmo exista
DROP USER IF EXISTS amorim
;

-- cria o usuário "amorim" com privilégios administrativos dando a ele permissão para criar um banco de dados junto a senha em formato criptografado
CREATE USER amorim WITH CREATEDB CREATEROLE ENCRYPTED PASSWORD 'pedro1'
;

-- cria o banco de dados "uvv" que será de propriedade do usuário "amorim"
CREATE DATABASE uvv 
WITH OWNER amorim

-- o banco de dados será criado com base no modelo "template0", que é um modelo padrão fornecido pelo sistema de gerenciamento de banco de dados
TEMPLATE template0

-- a codificação do banco de dados será definida como 'UTF8', o que suporta caracteres Unicode e suporta diversos idiomas
ENCODING 'UTF8'

-- define a regra de ordenação e comparação de strings como 'pt_BR.UTF-8', o que indica a regra de ordenação para o idioma português do brasil e define as regras de classificação de caracteres
LC_COLLATE 'pt_BR.UTF-8'
LC_CTYPE 'pt_BR.UTF-8'

-- está permitindo "true" conexões com o banco de dados
ALLOW_CONNECTIONS = true
;

-- está instruindo o utilitário "psql" a se conectar ao banco de dados "uvv" usando as credenciais do usuário "amorim" e sua senha correspondente "pedro1"
\c "dbname = uvv user = amorim password = pedro1"

-- cria um novo esquema chamado "lojas" e atribuindo o usuário "amorim" como o proprietário desse esquema
CREATE SCHEMA lojas
AUTHORIZATION amorim
;

-- essa declaração está definindo a ordem de busca de objetos para o usuário "amorim"
ALTER USER amorim
SET SEARCH_PATH TO lojas, "$user", public
;

---------------------------------------------------------------------------------------------------------------------------------------------------------

/* 

           CRIAÇÃO DE TABELAS E COMENTARIOS
		   
*/		   


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- cria tabela produtos
CREATE TABLE lojas.produtos (
    produto_id                NUMERIC(38)  NOT NULL,
    nome                      VARCHAR(255) NOT NULL,
    preco_unitario            NUMERIC(10,2),
    detalhe                   BYTEA,
    imagem                    BYTEA,
    imagem_mime_type          VARCHAR(512),
    imagem_arquivo            VARCHAR(512),
    imagem_charset            VARCHAR(512),
    imagem_ultima_atualizacao DATE
);

-- comentarios sobre a tabela produtos
COMMENT ON TABLE  lojas.produtos                           IS 'nessa tabela se encontra informações sobre os produtos da loja';
COMMENT ON COLUMN lojas.produtos.produto_id                IS 'nessa coluna se encontra o id do produto';
COMMENT ON COLUMN lojas.produtos.nome                      IS 'nessa coluna se encontra o nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS 'nessa coluna se encontra o preço unitário do produto';
COMMENT ON COLUMN lojas.produtos.detalhe                   IS 'nessa coluna se encontra os detalhes do produtor';
COMMENT ON COLUMN lojas.produtos.imagem                    IS 'nessa coluna se encontra a imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS 'nessa coluna se encontra o mime type da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS 'nessa coluna se encontra o arquivo da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset            IS 'nessa coluna se encontra o charset da imagem';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'nessa coluna se encontra a última atualização da imagem do produto';


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- cria a tabela clientes
CREATE TABLE lojas.clientes (
    cliente_id                NUMERIC(38)  NOT NULL,
    email                     VARCHAR(255) NOT NULL,
    nome                      VARCHAR(255) NOT NULL,
    telefone1                 VARCHAR(20),
    telefone2                 VARCHAR(20),
    telefone3                 VARCHAR(20)
);

-- comentarios sobre a tabela clientes
COMMENT ON TABLE  lojas.clientes            IS 'nessa tabela se encontra as informações sobre os clientes da loja';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'nessa coluna se encontra o id do cliente';
COMMENT ON COLUMN lojas.clientes.email      IS 'nessa coluna se encontra o endereço de email do cliente';
COMMENT ON COLUMN lojas.clientes.nome       IS 'nessa coluna se encontra o nome do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1  IS 'nessa coluna se encontra o telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2  IS 'nessa coluna se encontra o segundo telefone do cliente caso o mesmo tenha';
COMMENT ON COLUMN lojas.clientes.telefone3  IS 'nessa coluna se encontra o terceiro telefone do cliente caso o mesmo tenha';


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- cria a tabela lojas
CREATE TABLE lojas.lojas (
    loja_id                   NUMERIC(38)  NOT NULL,
    nome                      VARCHAR(255) NOT NULL,
    endereco_web              VARCHAR(100),
    endereco_fisico           VARCHAR(512),
    latitude                  NUMERIC,
    longitude                 NUMERIC,
    logo                      BYTEA,
    logo_mime_type            VARCHAR(512),
    logo_arquivo              VARCHAR(512),
    logo_charset              VARCHAR(512),
    logo_ultima_atualizacao   DATE
);

-- comentarios sobre a tabela lojas
COMMENT ON TABLE  lojas.lojas                         IS 'nessa tabela se encontra informações sobre as lojas';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS 'nessa coluna se encontra o id da loja';
COMMENT ON COLUMN lojas.lojas.nome                    IS 'nessa coluna se encontra o nome da loja';
COMMENT ON COLUMN lojas.lojas.endereco_web            IS 'nessa coluna se encontra o endereço web da loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico         IS 'nessa coluna se encontra o endereço físico da loja';
COMMENT ON COLUMN lojas.lojas.latitude                IS 'nessa coluna se encontra a latitude da loja';
COMMENT ON COLUMN lojas.lojas.longitude               IS 'nessa coluna se encontra a longitude da loja';
COMMENT ON COLUMN lojas.lojas.logo                    IS 'nessa coluna se encontra o logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type          IS 'nessa coluna se encontra mime type do logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS 'nessa coluna se encontra a localização do arquivo de logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS 'nessa coluna se encontra o conjunto de caracteres utilizado no arquivo de logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'nessa coluna se encontra a data da última atualização do arquivo de logo da loja';


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- cria a tabela pedidos
CREATE TABLE lojas.pedidos (
    pedido_id                 NUMERIC(38) NOT NULL,
    data_hora                 TIMESTAMP   NOT NULL,
    cliente_id                NUMERIC(38) NOT NULL,
    status                    VARCHAR(15) NOT NULL,
    loja_id                   NUMERIC(38) NOT NULL
);

-- comentarios sobre a tabela pedidos
COMMENT ON TABLE  lojas.pedidos            IS 'esta tabela contém informações sobre os pedidos realizados';
COMMENT ON COLUMN lojas.pedidos.pedido_id  IS 'nessa coluna se encontra o id do pedido';
COMMENT ON COLUMN lojas.pedidos.data_hora  IS 'nessa coluna se encontra a data e a hora que o pedido foi realizado';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'nessa coluna se encontra o id do cliente que fez o pedido';
COMMENT ON COLUMN lojas.pedidos.status     IS 'nessa coluna se encontra o status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id    IS 'nessa coluna se encontra o id da loja que o pedido foi feito';


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- cria a tabela estoques
CREATE TABLE lojas.estoques (
    estoque_id                NUMERIC(38) NOT NULL,
    loja_id                   NUMERIC(38) NOT NULL,
    produto_id                NUMERIC(38) NOT NULL,
    quantidade                NUMERIC(38) NOT NULL
);

-- comentarios sobre a tabela estoques
COMMENT ON TABLE  lojas.estoques            IS 'esta tabela contém informações sobre o estoque dos produtos nas lojas';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'nessa coluna se encontra o id do estoque';
COMMENT ON COLUMN lojas.estoques.loja_id    IS 'nessa coluna se encontra o id da loja';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'nessa coluna se encontra o id do produto';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'quantidade de produtos disponíveis no estoque da loja';


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- cria a tabela envios
CREATE TABLE lojas.envios (
    envio_id                  NUMERIC(38)  NOT NULL,
    loja_id                   NUMERIC(38)  NOT NULL,
    cliente_id                NUMERIC(38)  NOT NULL,
    endereco_entrega          VARCHAR(512) NOT NULL,
    status                    VARCHAR(15)  NOT NULL
);

-- comentarios sobre a tabela envios
COMMENT ON TABLE  lojas.envios                  IS 'nessa tabela se encontra informações sobre os envios das lojas';
COMMENT ON COLUMN lojas.envios.envio_id         IS 'nessa coluna se encontra o id do envio';
COMMENT ON COLUMN lojas.envios.loja_id          IS 'nessa coluna se encontra o id da loja';
COMMENT ON COLUMN lojas.envios.cliente_id       IS 'nessa coluna se encontra o id do cliente';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'nessa coluna se encontra o endereço de entregue do envio';
COMMENT ON COLUMN lojas.envios.status           IS 'nessa coluna se encontra o status do envio';


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- cria a tabela itens por pedido
CREATE TABLE lojas.pedidos_itens (
    pedido_id                 NUMERIC(38)   NOT NULL,
    produto_id                NUMERIC(38)   NOT NULL, 
    numero_da_linha           NUMERIC(38)   NOT NULL,
    preco_unitario            NUMERIC(10,2) NOT NULL,
    quantidade                NUMERIC(38)   NOT NULL,
    envio_id                  NUMERIC(38)
);

-- comentarios sobre a tabela itens por pedido
COMMENT ON TABLE  lojas.pedidos_itens                 IS 'nessa tabela relaciona os itens de cada pedido';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id       IS 'nessa coluna se encontra o id do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id      IS 'nessa coluna se encontra o id do produto';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'nessa coluna se encontra o número da linha que um pedido ocupa';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario  IS 'nessa coluna se encontra o preço unitário do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade      IS 'nessa coluna se ecnontra a quantidade que um pedido foi feito';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id        IS 'nessa coluna se encontra o id do envio';


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Definindo as pk e pfk das tabelas e criando a check constraints

---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabela produtos

/*
Adiciona uma restrição de chave primária chamada produtos_pk na tabela lojas.produtos,
utilizando a coluna produto_id como chave primária.
*/
ALTER TABLE lojas.produtos
ADD CONSTRAINT produtos_pk
PRIMARY KEY (produto_id)
;

/*
A diciona uma restrição de verificação chamada preco_check na tabela lojas.produtos,
garantindo que o valor da coluna preco_unitario seja maior ou igual a zero.
*/
ALTER TABLE lojas.produtos
ADD CONSTRAINT preco_check
CHECK (preco_unitario >= 0)
;

/*
Adiciona uma restrição de verificação chamada imagem_check na tabela lojas.produtos,
garantindo que todas as colunas relacionadas à imagem sejam nulas ou preenchidas simultaneamente.
Ou seja, se imagem é nulo, todas as outras colunas relacionadas à imagem também devem ser nulas.
E se imagem não é nulo, todas as outras colunas relacionadas à imagem também não devem ser nulas.
*/
ALTER TABLE lojas.produtos
ADD CONSTRAINT imagem_check
CHECK (
(
    imagem IS NOT NULL AND
    imagem_mime_type IS NOT NULL AND
    imagem_arquivo IS NOT NULL AND
    imagem_charset IS NOT NULL AND
    imagem_ultima_atualizacao IS NOT NULL
)
 OR
(
    imagem IS NULL AND
    imagem_mime_type IS NULL AND
    imagem_arquivo IS NULL AND
    imagem_charset IS NULL AND
    imagem_ultima_atualizacao IS NULL
)
);


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabela clientes

/* 
Adiciona uma restrição de chave primária chamada clientes_pk na tabela lojas.clientes,
utilizando a coluna cliente_id como chave primária. 
*/
ALTER TABLE lojas.clientes
ADD CONSTRAINT clientes_pk
PRIMARY KEY (cliente_id)
;

/* 
Adiciona uma restrição de verificação chamada telefone_check na tabela lojas.clientes,
garantindo que os campos telefone1, telefone2 e telefone3 sejam preenchidos em combinações específicas.
   A restrição permite que:
   - Todos os telefones sejam preenchidos.
   - Apenas telefone1 seja preenchido.
   - Apenas telefone1 e telefone2 sejam preenchidos.
   - Apenas telefone1, telefone2 e telefone3 sejam nulos. 
*/
ALTER TABLE lojas.clientes
ADD CONSTRAINT telefone_check
CHECK (
    telefone3 IS NOT NULL AND telefone2 IS NOT NULL AND telefone1 IS NOT NULL
    OR telefone3 IS NULL AND telefone2 IS NOT NULL AND telefone1 IS NOT NULL
    OR telefone3 IS NULL AND telefone2 IS NULL AND telefone1 IS NOT NULL
    OR telefone3 IS NULL AND telefone2 IS NULL AND telefone1 IS NULL
);


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabela lojas

/*
Adiciona uma restrição de chave primária chamada lojas_pk na tabela lojas.lojas,
utilizando a coluna loja_id como chave primária.
*/
ALTER TABLE lojas.lojas
ADD CONSTRAINT lojas_pk
PRIMARY KEY (loja_id)
;

/*
Adiciona uma restrição de verificação chamada endereco_check na tabela lojas.lojas,
garantindo que pelo menos um dos campos endereco_web ou endereco_fisico seja preenchido.
*/
ALTER TABLE lojas.lojas
ADD CONSTRAINT endereco_check
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL)
;

/* 
Adiciona uma restrição de verificação chamada coordenadas_check na tabela lojas.lojas,
garantindo que as colunas latitude e longitude sejam preenchidas ou nulas em conjunto.
*/
ALTER TABLE lojas.lojas
ADD CONSTRAINT coordenadas_check
CHECK (
    latitude IS NULL AND longitude IS NULL
    OR latitude IS NOT NULL AND longitude IS NOT NULL 
);

/* Adiciona uma restrição de verificação chamada logo_check na tabela lojas.lojas,
garantindo que todas as colunas relacionadas ao logo sejam nulas ou preenchidas simultaneamente.
Ou seja, se logo é nulo, todas as outras colunas relacionadas ao logo também devem ser nulas.
E se logo não é nulo, todas as outras colunas relacionadas ao logo também não devem ser nulas.
*/
ALTER TABLE lojas.lojas
ADD CONSTRAINT logo_check
CHECK (
(
    logo IS NOT NULL AND
    logo_mime_type IS NOT NULL AND
    logo_arquivo IS NOT NULL AND
    logo_charset IS NOT NULL AND
    logo_ultima_atualizacao IS NOT NULL
)
 OR
(
    logo IS NULL AND
    logo_mime_type IS NULL AND
    logo_arquivo IS NULL AND
    logo_charset IS NULL AND
    logo_ultima_atualizacao IS NULL
)
);


---------------------------------------------------------------------------------------------------------------------------------------------------------

--Tabela pedidos

/*
Adiciona uma restrição de chave primária chamada pedidos_pk na tabela lojas.pedidos,
utilizando a coluna pedido_id como chave primária.
*/
ALTER TABLE lojas.pedidos
ADD CONSTRAINT pedidos_pk
PRIMARY KEY (pedido_id)
;

/*
Adiciona uma restrição de chave estrangeira chamada lojas_pedidos_fk na tabela lojas.pedidos,
referenciando a coluna loja_id na tabela lojas.lojas.
*/
ALTER TABLE lojas.pedidos
ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
;

/*
Adiciona uma restrição de chave estrangeira chamada clientes_pedidos_fk na tabela lojas.pedidos,
referenciando a coluna cliente_id na tabela lojas.clientes. 
*/
ALTER TABLE lojas.pedidos
ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
;

/*
Adiciona uma restrição de verificação chamada status_check na tabela lojas.pedidos,
garantindo que o valor da coluna status esteja entre 'enviado', 'cancelado' e 'pago'. 
*/
ALTER TABLE lojas.pedidos
ADD CONSTRAINT status_check
CHECK (status IN ('enviado', 'cancelado', 'pago')
);


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabela estoques

/* 
Adiciona uma restrição de chave primária chamada estoques_pk na tabela lojas.estoques,
utilizando a coluna estoque_id como chave primária. 
*/
ALTER TABLE lojas.estoques
ADD CONSTRAINT estoques_pk
PRIMARY KEY (estoque_id)
;

/* 
Adiciona uma restrição de chave estrangeira chamada produtos_estoques_fk na tabela lojas.estoques,
referenciando a coluna produto_id na tabela lojas.produtos. 
*/
ALTER TABLE lojas.estoques
ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
;

/* 
Adiciona uma restrição de chave estrangeira chamada lojas_estoques_fk na tabela lojas.estoques,
referenciando a coluna loja_id na tabela lojas.lojas. 
*/
ALTER TABLE lojas.estoques
ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
;

/* 
Adiciona uma restrição de verificação chamada quantidade_check na tabela lojas.estoques,
garantindo que o valor da coluna quantidade seja maior que zero. 
*/
ALTER TABLE lojas.estoques
ADD CONSTRAINT quantidade_check
CHECK (quantidade > 0)
;


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabela envios

/* 
Adiciona uma restrição de chave primária chamada envios_pk na tabela lojas.envios,
utilizando a coluna envio_id como chave primária. 
*/
ALTER TABLE lojas.envios
ADD CONSTRAINT envios_pk
PRIMARY KEY (envio_id)
;

/* 
Adiciona uma restrição de chave estrangeira chamada lojas_envios_fk na tabela lojas.envios,
referenciando a coluna loja_id na tabela lojas.lojas. 
*/
ALTER TABLE lojas.envios
ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
;

/* 
Adiciona uma restrição de chave estrangeira chamada clientes_envios_fk na tabela lojas.envios,
referenciando a coluna cliente_id na tabela lojas.clientes. 
*/
ALTER TABLE lojas.envios
ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
;

/* 
Adiciona uma restrição de verificação chamada status_check na tabela lojas.envios,
garantindo que o valor da coluna status esteja entre 'ENVIADO' e 'ENTREGUE'. 
*/
ALTER TABLE lojas.envios
ADD CONSTRAINT status_check
CHECK (status IN ('ENVIADO', 'ENTREGUE')
);


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Tabela pedidos_itens

/* 
Adiciona uma chave primária composta pelas colunas pedido_id e produto_id 
na tabela pedidos_itens 
*/
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT pedidos_itens_pk
PRIMARY KEY (pedido_id, produto_id)
;

/* 
Adiciona uma chave estrangeira na coluna produto_id da tabela pedidos_itens, 
referenciando a coluna produto_id da tabela produtos 
*/
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
;

/* 
Adiciona uma chave estrangeira na coluna pedido_id da tabela pedidos_itens, 
referenciando a coluna pedido_id da tabela pedidos 
*/
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
;

/* 
Adiciona uma chave estrangeira na coluna envio_id da tabela pedidos_itens,
referenciando a coluna envio_id da tabela envios 
*/
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
;

/* 
Adiciona uma restrição de verificação para garantir que a quantidade seja 
maior que zero 
*/
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT quantidade_check
CHECK (quantidade > 0)
;

/* 
Adiciona uma restrição de verificação para garantir que o preço unitário 
seja maior ou igual a zero 
*/
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT preco_check
CHECK (preco_unitario >= 0)
;


---------------------------------------------------------------------------------------------------------------------


\dt lojas.*
