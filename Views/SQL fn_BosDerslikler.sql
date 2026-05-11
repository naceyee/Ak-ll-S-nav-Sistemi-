USE AkilliSinavDB;
GO

CREATE OR ALTER FUNCTION fn_BosDerslikler (@Tarih date, @OturumID int)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        dl.DerslikID,
        dl.DerslikAd,
        dl.Kat,
        dl.Tip,
        dl.Kapasite
    FROM Derslikler dl
    WHERE dl.Aktif = 1
      AND NOT EXISTS (
          SELECT 1 
          FROM Sinavlar s
          JOIN SinavSalon ss ON s.SinavID = ss.SinavID
          WHERE ss.DerslikID = dl.DerslikID
            AND s.Tarih = @Tarih
            AND s.OturumID = @OturumID
      )
);
GO