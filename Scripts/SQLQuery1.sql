CREATE TABLE Contracts (
  [ContractID] int NOT NULL IDENTITY,
  [CustomerName] varchar(100) NOT NULL,
  [Address] varchar(150) NOT NULL,
  [Gender] varchar(1) NOT NULL,
  [Country] varchar(50) NOT NULL,
  [Dateofbirth] datetime2(0) NOT NULL,
  [SaleDate] datetime2(0) NOT NULL,
  [CoveragePlan] varchar(15) DEFAULT NULL,
  [NetPrice] decimal(8,2) DEFAULT NULL,
  PRIMARY KEY ([ContractID])
)  ;

CREATE TABLE CoveragePlan (
  [CoveragePlan] varchar(15) NOT NULL,
  [EDateFrom] datetime2(0) NOT NULL,
  [EDateTo] datetime2(0) NOT NULL,
  [ECountry] varchar(35) NOT NULL,
  [CPID] int NOT NULL IDENTITY,
  PRIMARY KEY ([CPID])
)  ;


CREATE TABLE RateChart (
  [CoveragePlan] varchar(15) NOT NULL,
  [Gender] varchar(1) NOT NULL,
  [Age] varchar(25) NOT NULL,
  [NetPrice] decimal(8,2) NOT NULL,
  [RCID] int NOT NULL IDENTITY,
  PRIMARY KEY ([RCID])
)  ;