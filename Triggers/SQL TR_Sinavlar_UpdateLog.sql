USE AkilliSinavDB;
GO

CREATE OR ALTER TRIGGER TR_Sinavlar_UpdateLog
ON Sinavlar
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(Tarih) OR UPDATE(OturumID)
    BEGIN
        INSERT INTO Log (SinavID, EskiOturumID, YeniOturumID, EskiTarih, YeniTarih, DegistirenKullanici, DegisimZamani, Aciklama)
        SELECT 
            i.SinavID,
            d.OturumID AS EskiOturumID,
            i.OturumID AS YeniOturumID,
            d.Tarih AS EskiTarih,
            i.Tarih AS YeniTarih,
            SYSTEM_USER AS DegistirenKullanici,
            GETDATE() AS DegisimZamani,
            'Sınav güncellendi. ' + 
            CASE 
                WHEN d.Tarih != i.Tarih AND d.OturumID != i.OturumID 
                    THEN 'Tarih: ' + CAST(d.Tarih AS NVARCHAR) + ' → ' + CAST(i.Tarih AS NVARCHAR) + 
                         ', Oturum: ' + CAST(d.OturumID AS NVARCHAR) + ' → ' + CAST(i.OturumID AS NVARCHAR)
                WHEN d.Tarih != i.Tarih 
                    THEN 'Tarih: ' + CAST(d.Tarih AS NVARCHAR) + ' → ' + CAST(i.Tarih AS NVARCHAR)
                WHEN d.OturumID != i.OturumID 
                    THEN 'Oturum: ' + CAST(d.OturumID AS NVARCHAR) + ' → ' + CAST(i.OturumID AS NVARCHAR)
                ELSE 'Değişiklik yok'
            END AS Aciklama
        FROM inserted i
        INNER JOIN deleted d ON i.SinavID = d.SinavID
        WHERE (d.Tarih != i.Tarih) OR (d.OturumID != i.OturumID);
        
        PRINT 'Güncelleme Log tablosuna kaydedildi.';
    END
END;
GO