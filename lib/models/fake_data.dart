import '../models/product.dart';

// Normalde bu verileri API'dan çekerdik ama şimdilik simüle ediyoruz
// Gerçek API: https://dummyjson.com/products

List<Map<String, dynamic>> fakeProductsJson = [
  {
    "id": 1,
    "title": "iPhone 15 Pro",
    "description":
        "Apple'ın en yeni flagship telefonu. A17 Pro çipi ile inanılmaz performans sunar. Titanium tasarım, gelişmiş kamera sistemi.",
    "price": 1299.99,
    "image": "https://picsum.photos/seed/iphone/400/400",
    "category": "telefon"
  },
  {
    "id": 2,
    "title": "Samsung Galaxy S24",
    "description":
        "Samsung'un amiral gemisi. Snapdragon 8 Gen 3 işlemcisi, 200MP kamera ve yapay zeka özellikleri ile donatılmış.",
    "price": 999.99,
    "image": "https://picsum.photos/seed/samsung/400/400",
    "category": "telefon"
  },
  {
    "id": 3,
    "title": "MacBook Air M2",
    "description":
        "Apple M2 çipli MacBook Air. Fanless tasarım, 18 saat pil ömrü ve muhteşem Liquid Retina ekranıyla güçlü bir laptop.",
    "price": 1099.99,
    "image": "https://picsum.photos/seed/macbook/400/400",
    "category": "bilgisayar"
  },
  {
    "id": 4,
    "title": "AirPods Pro 2",
    "description":
        "Aktif gürültü engelleme, Uyarlamalı Şeffaflık modu ve kişiselleştirilmiş Uzamsal Ses özellikleri ile Apple'ın en iyi kulaklığı.",
    "price": 249.99,
    "image": "https://picsum.photos/seed/airpods/400/400",
    "category": "aksesuar"
  },
  {
    "id": 5,
    "title": "iPad Air",
    "description":
        "M1 çipli iPad Air. Hem üretkenlik hem de eğlence için mükemmel. Apple Pencil ve Magic Keyboard ile daha da güçlü.",
    "price": 749.99,
    "image": "https://picsum.photos/seed/ipad/400/400",
    "category": "tablet"
  },
  {
    "id": 6,
    "title": "Sony WH-1000XM5",
    "description":
        "Sony'nin en iyi gürültü önleyici kulaklığı. 30 saatlik pil ömrü, hızlı şarj ve kristal net ses kalitesi.",
    "price": 349.99,
    "image": "https://picsum.photos/seed/sony/400/400",
    "category": "aksesuar"
  },
  {
    "id": 7,
    "title": "Dell XPS 15",
    "description":
        "Intel Core i7 ve NVIDIA RTX 4060 ile donatılmış güçlü laptop. 4K OLED dokunmatik ekran ve 86Wh büyük batarya.",
    "price": 1599.99,
    "image": "https://picsum.photos/seed/dell/400/400",
    "category": "bilgisayar"
  },
  {
    "id": 8,
    "title": "Apple Watch Series 9",
    "description":
        "S9 çipli Apple Watch. Daha parlak ekran, çift dokunma hareketi ve gelişmiş sağlık takip özellikleri.",
    "price": 399.99,
    "image": "https://picsum.photos/seed/watch/400/400",
    "category": "aksesuar"
  },
];

List<Product> getFakeProducts() {
  return fakeProductsJson.map((json) => Product.fromJson(json)).toList();
}