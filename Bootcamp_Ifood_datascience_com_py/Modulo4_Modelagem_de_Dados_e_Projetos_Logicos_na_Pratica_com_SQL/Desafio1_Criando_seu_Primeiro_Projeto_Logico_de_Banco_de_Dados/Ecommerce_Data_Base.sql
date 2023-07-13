### Potência Tech powered by iFood | Ciências de Dados com Python
### Construindo seu Primeiro Projeto Lógico de Banco de Dados
### Desafio 1  - PARTE 1 Criação do banco de dados para o cenário de E-commerce
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

######## Tabela cliente
CREATE TABLE clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY, 				-- ID do cliente
    Fname VARCHAR(10), 										-- Primeiro nome
    Minit CHAR(3), 											-- Inicial do nome do meio
    Lname VARCHAR(20), 										-- Sobrenome
    CPF CHAR(11), 											-- CPF (número de identificação pf)
    CNPJ CHAR(15), 											-- CPF (número de identificação pj)
    Address VARCHAR(255), 									-- Endereço
    CONSTRAINT unique_cpf_client UNIQUE (CPF), 				-- Restrição para CPF único
    CONSTRAINT check_cnpj_cpf CHECK (						-- Restrição onde havera apenas um CNPJ ou um CPF, mas nunca ambos ao mesmo tempo.	
	(CNPJ IS NULL AND CPF IS NOT NULL) OR  
    (CNPJ IS NOT NULL AND CPF IS NULL))
);

ALTER TABLE clients AUTO_INCREMENT = 1;

######## Tabela produto
CREATE TABLE product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,				 -- ID do produto
    Pname VARCHAR(255) NOT NULL, -- Nome do produto
    classification_kids BOOL DEFAULT FALSE, 				-- Classificação para crianças
    category ENUM(											-- Categoria do produto
    'Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'
    ) NOT NULL, 
    avaliação FLOAT DEFAULT 0, -- Avaliação do produto
    size VARCHAR(10) -- Tamanho do produto
);

ALTER TABLE product AUTO_INCREMENT = 1;

######## Tabela orders
CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY, 				-- ID do pedido
    idOrderClient INT, 										-- ID do cliente associado ao pedido
    orderStatus ENUM(										-- Status do pedido	
    'Cancelado','Confirmado','Em processamento') 
    DEFAULT 'Em processamento', 							-- Status padrão
    orderDescription VARCHAR(255), 							-- Descrição do pedido
    sendValue FLOAT DEFAULT 10, 							-- Valor do envio
    payment ENUM(
    'Crédito', 'Débito', 'PIX', 'Cash')
    DEFAULT 'Cash', 										-- Pagamento diversificao
    CONSTRAINT fk_ordes_client FOREIGN KEY (idOrderClient) 
    REFERENCES clients(idClient) ON UPDATE CASCADE			-- Chave estrangeira para associar o cliente ao pedido
);

######## Nova Tabela, Delivery
CREATE TABLE Delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY, 				-- ID da entrega
    idOrder INT, 											-- ID do pedido associado à entrega
    deliveryStatus ENUM(
    'Pendente', 'Em trânsito', 'Entregue'), 				-- Status da entrega
    trackingCode VARCHAR(255), 								-- Código de rastreamento da entrega
    CONSTRAINT fk_delivery_order FOREIGN KEY (idOrder) 
    REFERENCES orders (idOrder) ON UPDATE CASCADE 			-- Chave estrangeira para associar a entrega ao pedido
);


ALTER TABLE orders AUTO_INCREMENT = 1;

######## Tabela productStorage
CREATE TABLE productStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY, 			-- ID do armazenamento do produto
    storageLocation VARCHAR(255), 							-- Localização do armazenamento
     idLstorage INT, 										-- ID do armazenamento da localização
    quantity INT DEFAULT 0 									-- Quantidade do produto no armazenamento
);

ALTER TABLE productStorage AUTO_INCREMENT = 1;

