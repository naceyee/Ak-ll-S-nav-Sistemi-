USE AkilliSinavDB;
GO

CREATE PROCEDURE sp_SinavVeSalonOlustur
    @DersID int,
    @Tarih date,
    @OturumID int
AS
BEGIN
    DECLARE @Kontenjan int;
    DECLARE @Kalan int;
    DECLARE @ToplamKapasite int = 0;
    DECLARE @SinavID int;
    DECLARE @SecilenDerslikID int;
    DECLARE @SecilenKapasite int;
    DECLARE @SecilenKat int;
    DECLARE @SecilenAd varchar(30);
    DECLARE @HedefKat int = NULL;

    -- 1. Dersin öðrenci sayýsýný al
    SELECT @Kontenjan = OgrenciSayisi FROM Dersler WHERE DersID = @DersID;
    SET @Kalan = @Kontenjan;

    IF @Kontenjan IS NULL
    BEGIN
        PRINT 'Hata: Ders bulunamadi!';
        RETURN;
    END;

    -- Geçici tablo
    CREATE TABLE #OnerilenSalonlar (
        Sira int IDENTITY(1,1),
        DerslikID int,
        DerslikAd varchar(30),
        Kapasite int,
        Kat int
    );

    -- 2. En uygun katý bul (en çok boþ salonu olan kat)
    SELECT TOP 1 @HedefKat = d.Kat
    FROM Derslikler d
    WHERE d.Aktif = 1
      AND NOT EXISTS (
          SELECT 1 FROM Sinavlar s
          INNER JOIN SinavSalon ss ON s.SinavID = ss.SinavID
          WHERE ss.DerslikID = d.DerslikID
            AND s.Tarih = @Tarih
            AND s.OturumID = @OturumID
      )
    GROUP BY d.Kat
    ORDER BY COUNT(d.DerslikID) DESC;

    -- 3. En büyük boþ salonlarý bul
    WHILE @Kalan > 0
    BEGIN
        SELECT TOP 1
            @SecilenDerslikID = d.DerslikID,
            @SecilenAd = d.DerslikAd,
            @SecilenKapasite = d.Kapasite,
            @SecilenKat = d.Kat
        FROM Derslikler d
        WHERE d.Aktif = 1
          AND NOT EXISTS (SELECT 1 FROM #OnerilenSalonlar o WHERE o.DerslikID = d.DerslikID)
          AND NOT EXISTS (
              SELECT 1 FROM Sinavlar s
              INNER JOIN SinavSalon ss ON s.SinavID = ss.SinavID
              WHERE ss.DerslikID = d.DerslikID
                AND s.Tarih = @Tarih
                AND s.OturumID = @OturumID
          )
        ORDER BY 
            CASE WHEN d.Kat = @HedefKat THEN 0 ELSE 1 END,
            d.Kapasite DESC;

        IF @SecilenDerslikID IS NULL
        BEGIN
            PRINT 'UYARI: Yeterli kapasitede bos salon bulunamadi!';
            BREAK;
        END;

        INSERT INTO #OnerilenSalonlar (DerslikID, DerslikAd, Kapasite, Kat)
        VALUES (@SecilenDerslikID, @SecilenAd, @SecilenKapasite, @SecilenKat);

        SET @ToplamKapasite = @ToplamKapasite + @SecilenKapasite;
        SET @Kalan = @Kontenjan - @ToplamKapasite;
        SET @SecilenDerslikID = NULL;
    END;

    -- 4. Sinavlar tablosuna kaydet
    INSERT INTO Sinavlar (DersID, OturumID, Tarih)
    VALUES (@DersID, @OturumID, @Tarih);
    SET @SinavID = SCOPE_IDENTITY();

    -- 5. SinavSalon tablosuna kaydet
    INSERT INTO SinavSalon (SinavID, DerslikID)
    SELECT @SinavID, DerslikID FROM #OnerilenSalonlar;

    -- 6. Sonucu göster
    SELECT 
        o.Sira,
        o.DerslikAd,
        o.Kapasite,
        o.Kat,
        @Kontenjan AS ToplamOgrenci,
        @ToplamKapasite AS ToplamKapasite,
        CASE 
            WHEN @ToplamKapasite >= @Kontenjan THEN 'YETERLI'
            ELSE 'YETERSIZ'
        END AS Durum,
        CASE WHEN o.Kat = @HedefKat THEN 'Tercih Edilen Kat' ELSE 'Alternatif Kat' END AS KatDurumu
    FROM #OnerilenSalonlar o
    ORDER BY o.Sira;

    -- Özet
    SELECT 
        @SinavID AS OlusturulanSinavID,
        COUNT(*) AS KullanilanSalonSayisi,
        @HedefKat AS HedefKat,
        COUNT(*) AS GerekenGozetmenSayisi
    FROM #OnerilenSalonlar;

    DROP TABLE #OnerilenSalonlar;
END;
GO