USE AkilliSinavDB;
GO

CREATE OR ALTER PROCEDURE sp_GozetmenAta
    @SinavID int
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DECLARE @DersID int;
        DECLARE @BolumID int;
        DECLARE @Tarih date;
        DECLARE @OturumID int;
        DECLARE @GunSirasi int;
        DECLARE @ToplamSalonSayisi int;
        
        -- Sýnav bilgilerini al
        SELECT @DersID = DersID, @Tarih = Tarih, @OturumID = OturumID
        FROM Sinavlar WHERE SinavID = @SinavID;
        
        IF @DersID IS NULL
        BEGIN
            PRINT 'HATA: Geçersiz SinavID!';
            ROLLBACK;
            RETURN;
        END;
        
        SELECT @BolumID = BolumID FROM Dersler WHERE DersID = @DersID;
        
        -- Oturumun gün sýrasýný al (arka arkaya 3 oturum kontrolü için)
        SELECT @GunSirasi = GunSirasi FROM Oturumlar WHERE OturumID = @OturumID;
        
        -- Toplam salon sayýsýný bul
        SELECT @ToplamSalonSayisi = COUNT(*) FROM SinavSalon WHERE SinavID = @SinavID;
        
        IF @ToplamSalonSayisi = 0
        BEGIN
            PRINT 'HATA: Bu sýnava salon atanmamýþ!';
            ROLLBACK;
            RETURN;
        END;
        
        -- Geçici tablolar
        CREATE TABLE #AtananGozetmenler (
            AtamaID int IDENTITY(1,1),
            DerslikID int,
            DerslikAd varchar(30),
            PersonelID int NULL,
            PersonelAdSoyad varchar(100),
            BolumAd varchar(50)
        );
        
        CREATE TABLE #UygunPersoneller (
            PersonelID int,
            AdSoyad varchar(100),
            BolumID int,
            BolumAd varchar(50),
            MevcutGorevSayisi int,
            Siralama int
        );
        
        -- 1. ADIM: Uygun personelleri bul (GunSirasi bazlý)
        INSERT INTO #UygunPersoneller (PersonelID, AdSoyad, BolumID, BolumAd, MevcutGorevSayisi)
        SELECT 
            p.PersonelID,
            p.Ad + ' ' + p.Soyad AS AdSoyad,
            p.BolumID,
            b.BolumAd,
            (SELECT COUNT(*) FROM GozetmenAtamalari WHERE PersonelID = p.PersonelID) AS MevcutGorevSayisi
        FROM Personel p
        JOIN Bolumler b ON p.BolumID = b.BolumID
        WHERE p.PersonelID NOT IN (
            SELECT PersonelID FROM GozetmenAtamalari WHERE SinavID = @SinavID
        )
        AND p.PersonelID NOT IN (
            SELECT ga.PersonelID FROM GozetmenAtamalari ga
            INNER JOIN Sinavlar s ON ga.SinavID = s.SinavID
            WHERE s.Tarih = @Tarih AND s.OturumID = @OturumID
        )
        AND p.PersonelID NOT IN (
            -- ? ARKA ARKAYA 3 OTURUM KONTROLÜ (GunSirasi bazlý) ?
            SELECT ga.PersonelID 
            FROM GozetmenAtamalari ga
            JOIN Sinavlar s ON ga.SinavID = s.SinavID
            JOIN Oturumlar o ON s.OturumID = o.OturumID
            WHERE s.Tarih = @Tarih
              AND o.GunSirasi BETWEEN @GunSirasi - 2 AND @GunSirasi
              AND o.GunSirasi >= 1
            GROUP BY ga.PersonelID
            HAVING COUNT(*) >= 3
        )
        AND p.PersonelID NOT IN (
            SELECT PersonelID FROM PersonelDurum
            WHERE Tarih = @Tarih 
              AND (OturumID = @OturumID OR OturumID IS NULL)
              AND Uygun = 0
        );
        
        -- Sýralama: Önce kendi bölümü, sonra havuz, en az görevi olan önce
        UPDATE #UygunPersoneller
        SET Siralama = ROW_NUMBER() OVER (
            ORDER BY 
                CASE WHEN BolumID = @BolumID THEN 0 ELSE 1 END,
                MevcutGorevSayisi ASC,
                PersonelID ASC
        );
        
        -- 2. ADIM: Her salon için gözetmen ata
        DECLARE @DerslikID int;
        DECLARE @DerslikAd varchar(30);
        DECLARE @PersonelID int;
        DECLARE @PersonelAdSoyad varchar(100);
        DECLARE @BolumAd varchar(50);
        
        DECLARE salon_cursor CURSOR FOR
            SELECT ss.DerslikID, d.DerslikAd
            FROM SinavSalon ss
            JOIN Derslikler d ON ss.DerslikID = d.DerslikID
            WHERE ss.SinavID = @SinavID;
        
        OPEN salon_cursor;
        FETCH NEXT FROM salon_cursor INTO @DerslikID, @DerslikAd;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT TOP 1 
                @PersonelID = PersonelID,
                @PersonelAdSoyad = AdSoyad,
                @BolumAd = BolumAd
            FROM #UygunPersoneller
            WHERE PersonelID NOT IN (SELECT PersonelID FROM #AtananGozetmenler WHERE PersonelID IS NOT NULL)
            ORDER BY Siralama;
            
            IF @PersonelID IS NOT NULL
            BEGIN
                INSERT INTO GozetmenAtamalari (SinavID, DerslikID, PersonelID)
                VALUES (@SinavID, @DerslikID, @PersonelID);
                
                INSERT INTO #AtananGozetmenler (DerslikID, DerslikAd, PersonelID, PersonelAdSoyad, BolumAd)
                VALUES (@DerslikID, @DerslikAd, @PersonelID, @PersonelAdSoyad, @BolumAd);
            END
            ELSE
            BEGIN
                INSERT INTO #AtananGozetmenler (DerslikID, DerslikAd, PersonelID, PersonelAdSoyad, BolumAd)
                VALUES (@DerslikID, @DerslikAd, NULL, 'GOZETMEN BULUNAMADI', '-');
                
                PRINT 'UYARI: ' + @DerslikAd + ' salonuna gozetmen atanamadi!';
            END
            
            FETCH NEXT FROM salon_cursor INTO @DerslikID, @DerslikAd;
        END
        
        CLOSE salon_cursor;
        DEALLOCATE salon_cursor;
        
        -- 3. ADIM: Sonuçlarý göster
        SELECT 
            ag.DerslikID,
            ag.DerslikAd,
            ag.PersonelID,
            ag.PersonelAdSoyad,
            ag.BolumAd,
            ISNULL((SELECT COUNT(*) FROM GozetmenAtamalari WHERE PersonelID = ag.PersonelID), 0) AS ToplamGorevSayisi
        FROM #AtananGozetmenler ag
        ORDER BY ag.AtamaID;
        
        SELECT 
            @ToplamSalonSayisi AS ToplamSalonSayisi,
            SUM(CASE WHEN PersonelID IS NOT NULL THEN 1 ELSE 0 END) AS BasariliAtananGozetmenSayisi,
            SUM(CASE WHEN PersonelID IS NULL THEN 1 ELSE 0 END) AS AtanamayanGozetmenSayisi
        FROM #AtananGozetmenler;
        
        COMMIT TRANSACTION;
        PRINT 'Ýþlem baþarýyla tamamlandý!';
        
        DROP TABLE #AtananGozetmenler;
        DROP TABLE #UygunPersoneller;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'HATA: ' + ERROR_MESSAGE();
        
        IF OBJECT_ID('tempdb..#AtananGozetmenler') IS NOT NULL
            DROP TABLE #AtananGozetmenler;
        IF OBJECT_ID('tempdb..#UygunPersoneller') IS NOT NULL
            DROP TABLE #UygunPersoneller;
    END CATCH;
END;
GO