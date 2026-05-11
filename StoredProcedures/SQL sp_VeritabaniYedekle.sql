USE AkilliSinavDB;
GO

CREATE OR ALTER PROCEDURE sp_VeritabaniYedekle
    @YedekKlasor varchar(500) = 'C:\Yedekler\'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @DosyaAdi varchar(500);
    DECLARE @TamYol varchar(600);
    
    BEGIN TRY
        -- Dosya adýný oluþtur
        SET @DosyaAdi = 'AkilliSinavDB_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmmss') + '.bak';
        SET @TamYol = @YedekKlasor + @DosyaAdi;
        
        PRINT 'Yedek aliniyor...';
        PRINT 'Hedef: ' + @TamYol;
        
        -- YEDEK ALMA KOMUTU
        BACKUP DATABASE AkilliSinavDB
        TO DISK = @TamYol
        WITH 
            FORMAT,
            INIT,
            NAME = 'AkilliSinavDB Full Yedegi',
            DESCRIPTION = 'AkilliSinavDB veritabaninin tam yedegi',
            STATS = 10;
        
        PRINT 'Yedek basariyla alindi: ' + @TamYol;
        
        -- Dosya boyutunu göster (eðer varsa)
        PRINT 'Dosya boyutu kontrol ediliyor...';
        
    END TRY
    BEGIN CATCH
        PRINT 'HATA: Yedek alinamadi!';
        PRINT 'Hata Mesaji: ' + ERROR_MESSAGE();
        PRINT 'Klasor yolunun dogru oldugundan emin olun.';
        
        -- Alternatif: Varsayýlan Backup klasörüne dene
        PRINT 'Alternatif klasore yedek aliniyor...';
        SET @TamYol = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\' + @DosyaAdi;
        
        BACKUP DATABASE AkilliSinavDB TO DISK = @TamYol;
        PRINT 'Yedek alindi: ' + @TamYol;
    END CATCH;
END;
GO