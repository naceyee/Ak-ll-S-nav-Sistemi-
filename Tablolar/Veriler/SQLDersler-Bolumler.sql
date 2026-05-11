USE AkilliSinavDB;
GO

DELETE FROM Dersler;
DELETE FROM Bolumler;

-- IDENTITY_INSERT'i AÇ (manuel ID girmek için ZORUNLU)
SET IDENTITY_INSERT Bolumler ON;



INSERT INTO Bolumler (BolumID, BolumAd) VALUES 
(1, 'Yazýlým Mühendisliði'),
(2, 'Makine Mühendisliði'),
(3, 'Elektrik Mühendisliði'),
(4, 'Mekatronik Mühendisliði'),
(5, 'Enerji Sistemleri Mühendisliði');

INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
-- 1. YARIYIL
(1, 'FIZ-1301', 'Fizik I', 72, 1),
(1, 'MAT-1301', 'Matematik I', 85, 1),
(1, 'YDI-1121', 'Yabancý Dil I', 68, 1),
(1, 'TDL-1111', 'Türk Dili I', 74, 1),
(1, 'AIT-1101', 'Atatürk Ýlkeleri ve Ýnkýlap Tarihi I', 81, 1),
(1, 'YZM-1107', 'Temel Bilgisayar Bilimleri', 63, 1),
(1, 'YZM-1111', 'Algoritma ve Programlama I', 88, 1),
(1, 'YZM-1113', 'Yazýlým Mühendisliðinde Kariyer Planlama', 70, 1),

-- 2. YARIYIL
(1, 'FIZ-1302', 'Fizik II', 76, 2),
(1, 'MAT-1302', 'Matematik II', 84, 2),
(1, 'YDI-1122', 'Yabancý Dil II', 65, 2),
(1, 'TDL-1112', 'Türk Dili II', 79, 2),
(1, 'AIT-1102', 'Atatürk Ýlkeleri ve Ýnkýlap Tarihi II', 82, 2),
(1, 'YZM-1108', 'Yazýlým Mühendisliðine Giriþ', 71, 2),
(1, 'YZM-1112', 'Algoritma ve Programlama II', 87, 2),

-- 3. YARIYIL
(1, 'CBU-4403', 'Ýþ Saðlýðý ve Güvenliði I', 62, 3),
(1, 'YZM-2111', 'Ayrýk Yapýlar', 78, 3),
(1, 'YZM-2113', 'Mühendislik Matematiði', 83, 3),
(1, 'YZM-2123', 'Web Programlamaya Giriþ', 69, 3),
(1, 'YZM-2125', 'Nesneye Yönelik Programlama', 90, 3),
(1, 'YZM-2127', 'Yazýlým Gereksinimi Analizi', 75, 3),
(1, 'YZM2126', 'Veritabaný Sistemlerine Giriþ', 80, 3),
(1, 'YZM2128', 'Veri Yapýlarý', 86, 3),
(1, 'YZM2130', 'Yazýlým Mimarisi ve Tasarýmý', 73, 3),

-- 4. YARIYIL
(1, 'CBU-4404', 'Ýþ Saðlýðý ve Güvenliði II', 66, 4),
(1, 'YZM-2114', 'Olasýlýk ve Ýstatistik', 89, 4),
(1, 'YZM-2122', 'Yazýlým Yapýmý', 77, 4),

-- 5. YARIYIL
(1, 'YZM3107', 'Veritabaný Yönetim Sistemleri', 74, 5),
(1, 'YZM3109', 'Bilgisayar Aðlarý', 81, 5),
(1, 'YZM3111', 'Yazýlým Sýnama', 68, 5),

-- 6. YARIYIL
(1, 'YZM3116', 'Ýþletim Sistemleri', 85, 6),
(1, 'YZM3118', 'Algoritma Analizi ve Tasarýmý', 79, 6),
(1, 'YZM3120', 'Yazýlým Projesi Yönetimi', 72, 6),
(1, 'YZM3122', 'Profesyonel Yazýlým Geliþtirme I', 88, 6),

-- 7. YARIYIL
(1, 'YZM4105', 'Sosyal Sorumluluk', 64, 7),
(1, 'YZM4119', 'Profesyonel Yazýlým Geliþtirme II', 76, 7);


INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'FIZ 1301', 'Fizik I', 90, 1),
(2, 'MAT 1301', 'Matematik I', 90, 1),
(2, 'YDI 1121', 'Yabanci Dil I', 90, 1),
(2, 'TDL 1111', 'Turk Dili I', 90, 1),
(2, 'AIT 1101', 'Ataturk Ilkeleri ve Inkilap Tarihi I', 90, 1),
(2, 'KIM 1301', 'Kimya', 90, 1),
(2, 'MAK 1101', 'Teknik Resim', 90, 1),
(2, 'MAK 1103', 'Makine Muhendisligine Giris', 90, 1);


-- Makine Mühendisligi (BolumID=2) - 2. YARIYIL (Tabloya göre)
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'SSD 1218', 'Teknik Olmayan Secmeli Dersler', 90, 2),
(2, 'FIZ 1302', 'Fizik II', 90, 2),
(2, 'MAT 1302', 'Matematik II', 90, 2),
(2, 'YDI 1122', 'Yabanci Dil II', 90, 2),
(2, 'TDL 1112', 'Turk Dili II', 90, 2),
(2, 'MAK 1102', 'Bilgisayar Destekli Teknik Resim', 90, 2),
(2, 'MAK 1304', 'Bilgisayar Bilimi ve Programlama', 90, 2),
(2, 'MAK 1104', 'Statik', 90, 2);


-- Makine Mühendisligi (BolumID=2) - 3. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'MAK 2101', 'Muhendislik Matematigi I', 85, 3),
(2, 'MAK 2107', 'Akiskanlar Mekanigi', 85, 3),
(2, 'MAK 2117', 'Termodinamik I', 85, 3),
(2, 'MAK 2113', 'Dinamik', 85, 3),
(2, 'MAK 2119', 'Mukavemet I', 85, 3),
(2, 'MAK 2115', 'Malzeme Bilimi', 85, 3),
(2, 'MAK 2121', 'Muhendislikte Deneysel Metotlar I', 85, 3);



-- Makine Mühendisligi (BolumID=2) - 4. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'AIT 1102', 'Ataturk Ilkeleri ve Inkilap Tarihi II', 80, 4),
(2, 'CBU 4403', 'Is Sagligi ve Guvenligi I', 80, 4),
(2, 'MAK 2102', 'Muhendislik Matematigi II', 80, 4),
(2, 'MAK 2106', 'Muhendislik Malzemeleri', 80, 4),
(2, 'MAK 2120', 'Termodinamik II', 80, 4);

-- Makine Mühendisligi (BolumID=2) - 4. YARIYIL (Devam)
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'MAK 2114', 'Muhendislikte Deneysel Metotlar II', 80, 4),
(2, 'MAK 2116', 'Mukavemet II', 80, 4),
(2, 'MAK 2118', 'Istatistik', 80, 4);



-- Makine Mühendisligi (BolumID=2) - 5. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'MAK 3201', 'Teknik Secmeli Dersler', 75, 5),
(2, 'CBU 4404', 'Is Sagligi ve Guvenligi II', 75, 5),
(2, 'MAK 3101', 'Makine Elemanlari I', 75, 5),
(2, 'MAK 3107', 'Sistem Analizi ve Kontrol', 75, 5),
(2, 'MAK 3109', 'Bilgisayar Destekli Muhendislik', 75, 5),
(2, 'MAK 3111', 'Mekanizma Teknigi', 75, 5),
(2, 'MAK 3113', 'Uretim Yontemleri I', 75, 5),
(2, 'MAK 3115', 'Kariyer Planlama', 75, 5);


-- Makine Mühendisligi (BolumID=2) - 6. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'MAK 3102', 'Makine Elemanlari II', 70, 6),
(2, 'MAK 3108', 'Elektronik ve Otomasyon Bilgisi', 70, 6),
(2, 'MAK 3116', 'Makine Dinamigi', 70, 6),
(2, 'MAK 3118', 'Muhendislik Ekonomisi ve Yonetimi', 70, 6),
(2, 'MAK 3114', 'Makine Muhendisligi Tasarimi', 70, 6),
(2, 'MAK 3122', 'Uretim Yontemleri II', 70, 6),
(2, 'MAK 3124', 'Isi Transferi', 70, 6);

