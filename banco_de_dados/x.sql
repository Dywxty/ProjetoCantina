-- Tabela Aluno
CREATE TABLE aluno (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    turma VARCHAR(50),
    turno VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(255) NOT NULL
);

-- Tabela Funcionarios
CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(100)
);

-- Tabela Produto
CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

-- Tabela Informacao Nutricional
CREATE TABLE informacao_nutricional (
    id_info INT PRIMARY KEY AUTO_INCREMENT,
    calorias DECIMAL(10,2),
    valor_energetico DECIMAL(10,2),
    nutrientes TEXT,
    id_produtos INT,
    CONSTRAINT fk_info_produto
        FOREIGN KEY (id_produtos) REFERENCES produto(id_produto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela Pedido
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    id_aluno INT,
    CONSTRAINT fk_pedido_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela Item Pedido
CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    quantidades INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    id_pedido INT,
    id_produtos INT,
    CONSTRAINT fk_item_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_item_produto
        FOREIGN KEY (id_produtos) REFERENCES produto(id_produto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela Pagamento
CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    tipo_pagamento VARCHAR(50),
    status_pagamentos VARCHAR(50),
    data_pagamento DATETIME,
    id_pedido INT,
    CONSTRAINT fk_pagamento_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela Divida
CREATE TABLE divida (
    id_divida INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    status VARCHAR(50),
    id_pedido INT,
    id_aluno INT,
    CONSTRAINT fk_divida_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_divida_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Tabela Notificacao
CREATE TABLE notificacao (
    id_notificacao INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT NOT NULL,
    data_envio DATETIME,
    tipo VARCHAR(50),
    id_aluno INT,
    id_funcionario INT,
    CONSTRAINT fk_notificacao_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_notificacao_funcionario
        FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
