USE AkilliSinavDB;
GO

CREATE OR ALTER FUNCTION fn_DolulukOrani 
(
    @Tarih date, 
    @OturumID int
)
RETURNS decimal(5,2)
AS
BEGIN
    DECLARE @KullanilanKapasite int;
    DECLARE @OandaBoþKapasite int;
    DECLARE @Oran decimal(5,2) = 0;
    
    -- O gün o oturumda kullanýlan kapasite
    SELECT @KullanilanKapasite = ISNULL(SUM(dl.Kapasite), 0)
    FROM Sinavlar s
    JOIN SinavSalon ss ON s.SinavID = ss.SinavID
    JOIN Derslikler dl ON ss.DerslikID = dl.DerslikID
    WHERE s.Tarih = @Tarih AND s.OturumID = @OturumID;
    
    -- O oturumda BOÞ olan salonlarýn kapasitesi
    SELECT @OandaBoþKapasite = ISNULL(SUM(Kapasite), 1)
    FROM Derslikler d
    WHERE d.Aktif = 1
      AND NOT EXISTS (
          SELECT 1 
          FROM Sinavlar s
          JOIN SinavSalon ss ON s.SinavID = ss.SinavID
          WHERE ss.DerslikID = d.DerslikID
            AND s.Tarih = @Tarih 
            AND s.OturumID = @OturumID
      );
    
    -- Oran hesapla (kullanýlan / toplam müsait salon kapasitesi)
    IF @OandaBoþKapasite + @KullanilanKapasite > 0
        SET @Oran = CAST(@KullanilanKapasite AS decimal(5,2)) / 
                    CAST(@OandaBoþKapasite + @KullanilanKapasite AS decimal(5,2)) * 100;
    
    RETURN @Oran;
END;
GO