-- Makine Mühendisligi (BolumID=2) - 7. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(2, 'MAK 4201', 'Teknik Secmeli Dersler', 65, 7),
(2, 'MAK 4105', 'Sosyal Sorumluluk', 65, 7),
(2, 'MAK 4113', 'Staj (I-II)', 65, 7),
(2, 'MAK 4115', 'Makine Muhendisligi Projesi', 65, 7);

INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
-- 1. YARIYIL
(3, 'AIT 1101', 'Ataturk Ilkeleri ve Inkilap Tarihi I', 85, 1),
(3, 'ELK 1101', 'Lineer Cebir', 85, 1),
(3, 'ELK 1103', 'Kariyer Planlama', 85, 1),
(3, 'ELK 1105', 'Elektrik Muhendisligine Giris', 85, 1),
(3, 'ELK 1107', 'Bilgisayar Destekli Cizim', 85, 1),
(3, 'FIZ 1301', 'Fizik I', 85, 1),
(3, 'MAT 1301', 'Matematik I', 85, 1),
(3, 'TDL 1111', 'Turk Dili I', 85, 1),
(3, 'YDI 1131', 'Yabanci Dil I', 85, 1);




-- 2. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(3, 'AIT 1102', 'Ataturk Ilkeleri ve Inkilap Tarihi II', 80, 2),
(3, 'ELK 1102', 'Elektrik Devreleri I', 80, 2),
(3, 'ELK 1104', 'Bilgisayar Programlama', 80, 2),
(3, 'ELK 1106', 'Elektrik Olcme Teknikleri', 80, 2),
(3, 'FIZ 1302', 'Fizik II', 80, 2),
(3, 'MAT 1302', 'Matematik II', 80, 2),
(3, 'TDL 1112', 'Turk Dili II', 80, 2);


-- 3. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(3, 'CBU 4403', 'Is Sagligi ve Guvenligi I', 75, 3),
(3, 'ELK 2101', 'Elektrik Devreleri II', 75, 3),
(3, 'ELK 2103', 'Elektromanyetik Alan Teorisi', 75, 3),
(3, 'ELK 2105', 'Diferansiyel Denklemler', 75, 3),
(3, 'ELK 2107', 'Elektronik I', 75, 3);

-- 4. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(3, 'CBU 4404', 'Is Sagligi ve Guvenligi II', 70, 4),
(3, 'ELK 2102', 'Sayisal Elektronik', 70, 4),
(3, 'ELK 2104', 'Aydinlatma Teknigi ve Tesis Projeleri', 70, 4),
(3, 'ELK 2110', 'Elektrik ve Elektromekanik Enerji Donusumu', 70, 4),
(3, 'ELK 2112', 'Ayrýk Matematik', 70, 4);


-- 5. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(3, 'ELK 3101', 'Guc Elektronigi', 65, 5),
(3, 'ELK 3103', 'Elektrik Makineleri I', 65, 5),
(3, 'ELK 3105', 'Yuksek Gerilim Teknigi', 65, 5),
(3, 'ELK 3107', 'Enerji Iletim Sistemleri', 65, 5),
(3, 'ELK 3109', 'Sinyaller ve Sistemler', 65, 5),
(3, 'ELK 3119', 'Numerik Analiz', 65, 5);


INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(3, 'ELK 3102', 'Otomatik Kontrol', 60, 6),
(3, 'ELK 3104', 'Elektrik Makineleri II', 60, 6),
(3, 'ELK 3106', 'Enerji Dagitimi', 60, 6),
(3, 'ELK 3108', 'Kumanda Teknikleri', 60, 6),
(3, 'ELK 3116', 'Olasilik ve Istatistik', 60, 6);

-- 7. YARIYIL
INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
(3, 'ELK 4101', 'Elektrik Muhendisligi Projesi I', 55, 7),
(3, 'ELK 4103', 'Mesleki Ingilizce', 55, 7),
(3, 'ELK 4105', 'Sosyal Sorumluluk', 55, 7);
 
 INSERT INTO Dersler (BolumID, DersKodu, DersAd, OgrenciSayisi, Yariyil) VALUES
