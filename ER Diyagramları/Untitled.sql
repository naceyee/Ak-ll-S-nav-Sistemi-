USE AkilliSinavDB;
GO


CREATE TABLE [Bolumler] (
  [BolumID] int PRIMARY KEY IDENTITY(1, 1),
  [BolumAd] varchar(50) UNIQUE NOT NULL
)
GO

CREATE TABLE [Dersler] (
  [DersID] int PRIMARY KEY IDENTITY(1, 1),
  [BolumID] int,
  [DersKodu] varchar(20) NOT NULL,
  [DersAd] varchar(100) NOT NULL,
  [OgrenciSayisi] int NOT NULL,
  [Yariyil] int NOT NULL
)
GO

CREATE TABLE [Personel] (
  [PersonelID] int PRIMARY KEY IDENTITY(1, 1),
  [BolumID] int,
  [Unvan] varchar(30),
  [Ad] varchar(50) NOT NULL,
  [Soyad] varchar(50) NOT NULL
)
GO

CREATE TABLE [PersonelDurum] (
  [DurumID] int PRIMARY KEY IDENTITY(1, 1),
  [PersonelID] int,
  [Tarih] date NOT NULL,
  [OturumID] int,
  [MazeretTuru] varchar(100),
  [Uygun] bit NOT NULL
)
GO

CREATE TABLE [Oturumlar] (
  [OturumID] int PRIMARY KEY IDENTITY(1, 1),
  [OturumAd] varchar(20) NOT NULL,
  [BaslangicSaat] time NOT NULL,
  [BitisSaat] time NOT NULL,
  [GunSirasi] int NOT NULL
)
GO

CREATE TABLE [Derslikler] (
  [DerslikID] int PRIMARY KEY IDENTITY(1, 1),
  [DerslikAd] varchar(30) NOT NULL,
  [Kapasite] int NOT NULL,
  [Tip] varchar(20) NOT NULL,
  [Kat] int NOT NULL,
  [Aktif] bit DEFAULT (1)
)
GO

CREATE TABLE [Sinavlar] (
  [SinavID] int PRIMARY KEY IDENTITY(1, 1),
  [DersID] int,
  [OturumID] int,
  [Tarih] date NOT NULL
)
GO

CREATE TABLE [SinavSalon] (
  [AtamaID] int PRIMARY KEY IDENTITY(1, 1),
  [SinavID] int,
  [DerslikID] int
)
GO

CREATE TABLE [GozetmenAtamalari] (
  [AtamaID] int PRIMARY KEY IDENTITY(1, 1),
  [PersonelID] int,
  [SinavID] int,
  [DerslikID] int,
  [GorevSaati] nvarchar(100)
)
GO

CREATE TABLE [Log] (
  [LogID] int PRIMARY KEY IDENTITY(1, 1),
  [SinavID] int,
  [EskiOturumID] int,
  [YeniOturumID] int,
  [EskiTarih] date,
  [YeniTarih] date,
  [DegistirenKullanici] varchar(50),
  [DegisimZamani] datetime DEFAULT (getdate()),
  [Aciklama] varchar(500)
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = '09:00-10:30',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'GozetmenAtamalari',
@level2type = N'Column', @level2name = 'GorevSaati';
GO

ALTER TABLE [Dersler] ADD FOREIGN KEY ([BolumID]) REFERENCES [Bolumler] ([BolumID])
GO

ALTER TABLE [Personel] ADD FOREIGN KEY ([BolumID]) REFERENCES [Bolumler] ([BolumID])
GO

ALTER TABLE [PersonelDurum] ADD FOREIGN KEY ([PersonelID]) REFERENCES [Personel] ([PersonelID])
GO

ALTER TABLE [PersonelDurum] ADD FOREIGN KEY ([OturumID]) REFERENCES [Oturumlar] ([OturumID])
GO

ALTER TABLE [Sinavlar] ADD FOREIGN KEY ([DersID]) REFERENCES [Dersler] ([DersID])
GO

ALTER TABLE [Sinavlar] ADD FOREIGN KEY ([OturumID]) REFERENCES [Oturumlar] ([OturumID])
GO

ALTER TABLE [SinavSalon] ADD FOREIGN KEY ([SinavID]) REFERENCES [Sinavlar] ([SinavID])
GO

ALTER TABLE [SinavSalon] ADD FOREIGN KEY ([DerslikID]) REFERENCES [Derslikler] ([DerslikID])
GO

ALTER TABLE [GozetmenAtamalari] ADD FOREIGN KEY ([PersonelID]) REFERENCES [Personel] ([PersonelID])
GO

ALTER TABLE [GozetmenAtamalari] ADD FOREIGN KEY ([SinavID]) REFERENCES [Sinavlar] ([SinavID])
GO

ALTER TABLE [GozetmenAtamalari] ADD FOREIGN KEY ([DerslikID]) REFERENCES [Derslikler] ([DerslikID])
GO

ALTER TABLE [Log] ADD FOREIGN KEY ([SinavID]) REFERENCES [Sinavlar] ([SinavID])
GO

ALTER TABLE [Log] ADD FOREIGN KEY ([EskiOturumID]) REFERENCES [Oturumlar] ([OturumID])
GO

ALTER TABLE [Log] ADD FOREIGN KEY ([YeniOturumID]) REFERENCES [Oturumlar] ([OturumID])
GO
