USE AkilliSinavDB;
GO

CREATE OR ALTER FUNCTION fn_PersonelGorevSayisi 
(
    @PersonelID int, 
    @Tarih date
)
RETURNS int
AS
BEGIN
    DECLARE @Sayac int;
    
    SELECT @Sayac = COUNT(*)
    FROM GozetmenAtamalari ga
    INNER JOIN Sinavlar s ON ga.SinavID = s.SinavID
    WHERE ga.PersonelID = @PersonelID
      AND CAST(s.Tarih AS DATE) = @Tarih;  -- Güvenli karþýlaþtýrma
    
    RETURN ISNULL(@Sayac, 0);
END;
GO

-- Test
SELECT dbo.fn_PersonelGorevSayisi(34, '2026-06-15') AS GunlukGorevSayisi;