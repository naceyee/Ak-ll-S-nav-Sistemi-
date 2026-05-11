USE AkilliSinavDB;
GO 

SET IDENTITY_INSERT Personel ON;
GO


--Elektirik Mühendisliði 
INSERT INTO Personel (PersonelID, BolumID, Unvan, Ad, Soyad)
VALUES 
    (1, 3, 'Prof. Dr.', 'Kývanç', 'BAÞARAN'),
    (2, 3, 'Doç. Dr.', 'Ýsmail', 'YABANOVA'),
    (3, 3, 'Doç. Dr.', 'Göksu', 'GÖREL'),
    (4, 3, 'Dr. Öðr. Üyesi', 'Bayram Melih', 'YILMAZ'),
    (5, 3, 'Dr. Öðr. Üyesi', 'Yýlmaz Seryar', 'ARIKUÞU');

--Mekatronik Mühendisliði
INSERT INTO Personel (PersonelID, BolumID, Unvan, Ad, Soyad)
VALUES 
    (6, 4, 'Prof. Dr.', 'Ýbrahim Fadýl', 'SOYKÖK'),
    (7, 4, 'Prof. Dr.', 'Mehmet', 'AYVACIKLI'),
    (8, 4, 'Doç. Dr.', 'Ali', 'UYSAL'),
    (9, 4, 'Dr. Öðr. Üyesi', 'Nilay', 'KÜÇÜKDOÐAN ÖZTÜRK'),
    (10, 4, 'Dr. Öðr. Üyesi', 'Ethem', 'KELEKÇÝ'),
    (11, 4, 'Dr. Öðr. Üyesi', 'Alkýn Yýlmaz', 'AKTER'),
    (12, 4, 'Arþ. Gör. Dr.', 'Seda', 'VATAN CAN'),
    (13, 4, 'Arþ. Gör.', 'Kübra', 'TURAL');

--Makine Mühendisliði
INSERT INTO Personel (PersonelID, BolumID, Unvan, Ad, Soyad)
VALUES 
    (14, 2, 'Prof. Dr.', 'Ahmet Murat', 'PÝNAR'),
    (15, 2, 'Prof. Dr.', 'Mustafa', 'AYDIN'),
    (16, 2, 'Doç. Dr.', 'Fikret', 'SÖNMEZ'),
    (17, 2, 'Doç. Dr.', 'Serkan', 'ÇAÞKA'),
    (18, 2, 'Doç. Dr.', 'Hamza', 'TAÞ'),
    (19, 2, 'Dr. Öðr. Üyesi', 'Selda', 'KAYRAL'),
    (20, 2, 'Dr. Öðr. Üyesi', 'Ayþegül', 'GÜNGÖR ÇELÝK'),
    (21, 2, 'Dr. Öðr. Üyesi', 'Deniz', 'ÇOBAN ÖZKAN'),
    (22, 2, 'Dr. Öðr. Üyesi', 'Mehmet Mert', 'ÝLMAN'),
    (23, 2, 'Arþ. Gör.', 'Ömer', 'ÝLHAN'),
    (24, 2, 'Arþ. Gör.', 'Büþranur', 'KESER');

--Yazýlým Mühendisliði
INSERT INTO Personel (PersonelID, BolumID, Unvan, Ad, Soyad)
VALUES 
    (25, 1, 'Doç. Dr.', 'Fatih', 'YÜCALAR'),
    (26, 1, 'Doç. Dr.', 'Yusuf', 'ÖZÇEVÝK'),
    (27, 1, 'Prof. Dr.', 'Akýn', 'ÖZÇÝFT'),
    (28, 1, 'Prof. Dr.', 'Ersin', 'ASLAN'),
    (29, 1, 'Doç. Dr.', 'Osman', 'ALTAY'),
    (30, 1, 'Doç. Dr.', 'Elif Varol', 'ALTAY'),
    (31, 1, 'Doç. Dr.', 'Müge', 'ÖZÇEVÝK'),
    (32, 1, 'Doç. Dr.', 'Emin', 'BORANDAÐ'),
    (33, 1, 'Dr. Öðr. Üyesi', 'Ýrfan', 'AYGÜN'),
    (34, 1, 'Arþ. Gör.', 'Süleyman', 'ÇETÝNER'),
    (35, 1, 'Arþ. Gör.', 'Elif Nur', 'AYGÜN'),
    (36, 1, 'Arþ. Gör.', 'Tuðba', 'ÇELÝKTEN'),
    (37, 1, 'Arþ. Gör.', 'Güney', 'KAYA');

SET IDENTITY_INSERT Personel OFF;
GO