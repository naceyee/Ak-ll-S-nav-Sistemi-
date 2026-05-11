# 🎓 AkilliSinavDB - Sınav Takvimi Yönetim Sistemi

## 👥 Proje Ekibi
| Ad Soyad | Görev |
|----------|-------|
| **SELİN KINCAL** | Veritabanı tasarımı, Tablolar, Indexler, Trigger'lar,Stored Procedure'ler, UDF'ler, Views, GitHub yönetimi |
| **NACİYE KAYA** | Veritabanı tasarımı, Tablolar, Indexler, Trigger'lar,Stored Procedure'ler, UDF'ler, Views |
| **GÜLSU BEŞE** | Arayüz Tasarımı ,Test, Dokümantasyon, Raporlama, Veri girişi |

> **Not:** Bu proje, YZM 2126 Veritabanı Sistemlerine Giriş dersi kapsamında hazırlanmıştır.

---

## 📌 Proje Hakkında
Bu proje, bir fakültenin sınav takvimini oluştururken derslik/öğrenci kontenjan durumlarını planlayan ve gözetmen çakışmalarını engelleyen bir veritabanı sistemidir.

## 🛠️ Teknolojiler
- Microsoft SQL Server
- T-SQL (Stored Procedures, Triggers, UDFs, Views)

---

## 📁 Dosya Yapısı

| Klasör | İçerik |
|--------|--------|
| `ER Diyagramları/` | Proje ER diyagramı (PDF, PNG, SQL) |
| `Tablolar/` | Tablo oluşturma ve veri ekleme |
| `Indexler/` | Performans indexleri |
| `StoredProcedures/` | SP1, SP2, SP3 |
| `UDF/` | 3 User Defined Function |
| `Views/` | 3 View |
| `Triggers/` | 3 Trigger |

---

## 📖 Teknik Detaylar

### 1️⃣ Stored Procedure (SP) Nedir?
> **Önceden yazılmış, saklanmış ve gerektiğinde çağrılan SQL kodudur.**

| SP Adı | Görevi |
|--------|--------|
| `sp_SinavVeSalonOlustur` | Dersin öğrenci sayısına göre en uygun salonları bulur, sınav oluşturur ve salonları atar. |
| `sp_GozetmenAta` | Havuz sistemiyle gözetmen atar. Önce kendi bölümünden, yoksa diğer bölümlerden atar. |
| `sp_VeritabaniYedekle` | Veritabanının .bak yedeğini alır. |

---

### 2️⃣ User Defined Function (UDF) Nedir?
> **Tek bir değer veya tablo döndüren, SELECT içinde kullanılabilen yapıdır.**

| UDF Adı | Görevi |
|---------|--------|
| `fn_PersonelGorevSayisi` | Bir personelin belirli tarihe kadar toplam görev sayısını döndürür. |
| `fn_ToplamKapasite` | Bir sınavda kullanılan salonların toplam kapasitesini hesaplar. |
| `fn_DolulukOrani` | Belirli bir oturumdaki salon doluluk oranını (%) hesaplar. |

---

### 3️⃣ View (Görünüm) Nedir?
> **Sanal tablo. Karmaşık sorguları basitleştirir ve raporlamada kullanılır.**

| View Adı | Görevi |
|----------|--------|
| `v_SinavProgrami` | Tüm sınavları ders, tarih, saat, salon ve gözetmen bilgileriyle listeler. |
| `v_GozetmenGorevDagilimi` | Her personelin toplam görev sayısını gösterir (adil dağıtım kontrolü). |
| `fn_BosDerslikler` | Belirli bir tarih ve oturumdaki boş salonları listeler. |

---

### 4️⃣ Trigger (Tetikleyici) Nedir?
> **Bir tabloda INSERT, UPDATE veya DELETE yapıldığında OTOMATİK çalışan yapıdır.**

| Trigger Adı | Ne Zaman Çalışır? | Görevi |
|-------------|-------------------|--------|
| `TR_Sinavlar_UpdateLog` | Sinavlar tablosunda UPDATE yapılınca | Eski ve yeni değerleri Log tablosuna yazar. |
| `TR_Sinavlar_DeleteLog` | Sinavlar tablosunda DELETE yapılınca | Silinen kayıtları Log tablosuna yazar. |
| `TR_SinavSalon_KapasiteKontrol` | SinavSalon tablosuna INSERT/UPDATE yapılınca | Toplam kapasite yetersizse işlemi ENGELLER. |

---

### 5️⃣ Index Nedir?
> **Kitabın sonundaki alfabetik sözlük gibidir. Sorguları hızlandırır.**

| Tablo | Index Adı | Hızlandırdığı Sorgu |
|-------|-----------|---------------------|
| Dersler | IX_Dersler_BolumID | Bölüm bazlı sorgular |
| Sinavlar | IX_Sinavlar_Tarih | Tarih aralığı sorguları |
| Personel | IX_Personel_Ad_Soyad | İsimle arama |
| GozetmenAtamalari | IX_GozetmenAtamalari_PersonelID | Gözetmen bazlı sorgular |

> **Toplam 11 adet index oluşturulmuştur.**

---

## 🚀 Kurulum Sırası

1. `Tablolar/SQLTablolar.sql` çalıştır
2. `Tablolar/Veriler/` klasöründeki tüm dosyaları çalıştır
3. `Indexler/SQLIndexing.sql` çalıştır
4. `StoredProcedures/` dosyalarını çalıştır
5. `UDF/` dosyalarını çalıştır
6. `Views/` dosyalarını çalıştır
7. `Triggers/` dosyalarını çalıştır

---


## 🧪 Kullanım Örneği

```sql
-- 1. Yeni sınav oluştur (DersID: 25 = Veritabanı Sistemlerine Giriş)
EXEC sp_SinavVeSalonOlustur @DersID = 25, @Tarih = '2026-06-01', @OturumID = 1;

-- 2. Oluşan sınava gözetmen ata
EXEC sp_GozetmenAta @SinavID = 1;

-- 3. Veritabanı yedeğini al
EXEC sp_VeritabaniYedekle;

-- 4. Sınav programını görüntüle
SELECT * FROM v_SinavProgrami;

-- 5. Boş salonları bul
SELECT * FROM fn_BosDerslikler('2026-06-01', 1);



## 📊 Proje İstatistikleri

| Kategori | Sayı |
|----------|------|
| Tablo | 10 |
| Index | 11 |
| Stored Procedure | 3 |
| User Defined Function | 3 |
| View | 3 |
| Trigger | 3 |

---

## 🧪 Kullanım Örneği

```sql
-- Yeni sınav oluştur
EXEC sp_SinavVeSalonOlustur @DersID = 25, @Tarih = '2026-06-01', @OturumID = 1;

-- Gözetmen ata
EXEC sp_GozetmenAta @SinavID = 1;

-- Yedek al
EXEC sp_VeritabaniYedekle;
