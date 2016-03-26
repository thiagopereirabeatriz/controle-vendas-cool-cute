CREATE TABLE StatusPedido (
  stpCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  stpDescricao VARCHAR(255) NOT NULL,
  PRIMARY KEY(stpCodigo)
);

CREATE TABLE StatusAnuncio (
  staCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  staDescricao VARCHAR(255) NOT NULL,
  PRIMARY KEY(staCodigo)
);

CREATE TABLE Produto (
  proCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  proNome VARCHAR(255) NOT NULL,
  proEstoqueMin INTEGER UNSIGNED NULL DEFAULT 0,
  proIsAtivo BOOL NOT NULL,
  PRIMARY KEY(proCodigo)
);

CREATE TABLE Usuario (
  usrCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  usrLogin VARCHAR(255) NOT NULL,
  usrSenha VARCHAR(255) NOT NULL,
  usrIsAdministrador BOOL NOT NULL,
  usrIsAtivo BOOL NOT NULL,
  PRIMARY KEY(usrCodigo)
);

CREATE TABLE TipoAvaliacoes (
  tivCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tivDescricao INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(tivCodigo)
);

CREATE TABLE TipoAnuncio (
  tiaCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tiaDescricao VARCHAR(255) NOT NULL,
  tiaPercentual DECIMAL NOT NULL,
  PRIMARY KEY(tiaCodigo)
);

CREATE TABLE Cliente (
  cliCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  cliNome VARCHAR(255) NOT NULL,
  cliEmail VARCHAR(255) NOT NULL,
  PRIMARY KEY(cliCodigo)
);

CREATE TABLE OutrasMovimentacoes (
  movCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  movDescricao VARCHAR(255) NOT NULL,
  movValor DECIMAL NOT NULL,
  movData DATE NOT NULL,
  PRIMARY KEY(movCodigo)
);

CREATE TABLE Entrada (
  entCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  entLote VARCHAR(255) NOT NULL,
  entValorTotal DECIMAL NOT NULL,
  entObservacao VARCHAR(255) NULL,
  PRIMARY KEY(entCodigo)
);

CREATE TABLE TipoMovimentacao (
  timCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  movCodigo INTEGER UNSIGNED NOT NULL,
  timDescricao VARCHAR(255) NOT NULL,
  timOperacao BOOL NOT NULL,
  PRIMARY KEY(timCodigo),
  FOREIGN KEY(movCodigo)
    REFERENCES OutrasMovimentacoes(movCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE ProdutoEstoque (
  estCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  proCodigo INTEGER UNSIGNED NOT NULL,
  estPreco DECIMAL NOT NULL,
  estQuantidade INTEGER NOT NULL,
  PRIMARY KEY(estCodigo),
  FOREIGN KEY(proCodigo)
    REFERENCES Produto(proCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Anuncio (
  anuCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  staCodigo INTEGER UNSIGNED NOT NULL,
  tiaCodigo INTEGER UNSIGNED NOT NULL,
  anuDescricao VARCHAR(255) NOT NULL,
  anuPreco DECIMAL NOT NULL,
  anuDataCriacao DATE NOT NULL,
  anuIsAtivo BOOL NOT NULL,
  PRIMARY KEY(anuCodigo),
  FOREIGN KEY(tiaCodigo)
    REFERENCES TipoAnuncio(tiaCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(staCodigo)
    REFERENCES StatusAnuncio(staCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE ItensEntrada (
  proCodigo INTEGER UNSIGNED NOT NULL,
  entCodigo INTEGER UNSIGNED NOT NULL,
  iteQuantidade INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  iteValor DECIMAL NULL,
  iteValorTotal DECIMAL NULL
  FOREIGN KEY(entCodigo)
    REFERENCES Entrada(entCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(proCodigo)
    REFERENCES Produto(proCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Pedido (
  pedCodigo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tivCodigo INTEGER UNSIGNED NOT NULL,
  stpCodigo INTEGER UNSIGNED NOT NULL,
  anuCodigo INTEGER UNSIGNED NOT NULL,
  cliCodigo INTEGER UNSIGNED NOT NULL,
  pedDataVenda DATE NOT NULL,
  pedValorFrete DECIMAL NOT NULL DEFAULT 0,
  pedDataPostagem DATE NULL,
  pedDataEntrega DATE NULL,
  pedValorTotal DECIMAL NOT NULL,
  pedCodigoPostagem VARCHAR(255) NULL,
  pedObservacao VARCHAR(255) NULL,
  PRIMARY KEY(pedCodigo),
  FOREIGN KEY(cliCodigo)
    REFERENCES Cliente(cliCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(anuCodigo)
    REFERENCES Anuncio(anuCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(stpCodigo)
    REFERENCES StatusPedido(stpCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(tivCodigo)
    REFERENCES TipoAvaliacoes(tivCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE ItensPedido (
  pedCodigo INTEGER UNSIGNED NOT NULL,
  proCodigo INTEGER UNSIGNED NOT NULL,
  itpValorVenda DECIMAL NOT NULL,
  itpValorCompra DECIMAL NOT NULL,
  itpTaxa DECIMAL NOT NULL
  FOREIGN KEY(proCodigo)
    REFERENCES Produto(proCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(pedCodigo)
    REFERENCES Pedido(pedCodigo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);


