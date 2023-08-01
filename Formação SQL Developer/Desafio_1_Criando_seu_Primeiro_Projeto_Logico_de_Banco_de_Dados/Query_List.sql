### Potência Tech powered by iFood | Ciências de Dados com Python
### Construindo seu Primeiro Projeto Lógico de Banco de Dados
### Desafio 1  - PARTE 3 -- Listando Queries propostas
### Autor: [Luis Pontes]
### Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
### GitHub: [https://github.com/CientistaPY]


#### Recupera todos os registros da tabela "clients"
SELECT * FROM clients;

#### Recupera todos os registros da tabela "product"
SELECT * FROM product;

#### Recupera todos os registros da tabela "orders"
SELECT * FROM orders;

#### Recupera todos os registros da tabela "productOrder"
SELECT * FROM productOrder;

#### Recupera todos os registros da tabela "productStorage"
SELECT * FROM productStorage;

#### Recupera todos os registros da tabela "storageLocation"
SELECT * FROM storageLocation;

#### Recupera todos os registros da tabela "supplier"
SELECT * FROM supplier;

#### Recupera todos os registros da tabela "seller"
SELECT * FROM seller;

#### Recupera o nome completo (CONCAT()), ID do pedido, status do pedido, status de entrega e código de rastreamento para cada cliente
SELECT CONCAT(c.Fname, ' ', c.Lname) AS Client, o.idOrder AS Request, o.orderStatus AS Status,
       d.deliveryStatus AS DeliveryStatus, d.trackingCode AS TrackingCode
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
LEFT JOIN Delivery d ON o.idOrder = d.idOrder;


#### Recupera o nome e sobrenome do cliente, ID do pedido e status do pedido, ordenados pelo nome e sobrenome do cliente em ordem crescente
SELECT Fname, Lname, idOrder, orderStatus, payment
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
ORDER BY Fname;

#### Recupera  a contagem de pedidos realizados por cada cliente
SELECT c.idClient, Fname, COUNT(*) AS Number_of_orders
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY idClient;

 #### Recupera o Vendedor que tambem é Fornecedor através do CNPJ
SELECT s.idSupplier, s.SocialName
FROM supplier s
INNER JOIN seller se ON s.CNPJ = se.CNPJ;


#### Recupera a Relação de produtos fornecedores e estoques com ordenação dos dados (com ORDER BY) e Condições de filtros aos grupos (HAVING Statement)
SELECT p.Pname AS ProductName, s.SocialName AS SupplierName, 
sl.location AS StorageLocation, ps.quantity AS Quantity
FROM product p
INNER JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
INNER JOIN supplier s ON ps.idPsSupplier = s.idSupplier
INNER JOIN storageLocation sl ON p.idProduct = sl.idLproduct
HAVING Quantity > 5
ORDER BY Quantity;



 #### Recupera a Relação fornecedores e nomes dos produtos
SELECT s.SocialName AS SupplierName, p.Pname AS ProductName
FROM product p
INNER JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
INNER JOIN supplier s ON ps.idPsSupplier = s.idSupplier
INNER JOIN storageLocation sl ON p.idProduct = sl.idLproduct;



