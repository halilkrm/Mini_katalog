# Mini Katalog Uygulaması

Flutter ile geliştirilen basit bir ürün katalog uygulaması. Ürünleri listeleme, detaylarını görüntüleme ve sepete ekleme özellikleri içerir.

## Ekran Görüntüleri

Ekran görüntüleri repo ana dizininde `Screenshot_*.png` dosyaları olarak bulunmaktadır.

## Kullanılan Flutter Sürümü

- Flutter 3.41.3 (Dart 3.11.1)

## Özellikler

- Ürün listeleme (GridView)
- Kategori filtreleme
- Ürün arama
- Ürün detay sayfası (Navigator ile sayfa geçişi)
- Sepete ekleme / çıkarma (state güncelleme)
- Sepet toplam hesaplama

## Veri Kaynağı

Ürün verileri **DummyJSON API**'sından canlı olarak çekilmektedir:
- https://dummyjson.com/products

`fake_data.dart` dosyası yalnızca API'ya erişilemediği durumlarda devreye giren yedek veridir, aktif olarak kullanılmamaktadır.

## Proje Yapısı
```
lib/
  main.dart
  models/
    product.dart        # Ürün veri modeli (fromJson/toJson)
    fake_data.dart      # Yedek veri (API erişilemezse kullanılır)
    cart_provider.dart  # Sepet yönetimi
  screens/
    home_screen.dart    # Ana sayfa
    detail_screen.dart  # Ürün detay sayfası
    cart_screen.dart    # Sepet sayfası
```

## Çalıştırma Adımları

1. Flutter SDK kurulu olmalı
2. Projeyi klonla:
```bash
git clone https://github.com/halilkrm/Mini_katalog.git
cd Mini_katalog
```
3. Bağımlılıkları yükle:
```bash
flutter pub get
```
4. Uygulamayı çalıştır:
```bash
flutter run
```
