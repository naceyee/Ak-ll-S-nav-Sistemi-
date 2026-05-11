USE AkilliSinavDB;
GO

CREATE OR ALTER VIEW v_SinavProgrami
AS
SELECT 
    s.SinavID,
    d.DersKodu,
    d.DersAd,
    b.BolumAd,
    s.Tarih,
    o.OturumAd,
    o.BaslangicSaat,
    o.BitisSaat,
    STRING_AGG(dl.DerslikAd, ', ') AS Salonlar,
    STRING_AGG(p.Ad + ' ' + p.Soyad, ', ') AS Gozetmenler
FROM Sinavlar s
JOIN Dersler d ON s.DersID = d.DersID
JOIN Bolumler b ON d.BolumID = b.BolumID
JOIN Oturumlar o ON s.OturumID = o.OturumID
LEFT JOIN SinavSalon ss ON s.SinavID = ss.SinavID
LEFT JOIN Derslikler dl ON ss.DerslikID = dl.DerslikID
LEFT JOIN GozetmenAtamalari ga ON s.SinavID = ga.SinavID AND ss.DerslikID = ga.DerslikID
LEFT JOIN Personel p ON ga.PersonelID = p.PersonelID
GROUP BY s.SinavID, d.DersKodu, d.DersAd, b.BolumAd, s.Tarih, o.OturumAd, o.BaslangicSaat, o.BitisSaat;
GO