SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

IF OBJECT_ID('dbo.IntegracaoGenesys', 'U') IS NOT NULL DROP TABLE dbo.IntegracaoGenesys;
IF OBJECT_ID('dbo.AppLog', 'U') IS NOT NULL DROP TABLE dbo.AppLog;
IF OBJECT_ID('dbo.ChamadoSLA', 'U') IS NOT NULL DROP TABLE dbo.ChamadoSLA;
IF OBJECT_ID('dbo.ChamadoHistorico', 'U') IS NOT NULL DROP TABLE dbo.ChamadoHistorico;
IF OBJECT_ID('dbo.Chamado', 'U') IS NOT NULL DROP TABLE dbo.Chamado;
IF OBJECT_ID('dbo.RegraSolicitacao', 'U') IS NOT NULL DROP TABLE dbo.RegraSolicitacao;
GO

CREATE TABLE dbo.RegraSolicitacao
(
    RegraSolicitacaoId BIGINT IDENTITY(1,1) NOT NULL,
    AreaResponsavel VARCHAR(100) NOT NULL,
    TipoSolicitacao VARCHAR(200) NOT NULL,
    SubTipoSolicitacao VARCHAR(200) NULL,
    SlaHorasUteis DECIMAL(10,2) NOT NULL,
    ResponsavelPadrao VARCHAR(255) NULL,
    ExigeAnexo BIT NOT NULL CONSTRAINT DF_RegraSolicitacao_ExigeAnexo DEFAULT (0),
    ExigeDeAcordo BIT NOT NULL CONSTRAINT DF_RegraSolicitacao_ExigeDeAcordo DEFAULT (0),
    IntegracaoElegivel BIT NOT NULL CONSTRAINT DF_RegraSolicitacao_Integracao DEFAULT (0),
    Ativo BIT NOT NULL CONSTRAINT DF_RegraSolicitacao_Ativo DEFAULT (1),
    DataCriacao DATETIME2(0) NOT NULL CONSTRAINT DF_RegraSolicitacao_DataCriacao DEFAULT SYSDATETIME(),
    CONSTRAINT PK_RegraSolicitacao PRIMARY KEY CLUSTERED (RegraSolicitacaoId)
);
GO

CREATE TABLE dbo.Chamado
(
    ChamadoId BIGINT IDENTITY(1,1) NOT NULL,
    ChamadoCodigo VARCHAR(50) NOT NULL,
    SequencialId INT NULL,
    DataAbertura DATETIME2(0) NOT NULL,
    AreaResponsavel VARCHAR(100) NOT NULL,
    TipoSolicitacao VARCHAR(200) NOT NULL,
    SubTipoSolicitacao VARCHAR(200) NULL,
    SolicitanteHash VARBINARY(32) NULL,
    ColaboradorImpactadoHash VARBINARY(32) NULL,
    AnalistaResponsavel VARCHAR(255) NULL,
    StatusChamado VARCHAR(50) NOT NULL,
    OrigemAbertura VARCHAR(100) NOT NULL,
    PossuiAnexo BIT NOT NULL CONSTRAINT DF_Chamado_PossuiAnexo DEFAULT (0),
    IntegracaoElegivel BIT NOT NULL CONSTRAINT DF_Chamado_IntegracaoElegivel DEFAULT (0),
    DataConclusao DATETIME2(0) NULL,
    ObservacaoPublica VARCHAR(1000) NULL,
    DataCriacaoRegistro DATETIME2(0) NOT NULL CONSTRAINT DF_Chamado_DataCriacao DEFAULT SYSDATETIME(),
    DataAtualizacaoRegistro DATETIME2(0) NULL,
    CONSTRAINT PK_Chamado PRIMARY KEY CLUSTERED (ChamadoId),
    CONSTRAINT UQ_Chamado_Codigo UNIQUE (ChamadoCodigo),
    CONSTRAINT CK_Chamado_Status CHECK (StatusChamado IN ('Aberto','Em tratativa','Pendente','Concluído','Cancelado')),
    CONSTRAINT CK_Chamado_Datas CHECK (DataConclusao IS NULL OR DataConclusao >= DataAbertura)
);
GO

CREATE TABLE dbo.ChamadoSLA
(
    ChamadoSLAId BIGINT IDENTITY(1,1) NOT NULL,
    ChamadoId BIGINT NOT NULL,
    DataSlaResposta DATETIME2(0) NULL,
    StatusSLA VARCHAR(40) NOT NULL,
    HorasUteisTratativa DECIMAL(10,2) NULL,
    DataUltimaAtualizacao DATETIME2(0) NOT NULL CONSTRAINT DF_ChamadoSLA_DataAtualizacao DEFAULT SYSDATETIME(),
    CONSTRAINT PK_ChamadoSLA PRIMARY KEY CLUSTERED (ChamadoSLAId),
    CONSTRAINT FK_ChamadoSLA_Chamado FOREIGN KEY (ChamadoId) REFERENCES dbo.Chamado (ChamadoId),
    CONSTRAINT CK_ChamadoSLA_Status CHECK (StatusSLA IN ('Dentro do prazo','Fora do prazo','Concluído no prazo','Concluído fora do prazo'))
);
GO