-- 1. YARIYIL (Zorunlu)
(4, 'AÝT 1103', 'Atatürk Ýlkeleri ve Ýnkýlap Tarihi', 78, 1),
(4, 'FIZ 1301', 'Fizik I', 85, 1),
(4, 'MAT 1301', 'Matematik I', 72, 1),
(4, 'MKR 1101', 'Mekatronik Mühendisliðine Giriþ', 68, 1),
(4, 'MKR 1103', 'Bilgisayar Bilimi ve Programlamaya Giriþ', 74, 1),
(4, 'MKR 1105', 'Kariyer Planlama', 81, 1),
(4, 'TDL 1121', 'Türk Dili', 63, 1),
(4, 'YDI 1131', 'Yabancý Dil', 88, 1),

-- 2. YARIYIL (Zorunlu - Alan Dýþý Seçmeli hariç)
(4, 'FIZ 1302', 'Fizik II', 76, 2),
(4, 'MAT 1302', 'Matematik II', 82, 2),
(4, 'MKR 1102', 'Statik', 69, 2),
(4, 'MKR 1104', 'Bilgisayar Programlama', 87, 2),
(4, 'MKR 1106', 'Elektrik Devreleri', 71, 2),
(4, 'MKR 1108', 'Bilgisayar Destekli Teknik Resim', 79, 2),

-- 3. YARIYIL (Zorunlu - Alan Dýþý Seçmeli hariç)
(4, 'CBU 4403', 'Ýþ Saðlýðý ve Güvenliði I', 64, 3),
(4, 'MKR 2109', 'Diferansiyel Denklemler', 90, 3),
(4, 'MKR 2111', 'Dinamik', 73, 3),
(4, 'MKR 2113', 'Mantýk Devreleri', 84, 3),
(4, 'MKR 2115', 'Mühendisler için Kimya', 66, 3),
(4, 'MKR 2117', 'Mukavemet', 80, 3),

-- 4. YARIYIL (Zorunlu - Teknik Seçmeli hariç)
(4, 'CBU 4404', 'Ýþ Saðlýðý ve Güvenliði II', 77, 4),
(4, 'MKR 2110', 'Algýlayýcýlar ve Aktüatörler', 86, 4),
(4, 'MKR 2112', 'Elektrik Makineleri', 70, 4),
(4, 'MKR 2114', 'Elektronik Devreler ve Analizi', 83, 4),
(4, 'MKR 2118', 'Malzeme Kimyasý ve Bilimi', 75, 4),
(4, 'MKR 2120', 'Lineer Cebir', 89, 4),

-- 5. YARIYIL (Zorunlu - Teknik Seçmeli hariç)
(4, 'MKR 3109', 'Otomatik Kontrol', 68, 5),
(4, 'MKR 3111', 'Güç Elektroniði ve Sürücü Sistemleri', 81, 5),
(4, 'MKR 3113', 'Bilgisayar Destekli Tasarým', 74, 5),
(4, 'MKR 3115', 'Mikrokontrolörler', 88, 5),
(4, 'MKR 3117', 'Sayýsal Yöntemler ve Optimizasyon', 72, 5),
(4, 'MKR 3119', 'Makine Teorisi', 79, 5),

-- 6. YARIYIL (Zorunlu - Teknik Seçmeli hariç)
(4, 'MKR 3100', 'Mekatronik Mühendisliði Tasarým Projesi-I', 85, 6),
(4, 'MKR 3106', 'Endüstriyel Otomasyon Sistemleri', 76, 6),
(4, 'MKR 3108', 'Robot Kinematiði', 82, 6),
(4, 'MKR 3110', 'Makine Elemanlarý', 69, 6),
(4, 'MKR 3112', 'Mesleki Ýngilizce', 90, 6),
(4, 'MKR 3114', 'Ýstatistik ve Deneysel Yöntemler', 73, 6),

-- 7. YARIYIL (Zorunlu - Teknik Seçmeli hariç)
(4, 'MKR 4101', 'Mekatronik Mühendisliði Tasarým Projesi-II', 80, 7),
(4, 'MKR 4103', 'Sosyal Sorumluluk', 65, 7);


