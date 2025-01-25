CREATE DATABASE ecommerce;
USE ecommerce;


create table client(
	idClient int auto_increment primary key,
    fname varchar(10),
    Minit char(3),
    lname varchar(50),
    CPF char(11) not null,
    adress varchar(30),
    constraint unique_cpf_client unique (CPF)
);
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum('Eletronico', 'Vestimenta','Brinquedo', 'Alimento') not null,
    avaliacao float default 0,
    size varchar(10)
	
);
desc product;
create table payments(
	idClient int,
    idPayment int,
    typePayment enum('Boleto', 'Cartao', 'Dois cartoes'),
    limitAvailable float,
    primary key (idClient, idPayment)
);
create table orders(
	idOrders int auto_increment primary key,
    idOrdersClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') not null,
    ordersDescription varchar(255),
    sendValue float default 0,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrdersClient) references client(idClient)
    
);
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar (255) not null,
    CNPJ char (15) not null,
    contact char (11) not null,
    constraint unique_supplier unique (CNPJ)
);
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation	varchar (255),
    quantity int default 0

);

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar (255),
    CNPJ char (15),
    CPF char (9),
    location varchar (255),
    contact char (11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
    
);
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product (idProduct)
);

create table productOrder(
	idPOproduct int,
    idPOoRder int,
    poQuantity int default 1,
    poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
    primary key (idPOproduct, idPOoRder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOoRder) references orders(idOrders)
);
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar (200) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_productstorage_seller foreign key (idLproduct) references product(idProduct),
    constraint fk_productstorage_product foreign key (idLstorage) references productStorage(idProdStorage)
);
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
-- Inserindo clientes
INSERT INTO client (fname, Minit, lname, CPF, adress) VALUES
('Ana', 'M', 'Silva', '12345678901', 'Rua A, 123'),
('Bruno', 'L', 'Souza', '23456789012', 'Rua B, 456'),
('Carlos', 'F', 'Olive', '34567890123', 'Rua C, 789');

-- Inserindo produtos
INSERT INTO product (Pname, classification_kids, category, avaliacao, size) VALUES
('Celular', false, 'Eletronico', 4.5, 'Médio'),
('Camiseta', false, 'Vestimenta', 4.8, 'G'),
('Boneca', true, 'Brinquedo', 4.9, 'Pequeno'),
('Chocolate', true, 'Alimento', 4.7, 'Pequeno');

-- Inserindo pedidos
INSERT INTO orders (idOrdersClient, orderStatus, ordersDescription, sendValue, paymentCash) VALUES
(1, 'Confirmado', 'Compra de um celular', 10.00, false),
(2, 'Em processamento', 'Compra de uma camiseta', 5.00, true),
(3, 'Cancelado', 'Compra de uma boneca', 0.00, false);

-- Inserindo fornecedores
INSERT INTO supplier (SocialName, CNPJ, contact) VALUES
('Fornecedor A', '12345678000101', '11987654321'),
('Fornecedor B', '23456789000112', '11912345678');

-- Inserindo estoque de produtos
INSERT INTO productStorage (storageLocation, quantity) VALUES
('Depósito A', 100),
('Depósito B', 200),
('Depósito C', 150);

-- Inserindo vendedores
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact) VALUES
('Vendedor A', 'Vda', '12345678000101', '987654321', 'Loja A', '11987654321'),
('Vendedor B', 'Vdb', '23456789000112', '987654322', 'Loja B', '11912345678');

SELECT fname, lname, adress FROM client;

SELECT Pname, category, avaliacao
FROM product
WHERE category = 'Eletronico' AND avaliacao > 4.0;

SELECT Pname, avaliacao, 
       CASE 
           WHEN avaliacao >= 4.5 THEN 'Excelente'
           ELSE 'Bom'
       END AS classificacao
FROM product;

SELECT fname, lname, adress 
FROM client
ORDER BY fname ASC;

SELECT idOrdersClient, COUNT(*) AS total_pedidos
FROM orders
GROUP BY idOrdersClient
HAVING total_pedidos > 1;

SELECT client.fname, client.lname, orders.ordersDescription
FROM client
INNER JOIN orders ON client.idClient = orders.idOrdersClient;

