USE AkilliSinavDB;
GO

-- =====================================================
-- TR_003: Kapasite Kontrol Trigger
-- =====================================================
-- AMAÇ: SinavSalon tablosuna ekleme/güncelleme yapılırken
--       toplam salon kapasitesinin dersin öğrenci sayısını 
--       karşılayıp karşılamadığını kontrol eder.
--       Eğer kapasite yetersizse işlemi engeller.
-- =====================================================

CREATE OR ALTER TRIGGER TR_SinavSalon_KapasiteKontrol
ON SinavSalon
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SinavID INT;
    DECLARE @DersID INT;
    DECLARE @OgrenciSayisi INT;
    DECLARE @ToplamKapasite INT;
    DECLARE @HataMesaji NVARCHAR(500);
    
    -- Eklenen veya güncellenen SinavID'leri al
    DECLARE sinav_cursor CURSOR FOR
        SELECT DISTINCT SinavID FROM inserted;
    
    OPEN sinav_cursor;
    FETCH NEXT FROM sinav_cursor INTO @SinavID;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Sınavın dersini ve dersin öğrenci sayısını bul
        SELECT @DersID = DersID 
        FROM Sinavlar 
        WHERE SinavID = @SinavID;
        
        IF @DersID IS NOT NULL
        BEGIN
            SELECT @OgrenciSayisi = OgrenciSayisi 
            FROM Dersler 
            WHERE DersID = @DersID;
            
            -- Bu sınav için ayrılan salonların toplam kapasitesini hesapla
            SELECT @ToplamKapasite = ISNULL(SUM(dl.Kapasite), 0)
            FROM SinavSalon ss
            INNER JOIN Derslikler dl ON ss.DerslikID = dl.DerslikID
            WHERE ss.SinavID = @SinavID;
            
            -- Kapasite kontrolü: Toplam kapasite öğrenci sayısından az olamaz
            IF @ToplamKapasite < @OgrenciSayisi
            BEGIN
                SET @HataMesaji = 'KAPASITE YETERSIZ! Sınav ID: ' + CAST(@SinavID AS NVARCHAR) + 
                                   ', Mevcut Kapasite: ' + CAST(@ToplamKapasite AS NVARCHAR) +
                                   ', Gerekli Kapasite: ' + CAST(@OgrenciSayisi AS NVARCHAR) +
                                   '. En az ' + CAST(@OgrenciSayisi - @ToplamKapasite AS NVARCHAR) + 
                                   ' kişilik daha salon eklemelisiniz.';
                
                -- Hata mesajını fırlat ve işlemi engelle
                RAISERROR(@HataMesaji, 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END
            ELSE
            BEGIN
                PRINT '✓ Kapasite kontrolü başarılı. Sınav ID: ' + CAST(@SinavID AS NVARCHAR) +
                      ', Toplam Kapasite: ' + CAST(@ToplamKapasite AS NVARCHAR) +
                      ', Öğrenci Sayısı: ' + CAST(@OgrenciSayisi AS NVARCHAR);
            END
        END
        
        FETCH NEXT FROM sinav_cursor INTO @SinavID;
    END
    
    CLOSE sinav_cursor;
    DEALLOCATE sinav_cursor;
END;
GO

-- Trigger'ın oluştuğunu kontrol et
SELECT 
    name AS TriggerAdi,
    OBJECT_NAME(parent_id) AS TabloAdi,
    create_date AS OlusturmaTarihi
FROM sys.triggers
WHERE name = 'TR_SinavSalon_KapasiteKontrol';