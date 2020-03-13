-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema pano_online
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pano_online
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pano_online` DEFAULT CHARACTER SET utf8mb4 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `pano_online`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pano_online`.`fornecedor` (
  `id_forn` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_forn` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_forn`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pano_online`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pano_online`.`produto` (
  `id_produto` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(200) NULL DEFAULT NULL,
  `fabricante` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `cor` VARCHAR(30) NULL DEFAULT NULL,
  `valor` DECIMAL(5,2) NULL DEFAULT NULL,
  `fornecedor_id_forn` INT(11) NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `fk_produto_fornecedor1_idx` (`fornecedor_id_forn` ASC) VISIBLE,
  CONSTRAINT `fk_produto_fornecedor1`
    FOREIGN KEY (`fornecedor_id_forn`)
    REFERENCES `pano_online`.`fornecedor` (`id_forn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pano_online`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pano_online`.`cliente` (
  `id_cliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `email` VARCHAR(40) NOT NULL,
  `senha` VARCHAR(128) NOT NULL,
  `data_nasc` DATETIME NOT NULL,
  `genero` CHAR(1) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pano_online`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pano_online`.`endereco` (
  `id_end` INT(11) NOT NULL AUTO_INCREMENT,
  `num_telefone` VARCHAR(11) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `logradouro` VARCHAR(200) NULL DEFAULT NULL,
  `numero` VARCHAR(20) NULL DEFAULT NULL,
  `complemento` VARCHAR(30) NULL DEFAULT NULL,
  `referencia` TEXT NULL DEFAULT NULL,
  `bairro` VARCHAR(60) NULL DEFAULT NULL,
  `cidade` VARCHAR(60) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cliente_id` INT(11) NULL DEFAULT NULL,
  `fornecedor_id` INT(11) NULL DEFAULT NULL,
  `fornecedor_id_forn` INT(11) NOT NULL,
  PRIMARY KEY (`id_end`),
  INDEX `cliente_id` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_endereco_fornecedor1_idx` (`fornecedor_id_forn` ASC) VISIBLE,
  CONSTRAINT `endereco_cliente_ibfk_1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pano_online`.`cliente` (`id_cliente`),
  CONSTRAINT `fk_endereco_fornecedor1`
    FOREIGN KEY (`fornecedor_id_forn`)
    REFERENCES `pano_online`.`fornecedor` (`id_forn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pano_online`.`carrinho_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pano_online`.`carrinho_venda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `valor_frete` DECIMAL(4,2) NULL DEFAULT NULL,
  `total_compra` DECIMAL(8,2) NULL DEFAULT NULL,
  `cliente_id_cliente` INT(11) NOT NULL,
  `endereco_id_end` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_carrinho_venda_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_carrinho_venda_endereco1_idx` (`endereco_id_end` ASC) VISIBLE,
  CONSTRAINT `fk_carrinho_venda_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `pano_online`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrinho_venda_endereco1`
    FOREIGN KEY (`endereco_id_end`)
    REFERENCES `pano_online`.`endereco` (`id_end`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `mydb`.`itens_carrinhos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`itens_carrinhos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `produto_id_produto` INT(11) NOT NULL,
  `carrinho_venda_id` INT(11) NOT NULL,
  `qtd_produto` INT NULL,
  `valor_produto` DECIMAL(5,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_itens_carrinhos_produto_idx` (`produto_id_produto` ASC) VISIBLE,
  INDEX `fk_itens_carrinhos_carrinho_venda1_idx` (`carrinho_venda_id` ASC) VISIBLE,
  CONSTRAINT `fk_itens_carrinhos_produto`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `pano_online`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_carrinhos_carrinho_venda1`
    FOREIGN KEY (`carrinho_venda_id`)
    REFERENCES `pano_online`.`carrinho_venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedidos_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedidos_compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qtd_produtos` INT NULL,
  `valor_produtos` DECIMAL(5,2) NULL,
  `fornecedor_id_forn` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedidos_compra_fornecedor1_idx` (`fornecedor_id_forn` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_compra_fornecedor1`
    FOREIGN KEY (`fornecedor_id_forn`)
    REFERENCES `pano_online`.`fornecedor` (`id_forn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movimentacao_produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movimentacao_produtos` (
  `id_mov_produto` INT NOT NULL AUTO_INCREMENT,
  `num_documento` INT NOT NULL,
  `data_mov` DATETIME NULL,
  `produto_id_produto` INT(11) NOT NULL,
  `qtd_produto` INT NOT NULL,
  `tipo_mov` VARCHAR(45) NOT NULL,
  `itens_carrinhos_id` INT NOT NULL,
  `pedidos_compra_id` INT NOT NULL,
  PRIMARY KEY (`id_mov_produto`),
  INDEX `fk_movimentacao_produtos_produto1_idx` (`produto_id_produto` ASC) VISIBLE,
  INDEX `fk_movimentacao_produtos_itens_carrinhos1_idx` (`itens_carrinhos_id` ASC) VISIBLE,
  INDEX `fk_movimentacao_produtos_pedidos_compra1_idx` (`pedidos_compra_id` ASC) VISIBLE,
  CONSTRAINT `fk_movimentacao_produtos_produto1`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `pano_online`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimentacao_produtos_itens_carrinhos1`
    FOREIGN KEY (`itens_carrinhos_id`)
    REFERENCES `mydb`.`itens_carrinhos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimentacao_produtos_pedidos_compra1`
    FOREIGN KEY (`pedidos_compra_id`)
    REFERENCES `mydb`.`pedidos_compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `pano_online` ;

-- -----------------------------------------------------
-- Table `pano_online`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pano_online`.`categoria` (
  `id_categoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_categoria` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pano_online`.`categoria_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pano_online`.`categoria_produto` (
  `categoria_id_categoria` INT(11) NOT NULL,
  `produto_id_produto` INT(11) NOT NULL,
  PRIMARY KEY (`categoria_id_categoria`, `produto_id_produto`),
  INDEX `fk_categoria_has_produto_produto1_idx` (`produto_id_produto` ASC) VISIBLE,
  INDEX `fk_categoria_has_produto_categoria1_idx` (`categoria_id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_categoria_has_produto_categoria1`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `pano_online`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_has_produto_produto1`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `pano_online`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
