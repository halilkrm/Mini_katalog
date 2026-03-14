# Mini Katalog Uygulaması

Bir Flutter eğitimi kapsamında geliştirdiğim basit ürün katalog uygulaması.

## Ekranlar

- Ana Sayfa: Ürünlerin GridView ile listelendiği sayfa, arama ve kategori filtresi var
- Detay Sayfası: Ürüne tıklayınca açılan detay ekranı
- Sepet Sayfası: Eklenen ürünlerin görüntülendiği ekran

## Kullanılan Flutter Sürümü

Flutter 3.x (Dart 3.x)

## Çalıştırma Adımları

1. Flutter SDK kurulu olmalı
2. Projeyi klonla ya da indir
3. Terminalde proje klasörüne gir
4. Bağımlılıkları yükle:

```bash
flutter pub get
```

5. Emulator veya cihaz bağlı olmalı:

```bash
flutter devices
```

6. Uygulamayı çalıştır:

```bash
flutter run
```

## Özellikler

- Ürün listeleme (GridView)
- Arama fonksiyonu
- Kategori filtreleme
- Ürün detay sayfası (Navigator ile sayfa geçişi)
- Sepete ekleme / çıkarma (state güncelleme)
- Sepet toplam hesaplama

## Proje Yapısı

```
lib/
  main.dart
  models/
    product.dart       # Ürün veri modeli (fromJson/toJson)
    fake_data.dart     # JSON simülasyon verisi
    cart_provider.dart # Sepet yönetimi
  screens/
    home_screen.dart   # Ana sayfa
    detail_screen.dart # Ürün detay sayfası
    cart_screen.dart   # Sepet sayfası
```

## Notlar

Ürün verileri şu an simüle edilmiş JSON verisinden geliyor.
Gerçek API entegrasyonu için şu adresler kullanılabilir:
- https://fakestoreapi.com/products
- https://dummyjson.com/products