######## tabela supplier
CREATE TABLE supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY, 				-- ID do fornecedor
    SocialName VARCHAR(255) NOT NULL, 						-- Razão social do fornecedor
    CNPJ CHAR(15) NOT NULL, 								-- CNPJ (número de identificação)
    contact CHAR(11) NOT NULL, 								-- Contato do fornecedor
    CONSTRAINT unique_supplier UNIQUE (CNPJ) 				-- Restrição para CNPJ único
);

ALTER TABLE supplier AUTO_INCREMENT = 1;

######## Tabela seller
CREATE TABLE seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY, 				-- ID do vendedor
    SocialName VARCHAR(255) NOT NULL, 						-- Razão social do vendedor
    AbstName VARCHAR(255), 									-- Nome abreviado do vendedor
    CNPJ CHAR(15), 											-- CNPJ (número de identificação)
    CPF CHAR(9), 											-- CPF (número de identificação)
    location VARCHAR(255),								 	-- Localização do vendedor
    contact CHAR(11) NOT NULL, 								-- Contato do vendedor
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ), 			-- Restrição para CNPJ único
    CONSTRAINT unique_cpf_seller UNIQUE (CPF) 				-- Restrição para CPF único
);

ALTER TABLE seller AUTO_INCREMENT = 1;

######## Tabelas de relacionamentos M:N

CREATE TABLE productSeller (
    idPseller INT, 											-- ID do vendedor associado ao produto
    idPproduct INT, 										-- ID do produto associado ao vendedor
    prodQuantity INT DEFAULT 1, 							-- Quantidade do produto fornecido pelo vendedor
    PRIMARY KEY (idPseller, idPproduct), 					-- Chave primária composta pelos IDs do vendedor e do produto
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) 
    REFERENCES seller(idSeller), 							-- Chave estrangeira para associar o vendedor
    CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) 
    REFERENCES product(idProduct) 							-- Chave estrangeira para associar o produto
);

CREATE TABLE productOrder (
    idPOproduct INT, 										-- ID do produto associado ao pedido
    idPOorder INT, 											-- ID do pedido associado ao produto
    poQuantity INT DEFAULT 1, 								-- Quantidade do produto no pedido
    poStatus ENUM('Disponível', 'Sem estoque') 
    DEFAULT 'Disponível', 									-- Status do produto no pedido
    PRIMARY KEY (idPOproduct, idPOorder), 					-- Chave primária composta pelos IDs do produto e do pedido
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOproduct) 
    REFERENCES product(idProduct), 							-- Chave estrangeira para associar o produto
    CONSTRAINT fk_productorder_order FOREIGN KEY (idPOorder) 
    REFERENCES orders(idOrder) 								-- Chave estrangeira para associar o pedido
);

CREATE TABLE storageLocation (
    idLproduct INT, 										-- ID do produto associado à localização de armazenamento
    idLstorage INT, 										-- ID do armazenamento do produto 
    location VARCHAR(255) NOT NULL, 						-- Localização do armazenamento
    PRIMARY KEY (idLproduct, idLstorage), 					-- Chave primária composta pelos IDs do produto e do armazenamento
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) 
    REFERENCES product(idProduct), 							-- Chave estrangeira para associar o produto
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage)
    REFERENCES productStorage(idProdStorage) 				-- Chave estrangeira para associar o armazenamento
);

CREATE TABLE productSupplier (
    idPsSupplier INT, 										-- ID do fornecedor associado ao produto
    idPsProduct INT, 										-- ID do produto associado ao fornecedor
    quantity INT NOT NULL, 									-- Quantidade do produto fornecido pelo fornecedor
    PRIMARY KEY (idPsSupplier, idPsProduct), 				-- Chave primária composta pelos IDs do fornecedor e do produto
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier)
    REFERENCES supplier(idSupplier), 						-- Chave estrangeira para associar o fornecedor
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct)
    REFERENCES product(idProduct) 							-- Chave estrangeira para associar o produto
);


