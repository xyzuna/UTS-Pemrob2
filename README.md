Berikut penjelasan lengkap untuk tiga pertanyaan Anda:

---

# **1. Bagaimana state management dengan Cubit membantu pengelolaan transaksi dengan logika diskon dinamis?**

**Cubit** (bagian dari Flutter Bloc) adalah state management yang sederhana dan reaktif. Cubit sangat membantu pada proses transaksi yang memiliki **logika diskon dinamis**, karena:

### ✅ **1. Memisahkan Logika Bisnis dari UI**

Semua aturan seperti:

* diskon berdasarkan jumlah item
* diskon hanya untuk produk tertentu
* diskon jika total transaksi melewati nominal tertentu
* diskon bertingkat (tiered discount)

diletakkan di **Cubit**, bukan di widget UI.
UI hanya mendengarkan perubahan state dan menampilkan hasilnya.

---

### ✅ **2. Mengelola Perubahan State Secara Real-time**

Cubit dapat mengubah state ketika:

* user menambah/mengurangi item
* user memasukkan kode voucher
* ada promo otomatis
* stok berubah

Cubit langsung menghitung ulang total harga + diskon tanpa perlu setState.

---

### ✅ **3. Mudah di-maintain dan Diperluas**

Jika besok jenis diskonnya bertambah (misal cashback, buy 1 get 1), Anda hanya perlu mengupdate fungsi di Cubit tanpa menyentuh UI.

---

### **Contoh Sederhana Cubit Diskon Dinamis**

```dart
class TransaksiCubit extends Cubit<TransaksiState> {
  TransaksiCubit() : super(TransaksiState.initial());

  void tambahItem(Item item) {
    final items = [...state.items, item];
    emit(state.copyWith(
      items: items,
      total: hitungTotal(items),
      diskon: hitungDiskon(items),
    ));
  }

  double hitungTotal(List<Item> items) {
    return items.fold(0, (t, e) => t + e.harga);
  }

  double hitungDiskon(List<Item> items) {
    final total = hitungTotal(items);

    if (total > 200000) return total * 0.10; // diskon 10%
    if (items.length > 5) return total * 0.05; // diskon 5%
    return 0;
  }
}
```

UI tinggal panggil:

```dart
BlocBuilder<TransaksiCubit, TransaksiState>(
  builder: (context, state) {
    return Text("Total bayar: Rp ${state.total - state.diskon}");
  },
);
```

---

# **2. Perbedaan Diskon Per Item vs Diskon Total Transaksi**

## **A. Diskon Per Item**

Diskon diberikan **pada tiap produk**, bukan pada total transaksi.

### Contoh:

* Produk A harga 10.000, diskon 20% → jadi 8.000
* Produk B harga 50.000, diskon 10% → jadi 45.000

Total transaksi = 8.000 + 45.000 = **53.000**

### Penerapan dalam aplikasi kasir:

* Promo khusus barang tertentu
* Clearance sale item tertentu
* Member discount hanya untuk item-brand tertentu

**Implementasi:**

```dart
double hitungHargaItem(Item item) {
  return item.harga - (item.harga * item.diskon);
}
```

---

## **B. Diskon Total Transaksi**

Diskon diberikan **setelah total harga semua item dijumlahkan**.

### Contoh:

* Total belanja = 500.000
* Diskon transaksi = 10%
  → Diskon 50.000
  → Bayar = **450.000**

### Penerapan dalam aplikasi kasir:

* Promo hari tertentu (misal diskon 10% di tanggal 10)
* Diskon minimum pembelian (belanja ≥ 200.000)
* Member VIP discount total

**Implementasi:**

```dart
double hitungDiskonTotal(double total) {
  if (total > 300000) return total * 0.10;
  return 0;
}
```

---

## **Ringkasan Perbedaan**

| Tipe Diskon         | Diterapkan Pada            | Contoh                    | Penggunaan            |
| ------------------- | -------------------------- | ------------------------- | --------------------- |
| **Diskon Per Item** | Harga barang satu per satu | Diskon 20% untuk Shampoo  | Promo item tertentu   |
| **Diskon Total**    | Total belanja keseluruhan  | Diskon 10% belanja ≥ 300k | Promo transaksi besar |

---

# **3. Manfaat Penggunaan Widget Stack Pada Tampilan Kategori Menu di Aplikasi Flutter**

Widget **Stack** sangat berguna ketika ingin menumpuk widget secara bertingkat, misalnya menampilkan gambar kategori dengan label overlay.

### **Manfaat:**

### ✅ **1. Menumpuk Elemen (Overlay)**

Stack memungkinkan membuat desain seperti:

* gambar menu + label kategori
* icon favorit di pojok gambar
* badge promo seperti “20% OFF”

### Contoh:

```dart
Stack(
  children: [
    Image.asset("images/minuman.jpg"),
    Positioned(
      bottom: 10,
      left: 10,
      child: Text("Minuman", style: TextStyle(color: Colors.white)),
    ),
    Positioned(
      top: 5,
      right: 5,
      child: Icon(Icons.favorite_border),
    ),
  ],
)
```

---

### ✅ **2. Membuat UI Lebih Modern dan Elegan**

Stack sering dipakai untuk:

* grid kategori
* card makanan (gambar + overlay gradient + nama makanan)
* banner promo dengan teks di atas gambar

---

### ✅ **3. Fleksibel dalam Penempatan Elemen**

Dengan `Positioned`, UI jadi lebih bebas:

* teks di kiri bawah
* icon di kanan atas
* tombol di tengah gambar

---

### Contoh Tampilan Kategori dengan Stack

```
+-----------------------------------+
|             (gambar)              |
|   [Icon promo]    [Icon favorit]  |
|                                   |
|        Nama Kategori (overlay)    |
+-----------------------------------+
```

---

# Jika Anda ingin, saya bisa:

✅ Buatkan **kode lengkap Cubit transaksi**
✅ Buatkan **model item + transaksi**
✅ Buatkan **UI kategori menu dengan Stack**
Cukup beri tahu saya.
