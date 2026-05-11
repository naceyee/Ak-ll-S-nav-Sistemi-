USE AkilliSinavDB;
GO

CREATE OR ALTER FUNCTION fn_ToplamKapasite (@SinavID int)
RETURNS int
AS
BEGIN
    DECLARE @Toplam int;
    
    SELECT @Toplam = SUM(dl.Kapasite)
    FROM SinavSalon ss
    JOIN Derslikler dl ON ss.DerslikID = dl.DerslikID
    WHERE ss.SinavID = @SinavID;
    
    RETURN ISNULL(@Toplam, 0);
END;
GO