create table tb_cliente(id_cliente bigint(12) not null auto_increment,
						nm_cliente varchar(50) not null,
						nr_cpf_cliente varchar(11),
						Primary Key (id_cliente));
						
create table tb_endereco_cliente(id_cliente bigint(12),
							     ds_rua_cliente varchar(100),
								 ds_bairro_cliente varchar(100),
								 ds_cidade_cliente varchar(100),
								 sg_estado_cliente varchar(2),
								 primary key (id_cliente));