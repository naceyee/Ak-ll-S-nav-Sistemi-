USE AkilliSinavDB;
GO

CREATE OR ALTER VIEW v_GozetmenGorevDagilimi
AS
SELECT 
    p.PersonelID,
    p.Unvan,
    p.Ad + ' ' + p.Soyad AS PersonelAdSoyad,
    b.BolumAd,
    COUNT(ga.AtamaID) AS ToplamGorevSayisi
FROM Personel p
LEFT JOIN Bolumler b ON p.BolumID = b.BolumID
LEFT JOIN GozetmenAtamalari ga ON p.PersonelID = ga.PersonelID
GROUP BY p.PersonelID, p.Unvan, p.Ad, p.Soyad, b.BolumAd;
GO