-- Criação do banco de dados
CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela cliente
CREATE TABLE clients (
  idClient INT AUTO_INCREMENT PRIMARY KEY,
  Fname VARCHAR(10),
  Minit CHAR(3),
  Lname VARCHAR(20),
  CPF CHAR(11) NOT NULL,
  Address VARCHAR(255),
  IsPJ BOOL DEFAULT FALSE,
  IsPF BOOL DEFAULT FALSE,
  CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

-- Tabela pagamento
CREATE TABLE payments (
  idPayment INT AUTO_INCREMENT PRIMARY KEY,
  idClient INT,
  typePayment ENUM('Boleto','Cartão','Dois cartões'),
  limitAvailable FLOAT,
  PRIMARY KEY (idClient, idPayment),
  CONSTRAINT fk_payments_clients FOREIGN KEY (idClient) REFERENCES clients (idClient)
);

-- Tabela pedido
CREATE TABLE orders (
  idOrder INT AUTO_INCREMENT PRIMARY KEY,
  idClient INT,
  orderStatus ENUM('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
  orderDescription VARCHAR(255),
  sendValue FLOAT DEFAULT 10,
  paymentCash BOOL DEFAULT FALSE,
  CONSTRAINT fk_orders_clients FOREIGN KEY (idClient) REFERENCES clients (idClient)
);

-- Tabela produto
CREATE TABLE products (
  idProduct INT AUTO_INCREMENT PRIMARY KEY,
  Pname VARCHAR(255) NOT NULL,
  classification_kids BOOL DEFAULT FALSE,
  category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
  avaliação FLOAT DEFAULT 0,
  size VARCHAR(10)
);

-- Tabela estoque
CREATE TABLE storage (
  idStorage INT AUTO_INCREMENT PRIMARY KEY,
  storageLocation VARCHAR(255),
  quantity INT DEFAULT 0
);

-- Tabela fornecedor
CREATE TABLE suppliers (
  idSupplier INT AUTO_INCREMENT PRIMARY KEY,
  SocialName VARCHAR(255) NOT NULL,
  CNPJ CHAR(15) NOT NULL,
  contact CHAR(11) NOT NULL,
  CONSTRAINT unique_cnpj_supplier UNIQUE (CNPJ)
);

-- Tabela vendedor
CREATE TABLE sellers (
  idSeller INT AUTO_INCREMENT PRIMARY KEY,
  SocialName VARCHAR(255) NOT NULL,
  AbstName VARCHAR(255),
  CNPJ CHAR(15),
  CPF CHAR(9),
  location VARCHAR(255),
  contact CHAR(11) NOT NULL,
  CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
  CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- Tabela de relacionamento M:N entre produto e fornecedor
CREATE TABLE product_supplier (
  idProduct INT,
  idSupplier INT,
  quantity INT NOT NULL,
  PRIMARY KEY (idProduct, idSupplier),
  CONSTRAINT fk_product_supplier_product FOREIGN KEY (idProduct) REFERENCES products (idProduct),
  CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idSupplier) REFERENCES suppliers (idSupplier)
);

-- Tabela de relacionamento M:N entre produto e vendedor
CREATE TABLE product_seller (
  idProduct INT,
  idSeller INT,
  prodQuantity INT DEFAULT 1,
  PRIMARY KEY (idProduct, idSeller),
  CONSTRAINT fk_product_seller_product FOREIGN KEY (idProduct) REFERENCES products (idProduct),
  CONSTRAINT fk_product_seller_seller FOREIGN KEY (idSeller) REFERENCES sellers (idSeller)
);

-- Tabela de relacionamento M:N entre pedido e produto
CREATE TABLE order_product (
  idOrder INT,
  idProduct INT,
  poQuantity INT DEFAULT 1,
  poStatus ENUM('Disponível', 'Indisponível') DEFAULT 'Disponível',
  PRIMARY KEY (idOrder, idProduct),
  CONSTRAINT fk_order_product_order FOREIGN KEY (idOrder) REFERENCES orders (idOrder),
  CONSTRAINT fk_order_product_product FOREIGN KEY (idProduct) REFERENCES products (idProduct)
);


