USE AkilliSinavDB;
GO


INSERT INTO Bolumler (BolumAd) VALUES 
('Yazýlým Mühendisliði'),
('Elektrik Mühendisliði'),
('Mekatronik Mühendisliði'),
('Enerji Sistemleri Mühendisliði'),
('Makine Mühendisliði');

---------------------------------------------------------------------------------------------------------------------------------------------------

USE AkilliSinavDB;
GO

-- Elektrik Mühendisliði (BolumID=3) - 1. ve 2. Yarýyýl Dersleri
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

---------------------------------------------------------------------------------------------------------------------------------------


-- Makine Mühendisligi (BolumID=2) - 1. YARIYIL
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


----------------------------------------------------------------------------------------------------------------------------