CREATE TABLE dbo.ChamadoHistorico
(
    ChamadoHistoricoId BIGINT IDENTITY(1,1) NOT NULL,
    ChamadoId BIGINT NOT NULL,
    DataEvento DATETIME2(0) NOT NULL CONSTRAINT DF_ChamadoHistorico_DataEvento DEFAULT SYSDATETIME(),
    TipoEvento VARCHAR(100) NOT NULL,
    ValorAnterior VARCHAR(1000) NULL,
    ValorNovo VARCHAR(1000) NULL,
    Origem VARCHAR(100) NOT NULL,
    CONSTRAINT PK_ChamadoHistorico PRIMARY KEY CLUSTERED (ChamadoHistoricoId),
    CONSTRAINT FK_ChamadoHistorico_Chamado FOREIGN KEY (ChamadoId) REFERENCES dbo.Chamado (ChamadoId)
);
GO

CREATE TABLE dbo.AppLog
(
    AppLogId BIGINT IDENTITY(1,1) NOT NULL,
    DataHoraEvento DATETIME2(0) NOT NULL,
    SessaoId VARCHAR(100) NULL,
    TipoEvento VARCHAR(100) NOT NULL,
    ChamadoCodigo VARCHAR(50) NULL,
    FiltroArea VARCHAR(100) NULL,
    FiltroStatus VARCHAR(50) NULL,
    FiltroSLA VARCHAR(50) NULL,
    Resultado VARCHAR(30) NOT NULL,
    Origem VARCHAR(100) NOT NULL CONSTRAINT DF_AppLog_Origem DEFAULT 'PowerApps',
    DataCarga DATETIME2(0) NOT NULL CONSTRAINT DF_AppLog_DataCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_AppLog PRIMARY KEY CLUSTERED (AppLogId),
    CONSTRAINT CK_AppLog_Resultado CHECK (Resultado IN ('Sucesso','Erro','Aviso'))
);
GO

CREATE TABLE dbo.IntegracaoGenesys
(
    IntegracaoGenesysId BIGINT IDENTITY(1,1) NOT NULL,
    ChamadoId BIGINT NOT NULL,
    TipoOperacao VARCHAR(100) NOT NULL,
    StatusIntegracao VARCHAR(30) NOT NULL,
    DataExecucao DATETIME2(0) NOT NULL CONSTRAINT DF_IntegracaoGenesys_DataExecucao DEFAULT SYSDATETIME(),
    RequisicaoResumo VARCHAR(1000) NULL,
    RespostaResumo VARCHAR(1000) NULL,
    MensagemErro VARCHAR(MAX) NULL,
    CONSTRAINT PK_IntegracaoGenesys PRIMARY KEY CLUSTERED (IntegracaoGenesysId),
    CONSTRAINT FK_IntegracaoGenesys_Chamado FOREIGN KEY (ChamadoId) REFERENCES dbo.Chamado (ChamadoId),
    CONSTRAINT CK_IntegracaoGenesys_Status CHECK (StatusIntegracao IN ('Pendente','Sucesso','Erro'))
);
GO

CREATE INDEX IX_RegraSolicitacao_Area_Tipo ON dbo.RegraSolicitacao (AreaResponsavel, TipoSolicitacao, SubTipoSolicitacao) INCLUDE (SlaHorasUteis, ResponsavelPadrao, IntegracaoElegivel, Ativo);
CREATE INDEX IX_Chamado_DataAbertura ON dbo.Chamado (DataAbertura);
CREATE INDEX IX_Chamado_Area_Status ON dbo.Chamado (AreaResponsavel, StatusChamado) INCLUDE (ChamadoCodigo, TipoSolicitacao, SubTipoSolicitacao, AnalistaResponsavel, DataAbertura, IntegracaoElegivel);
CREATE INDEX IX_ChamadoSLA_Status_Data ON dbo.ChamadoSLA (StatusSLA, DataSlaResposta) INCLUDE (ChamadoId, HorasUteisTratativa);
CREATE INDEX IX_ChamadoHistorico_Chamado_Data ON dbo.ChamadoHistorico (ChamadoId, DataEvento) INCLUDE (TipoEvento, Origem);
CREATE INDEX IX_AppLog_Data_Tipo ON dbo.AppLog (DataHoraEvento, TipoEvento) INCLUDE (ChamadoCodigo, Resultado, FiltroArea, FiltroStatus, FiltroSLA);
CREATE INDEX IX_IntegracaoGenesys_Chamado_Status ON dbo.IntegracaoGenesys (ChamadoId, StatusIntegracao) INCLUDE (TipoOperacao, DataExecucao);
GO
