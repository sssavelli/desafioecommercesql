-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, CNPJ, Address) 
	   values('Maria','M','Silva', 12346789, null, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Rei dos Pasteis',null,null, null, 9876543215784,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913, null,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456, null,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Correia Ltda',null,null, null, 987456314256,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123, null,'rua alemeda das flores 28, Centro - Cidade das flores');


-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, avaliacao, size) values
							  ('Fone de ouvido',false,'Eletrônicos','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônicos','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônicos','3',null);

select * from clients;
select * from product;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
insert into payments (idClient, idPayment, typePayment) values 
							 (1, 1,'Boleto'),
                             (1, 2,'Cartão'),
                             (1, 3,'Dois cartões'),
                             (2, 1,'Boleto'),
                             (3, 1,'Cartão'),
                             (4, 1,'Boleto'),
                             (4, 2,'Cartão'),
                             (5, 1,'Cartão'),
                             (6, 1,'Boleto'),
                             (6, 2,'Cartão');


delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash, idPayment, trackCode) values 
							 (1, default,'compra via aplicativo',null,1,1,null),
                             (2,default,'compra via aplicativo',50,0,1,null),
                             (5,'Confirmado',null,null,1,1,'QJ4Z58TPX'),
                             (6,default,'compra via web site',150,0,2,null),
                             (3,'Confirmado',null,null,1,1,'YT982LO0P');

-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,2,1,null),
                         (5,3,1,null),
                         (3,4,1,null),
                         (4,5,1,null);

-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);

select * from seller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idProduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);

-- informações de clientes

select *
from clients;

-- informações de produtos eletrônicos

select *
from product p
where p.category = 'Eletrônicos';

-- Quantidade de produtos comprados por categoria

select sum(poQuantity) qtd_products, p.category
from productOrder po, product p
where po.idPOproduct = p.idProduct
group by p.category;

-- Pessoas físicas e suas respectivas compras em ordem alfabética
select concat(c.Fname, ' ', Lname), orderStatus,  Pname, category
from clients c, orders o, productOrder po, product p
where c.idClient = o.idOrderClient
and o.idOrder = po.idPOorder
and po.idPOproduct = p.idProduct
and c.CPF is not null
order by 1;

-- Produtos com estoques de 100 ou mais
select p.Pname, sum(ps.quantity)
from storageLocation sl, productStorage ps, product p
where sl.idLproduct = p.idProduct
and sl.idLstorage = ps.idProdStorage
group by Pname
having sum(ps.quantity) >= 100;

