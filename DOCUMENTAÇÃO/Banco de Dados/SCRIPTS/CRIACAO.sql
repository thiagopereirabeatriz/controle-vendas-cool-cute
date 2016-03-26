CREATE TABLE StatusPedido (
  stpCodigo INTEGER AUTO_INCREMENT,
  stpDescricao VARCHAR(255) NOT NULL,
  PRIMARY KEY(stpCodigo)
);
CREATE TABLE StatusAnuncio (
  staCodigo INTEGER AUTO_INCREMENT,
  staDescricao VARCHAR(255) NOT NULL,
  PRIMARY KEY(staCodigo)
);
CREATE TABLE Produto (
  proCodigo INTEGER AUTO_INCREMENT,
  proNome VARCHAR(255) NOT NULL,
  proEstoqueMin INTEGER UNSIGNED DEFAULT 0,
  proIsAtivo BOOL NOT NULL,
  PRIMARY KEY(proCodigo)
);
CREATE TABLE Usuario (
  usrCodigo INTEGER AUTO_INCREMENT,
  usrLogin VARCHAR(255) NOT NULL,
  usrSenha VARCHAR(255) NOT NULL,
  usrIsAdministrador BOOL NOT NULL,
  usrIsAtivo BOOL NOT NULL,
  PRIMARY KEY(usrCodigo)
);
CREATE TABLE TipoAvaliacoes (
  tivCodigo INTEGER AUTO_INCREMENT,
  tivDescricao INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(tivCodigo)
);
CREATE TABLE TipoAnuncio (
  tiaCodigo INTEGER AUTO_INCREMENT,
  tiaDescricao VARCHAR(255) NOT NULL,
  tiaPercentual DECIMAL NOT NULL,
  PRIMARY KEY(tiaCodigo)
);
CREATE TABLE Cliente (
  cliCodigo INTEGER AUTO_INCREMENT,
  cliNome VARCHAR(255) NOT NULL,
  cliEmail VARCHAR(255) NOT NULL,
  PRIMARY KEY(cliCodigo)
);
CREATE TABLE OutrasMovimentacoes (
  movCodigo INTEGER AUTO_INCREMENT,
  movDescricao VARCHAR(255) NOT NULL,
  movValor DECIMAL NOT NULL,
  movData DATE NOT NULL,
  PRIMARY KEY(movCodigo)
);
CREATE TABLE Entrada (
  entCodigo INTEGER AUTO_INCREMENT,
  entLote VARCHAR(255) NOT NULL,
  entValorTotal DECIMAL NOT NULL,
  entObservacao VARCHAR(255),
  PRIMARY KEY(entCodigo)
);
CREATE TABLE TipoMovimentacao (
  timCodigo INTEGER AUTO_INCREMENT,
  movCodigo INTEGER NOT NULL,
  timDescricao VARCHAR(255) NOT NULL,
  timOperacao BOOL NOT NULL,
  PRIMARY KEY(timCodigo),
  FOREIGN KEY(movCodigo) REFERENCES OutrasMovimentacoes(movCodigo)
);
CREATE TABLE ProdutoEstoque (
  estCodigo INTEGER AUTO_INCREMENT,
  proCodigo INTEGER NOT NULL,
  estPreco DECIMAL NOT NULL,
  estQuantidade INTEGER NOT NULL,
  PRIMARY KEY(estCodigo),
  FOREIGN KEY(proCodigo) REFERENCES Produto(proCodigo)
);
CREATE TABLE Anuncio (
  anuCodigo INTEGER AUTO_INCREMENT,
  staCodigo INTEGER NOT NULL,
  tiaCodigo INTEGER NOT NULL,
  anuDescricao VARCHAR(255) NOT NULL,
  anuPreco DECIMAL NOT NULL,
  anuDataCriacao DATE NOT NULL,
  anuIsAtivo BOOL NOT NULL,
  PRIMARY KEY(anuCodigo),
  FOREIGN KEY(tiaCodigo) REFERENCES TipoAnuncio(tiaCodigo),
  FOREIGN KEY(staCodigo) REFERENCES StatusAnuncio(staCodigo)
);
CREATE TABLE ItensEntrada (
  proCodigo INTEGER NOT NULL,
  entCodigo INTEGER NOT NULL,
  iteQuantidade INTEGER UNSIGNED NOT NULL,
  iteValor DECIMAL,
  iteValorTotal DECIMAL,
  FOREIGN KEY(entCodigo) REFERENCES Entrada(entCodigo),
  FOREIGN KEY(proCodigo) REFERENCES Produto(proCodigo)
);
CREATE TABLE Pedido (
  pedCodigo INTEGER AUTO_INCREMENT,
  tivCodigo INTEGER NOT NULL,
  stpCodigo INTEGER NOT NULL,
  anuCodigo INTEGER NOT NULL,
  cliCodigo INTEGER NOT NULL,
  pedDataVenda DATE NOT NULL,
  pedValorFrete DECIMAL NOT NULL DEFAULT 0,
  pedDataPostagem DATE,
  pedDataEntrega DATE,
  pedValorTotal DECIMAL NOT NULL,
  pedCodigoPostagem VARCHAR(255),
  pedObservacao VARCHAR(255),
  PRIMARY KEY(pedCodigo),
  FOREIGN KEY(cliCodigo) REFERENCES Cliente(cliCodigo),
  FOREIGN KEY(anuCodigo) REFERENCES Anuncio(anuCodigo),
  FOREIGN KEY(stpCodigo) REFERENCES StatusPedido(stpCodigo),
  FOREIGN KEY(tivCodigo) REFERENCES TipoAvaliacoes(tivCodigo)
);
CREATE TABLE ItensPedido (
  pedCodigo INTEGER NOT NULL,
  proCodigo INTEGER NOT NULL,
  itpValorVenda DECIMAL NOT NULL,
  itpValorCompra DECIMAL NOT NULL,
  itpTaxa DECIMAL NOT NULL,
  FOREIGN KEY(proCodigo) REFERENCES Produto(proCodigo),
  FOREIGN KEY(pedCodigo) REFERENCES Pedido(pedCodigo)
);