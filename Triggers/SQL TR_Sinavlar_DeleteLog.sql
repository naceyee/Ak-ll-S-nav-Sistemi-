USE AkilliSinavDB;
GO

CREATE OR ALTER TRIGGER TR_Sinavlar_DeleteLog
ON Sinavlar
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Log (SinavID, EskiOturumID, YeniOturumID, EskiTarih, YeniTarih, DegistirenKullanici, DegisimZamani, Aciklama)
    SELECT 
        d.SinavID,
        d.OturumID AS EskiOturumID,
        NULL AS YeniOturumID,
        d.Tarih AS EskiTarih,
        NULL AS YeniTarih,
        SYSTEM_USER AS DegistirenKullanici,
        GETDATE() AS DegisimZamani,
        'Sýnav kaydý silindi. DersID: ' + CAST(d.DersID AS NVARCHAR) + 
        ', OturumID: ' + CAST(d.OturumID AS NVARCHAR) +
        ', Tarih: ' + CAST(d.Tarih AS NVARCHAR) AS Aciklama
    FROM deleted d;
    
    IF @@ROWCOUNT > 0
        PRINT CAST(@@ROWCOUNT AS NVARCHAR) + ' sýnav kaydý silindi ve Log tablosuna kaydedildi.';
END;
GO