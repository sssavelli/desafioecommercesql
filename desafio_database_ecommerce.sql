create database ecommerce;

use ecommerce;

create table clients(
	idClient int auto_increment primary key,
    Fname varchar(255),
    Minit varchar(3),
    Lname varchar(20),
    CNPJ char(15),
    CPF char(11),
    Address varchar(255),
    constraint unique_cnpj_client unique(CNPJ),
    constraint unique_cpf_client unique(CPF)
);

alter table clients auto_increment = 1;

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(255) not null,
    classification_kids bool default false,
	category enum('Eletrônicos', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliacao float default 0,
    size varchar(10)
);

alter table product auto_increment = 1;

desc product;

create table payments(
	idClient int,
    idPayment int,
    typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
    primary key (idClient, idPayment)
);

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento'),
    orderDescription varchar(255),
    sendValue float default 0,
    paymentCash bool default false,
    idPayment int,
    trackCode varchar(30),
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient),
    constraint fk_order_payment foreign key (idOrderClient, idPayment) references payments(idClient, idPayment)
);

alter table orders auto_increment = 1;

create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

alter table productStorage auto_increment = 1;

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);

alter table supplier auto_increment = 1;

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique(CNPJ),
    constraint unique_cpf_seller unique(CPF)
);

alter table seller auto_increment = 1;

create table productSeller(
	idPSeller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPSeller, idProduct),
    constraint fk_pseller_seller foreign key (idPSeller) references seller (idSeller),
    constraint fk_pseller_product foreign key (idProduct) references product (idProduct)
);

create table productOrder (
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_porder_product foreign key (idPOproduct) references product (idProduct),
    constraint fk_porder_order foreign key (idPOorder) references orders (idOrder)
);

create table storageLocation (
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_slocation_product foreign key (idLproduct) references product (idProduct),
    constraint fk_slocation_storage foreign key (idLstorage) references productStorage (idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_psupplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_psupplier_prodcut foreign key (idPsProduct) references product(idProduct)
);