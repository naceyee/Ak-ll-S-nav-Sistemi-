USE AkilliSinavDB;
GO

USE AkilliSinavDB;
GO

-- =====================================================
-- 1. Dersler Tablosu Index'leri
-- =====================================================

-- BolumID'ye index (JOIN performansý için)
CREATE INDEX IX_Dersler_BolumID ON Dersler(BolumID);

-- DersKodu'na index (arama performansý için)
CREATE INDEX IX_Dersler_DersKodu ON Dersler(DersKodu);

-- Yariyil'e index (sýnýf bazlý sorgular için)
CREATE INDEX IX_Dersler_Yariyil ON Dersler(Yariyil);

-- =====================================================
-- 2. Personel Tablosu Index'leri
-- =====================================================

-- BolumID'ye index
CREATE INDEX IX_Personel_BolumID ON Personel(BolumID);

-- Ad ve Soyad'a index (isimle arama için)
CREATE INDEX IX_Personel_Ad_Soyad ON Personel(Ad, Soyad);

-- =====================================================
-- 3. Sinavlar Tablosu Index'leri
-- =====================================================

-- DersID'ye index (JOIN için)
CREATE INDEX IX_Sinavlar_DersID ON Sinavlar(DersID);

-- OturumID'ye index
CREATE INDEX IX_Sinavlar_OturumID ON Sinavlar(OturumID);

-- Tarih'e index (tarih aralýðý sorgularý için)
CREATE INDEX IX_Sinavlar_Tarih ON Sinavlar(Tarih);

-- Composite index (Tarih + OturumID - birlikte sorgulanýr)
CREATE INDEX IX_Sinavlar_Tarih_Oturum ON Sinavlar(Tarih, OturumID);

-- =====================================================
-- 4. SinavSalon Tablosu Index'leri
-- =====================================================

-- SinavID'ye index
CREATE INDEX IX_SinavSalon_SinavID ON SinavSalon(SinavID);

-- DerslikID'ye index
CREATE INDEX IX_SinavSalon_DerslikID ON SinavSalon(DerslikID);

-- Composite index (SinavID + DerslikID - birlikte sorgulanýr)
CREATE INDEX IX_SinavSalon_Sinav_Derslik ON SinavSalon(SinavID, DerslikID);

-- =====================================================
-- 5. GozetmenAtamalari Tablosu Index'leri
-- =====================================================

-- PersonelID'ye index
CREATE INDEX IX_GozetmenAtamalari_PersonelID ON GozetmenAtamalari(PersonelID);

-- SinavID'ye index
CREATE INDEX IX_GozetmenAtamalari_SinavID ON GozetmenAtamalari(SinavID);

-- DerslikID'ye index
CREATE INDEX IX_GozetmenAtamalari_DerslikID ON GozetmenAtamalari(DerslikID);

-- =====================================================
-- 6. PersonelDurum Tablosu Index'leri
-- =====================================================

-- PersonelID + Tarih + OturumID (birlikte sorgulanýr)
CREATE INDEX IX_PersonelDurum_Personel_Tarih_Oturum ON PersonelDurum(PersonelID, Tarih, OturumID);

-- =====================================================
-- 7. Oturumlar Tablosu Index'i
-- =====================================================

-- GunSirasi ve BaslangicSaat (gün bazlý sorgular için)
CREATE INDEX IX_Oturumlar_Gun_Baslangic ON Oturumlar(GunSirasi, BaslangicSaat);



SELECT 
    t.name AS TabloAdi,
    i.name AS IndexAdi,
    i.type_desc AS IndexTipi,
    STRING_AGG(c.name, ', ') AS Sutunlar
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE t.name NOT LIKE 'sys%'
GROUP BY t.name, i.name, i.type_desc
ORDER BY t.name;