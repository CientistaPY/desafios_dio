### Potência Tech powered by iFood | Ciências de Dados com Python
### Construindo seu Primeiro Projeto Lógico de Banco de Dados
### Desafio 1  - PARTE 2 -- Inserindo dados para o cenário de E-commerce
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]

######## Inserindo dados na tabela "Clients"
USE ecommerce;

INSERT INTO clients (Fname, Minit, Lname, CPF, CNPJ, Address)
VALUES
     ('Marcos', 'M', 'Souza', NULL, '12345678901234', 'Rua Monte Cristo 259, Carmo - Cidade Alta'), -- Cliente 1 (CNPJ)
    ('Amanda', 'O', 'Pereira', '987654322', NULL, 'Rua Alameda 1 213, Alameda - Cidade Baixa'), 	-- Cliente 2 (CPF)
    ('Rafael', 'F', 'Oliveira', '45678914', NULL, 'Avenida  Palmeiras 109, Centro - Cidade Alta'),	-- Cliente 3 (CPF)
    ('Carolina', 'S', 'Ferreira', '789123457', NULL, 'Rua Laranjeiras 749, Centro - Cidade Baixa'), -- Cliente 4 (CPF)
    ('Gustavo', 'G', 'Costa', NULL, '98745632', 'Avenida Monte Cristo 31, Carmo - Cidade Alta'), 	-- Cliente 5 (CNPJ)
    ('Isabel', 'M', 'Santos', NULL, '654789124', 'Rua Alameda 1 132, Alameda - Cidade Baixa'); 		-- Cliente 6 (CNPJ)


######## Inserindo dados na tabela "product"
INSERT INTO product (Pname, classification_kids, category, avaliação, size)
VALUES
    ('Smartphone Samsung', FALSE, 'Eletrônico', 4.5, '6.2"'), 										-- Produto 1
    ('Vestido Floral', TRUE, 'Vestimenta', 4.2, 'M'), 												-- Produto 2
    ('Carrinho de Controle Remoto', TRUE, 'Brinquedos', 3.8, NULL), 								-- Produto 3
    ('TV LED LG', FALSE, 'Eletrônico', 4.7, '50"'), 												-- Produto 4
    ('Cama de Casal', FALSE, 'Móveis', 4.0, 'Queen'), 												-- Produto 5
    ('Arroz Integral', FALSE, 'Alimentos', 4.5, '1kg'), 											-- Produto 6
    ('Fones de Ouvido Bluetooth', FALSE, 'Eletrônico', 3.9, NULL);									-- Produto 7

######## Ajustando dados na tabela "orders"
DELETE FROM orders WHERE idOrderClient IN (1,2,3,4);												-- Deletando registros existentes na tabela "orders" para evitar duplicação
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, payment)
VALUES
    (1, DEFAULT, 'Compra via PIX', 100, 'Crédito'),     													-- Pedido 1 do Cliente 1
    (2, DEFAULT, 'Compra via PIX', 50, 'Débito'),       													-- Pedido 2 do Cliente 2
    (3, 'Confirmado', NULL, NULL, 'Cash'),           													-- Pedido 3 do Cliente 3
    (4, DEFAULT, 'Compra via Site', 150, 'Pix');     													-- Pedido 4 do Cliente 4

######## Inserindo novos registros na tabela "productOrder"
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
VALUES
    (1, 1, 5, NULL),    																			-- Produto 1 no Pedido 1
    (2, 2, 2, NULL),    																			-- Produto 2 no Pedido 2
    (3, 3, 3, NULL);      																			-- Produto 3 no Pedido 3

######## Inserindo novos registros na tabela "productStorage"
INSERT INTO productStorage (storageLocation, quantity) VALUES
    ('Pernambuco', 120000),   																		-- Localização de estoque 1 com quantidade 120000
    ('Pará', 6000),   																		        -- Localização de estoque 2 com quantidade 6000
    ('Paraíba', 10000),   																		    -- Localização de estoque 3 com quantidade 10000
    ('São Paulo', 20000),       																	-- Localização de estoque 4 com quantidade 20000
    ('Brasília', 6000);   																		    -- Localização de estoque 5 com quantidade 6000

######## Inserindo novos registros na tabela "storageLocation"
INSERT INTO storageLocation (idLproduct, idLstorage, location)
VALUES
    (1, 1, 'PE'), 																					-- Produto 1 na Localização de estoque 1
    (2, 2, 'PA'), 																					-- Produto 2 na Localização de estoque 2
    (3, 3, 'PB'); 																					-- Produto 3 na Localização de estoque 3
   
######## Inserindo dados na tabela "supplier"
INSERT INTO supplier (SocialName, CNPJ, contact)
VALUES
    ('Fornecedora ABC', '12345678901234', '21987654321'),			 								-- Fornecedor 1
    ('Eletrônicos XYZ', '56789012345678', '21912345678'),											-- Fornecedor 2
    ('Super Fornecedores', '90123456789012', '21955555555'); 										-- Fornecedor 3

######## Inserindo dados na tabela "productSupplier"
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity)
VALUES
    (1, 1, 500), 																					-- Fornecedor 1, Produto 1, Quantidade 500
    (1, 2, 400), 																					-- Fornecedor 1, Produto 2, Quantidade 400
    (2, 3, 633), 																					-- Fornecedor 2, Produto 3, Quantidade 633
    (3, 3, 5),   																					-- Fornecedor 3, Produto 3, Quantidade 5
    (2, 2, 10);  																					-- Fornecedor 2, Produto 5, Quantidade 10

######## Inserindo dados na tabela "seller"
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact)
VALUES
    ('Eletrônicos Tech', NULL, '12345678901234', NULL, 'São Paulo', '21987654321'),				 	-- Vendedor 1
    ('Fashion Boutique', NULL, NULL, '987654321', 'Rio de Janeiro', '21912345678'),				 	-- Vendedor 2
    ('Kids Paradise', NULL, '45678901234567', NULL, 'Belo Horizonte', '21955555555');			 	-- Vendedor 3
    
######## Inserindo dados na Nova tabela "Delivery"
INSERT INTO Delivery (idOrder, deliveryStatus, trackingCode)
VALUES
    (1, 'Em trânsito', 'ABC123'),																	-- Entrega em trânsito, rastreamento "ABC123" para o pedido com ID 1
    (2, 'Pendente', 'Pendente'), 																	-- Entrega pendente, rastreamento "Pendente" para o pedido com ID 2
    (3, 'Entregue', 'GHI789'); 																		-- Entrega concluída, rastreamento "GHI789" para o pedido com ID 3

