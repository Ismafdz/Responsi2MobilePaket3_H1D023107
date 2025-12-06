# Responsi 2 Mobile Programming - Paket 3

Aplikasi inventaris barang (kategori Buku) berbasis mobile menggunakan **Flutter** dan backend **CodeIgniter 4**. Aplikasi ini menerapkan fitur Login, Register, dan CRUD (Create, Read, Update, Delete) dengan tema warna coklat.

## 👤 Identitas Mahasiswa

| Item | Detail |
| :--- | :--- |
| **Nama** | **Isma** |
| **NIM** | **H1D023107** |
| **Shift Baru** | [C] |
| **Shift Asal** | [D] |

---

## Video Demo Aplikasi

Berikut adalah demonstrasi penggunaan aplikasi mulai dari Login, Registrasi, hingga CRUD Buku:

[ **KLIK DISINI UNTUK MELIHAT VIDEO DEMO** ]( https://drive.google.com/file/d/18VFINnu8QYo_XtZoF2aKmL2x-yniburP/view?usp=sharing )


---

## Spesifikasi API (Backend)

Aplikasi ini terhubung dengan backend CodeIgniter 4. Berikut adalah dokumentasi Endpoint API yang digunakan:

### 1. Autentikasi

#### **Registrasi**
* **URL:** `/registrasi`
* **Method:** `POST`
* **Body (JSON):**
    ```json
    {
      "nama": "Isma",
      "email": "isma@example.com",
      "password": "password123"
    }
    ```

#### **Login**
* **URL:** `/login`
* **Method:** `POST`
* **Body (JSON):**
    ```json
    {
      "email": "isma@example.com",
      "password": "password123"
    }
    ```
* **Response:** Mengembalikan `token` dan `userID`.

---

### 2. Manajemen Buku (CRUD)

#### **Lihat Semua Buku (List)**
* **URL:** `/buku`
* **Method:** `GET`
* **Response:** Daftar semua data buku dalam format JSON.

#### **Tambah Buku (Create)**
* **URL:** `/buku`
* **Method:** `POST`
* **Body (JSON):**
    ```json
    {
      "judul": "Pemrograman Mobile",
      "harga": "50000",
      "jumlah": "10",
      "tanggal_masuk": "2023-12-01",
      "volume": "1",
      "penulis": "Isma",
      "penerbit": "Abimart Press"
    }
    ```

#### **Detail Buku (Read)**
* **URL:** `/buku/{id}`
* **Method:** `GET`
* **Keterangan:** Mengambil detail satu buku berdasarkan ID.

#### **Ubah Buku (Update)**
* **URL:** `/buku/{id}`
* **Method:** `PUT`
* **Body:** (Sama seperti Create, dengan data yang diubah).

#### **Hapus Buku (Delete)**
* **URL:** `/buku/{id}`
* **Method:** `DELETE`
* **Keterangan:** Menghapus data buku dari database berdasarkan ID.

---

## Penjelasan Kode & Fungsi

Aplikasi dibangun dengan struktur folder yang terorganisir untuk memisahkan Logic, UI, dan Data.

### 1. Folder `helpers/` (Utilitas)
* **`api.dart`**: Class `Api` menangani koneksi HTTP dasar. Class ini memiliki fungsi `post()`, `get()`, `put()`, dan `delete()` yang secara otomatis menyisipkan header token untuk keamanan.
* **`api_url.dart`**: Menyimpan konstanta alamat IP Server dan endpoint agar mudah diganti jika IP berubah.
* **`user_info.dart`**: Menggunakan `SharedPreferences` untuk menyimpan Token dan User ID di memori HP agar user tetap login meskipun aplikasi ditutup.

### 2. Folder `model/` (Struktur Data)
* **`buku.dart`**: Memetakan data JSON dari server menjadi objek Dart. Memiliki atribut sesuai soal: `judul`, `harga`, `jumlah`, `tanggalMasuk`, `volume`, `penulis`, dan `penerbit`.
* **`login.dart` & `registrasi.dart`**: Model untuk menangani respon saat proses otentikasi.

### 3. Folder `bloc/` (Business Logic)
Bertugas sebagai jembatan antara Tampilan (UI) dan Backend (API).
* **`buku_bloc.dart`**:
    * `getBuku()`: Meminta list buku ke API.
    * `addBuku()`: Mengirim data buku baru ke API.
    * `updateBuku()`: Mengirim perubahan data ke API.
    * `deleteBuku()`: Mengirim permintaan hapus ke API.
* **`login_bloc.dart` & `registrasi_bloc.dart`**: Mengirim kredensial user ke API untuk diverifikasi.

### 4. Folder `ui/` (Tampilan Antarmuka)
* **`login_page.dart`**: Halaman pertama. Meminta input email & password. Jika sukses, Token disimpan dan diarahkan ke `BukuPage`.
* **`registrasi_page.dart`**: Form pendaftaran member baru dengan validasi input.
* **`buku_page.dart` (List Buku)**:
    * Menampilkan daftar buku menggunakan `FutureBuilder`.
    * Memiliki **Drawer** (Side Menu) untuk fitur Logout.
    * **Action Bar** menampilkan nama "Inventaris Buku Isma".
* **`buku_detail.dart`**:
    * Menampilkan detail lengkap buku (termasuk Penulis & Penerbit).
    * Memiliki tombol **Edit** (ke form) dan **Delete** (konfirmasi hapus).
* **`buku_form.dart`**:
    * Halaman reusable untuk **Tambah** dan **Ubah**.
    * Jika menerima data buku, form terisi otomatis (Mode Edit). Jika kosong, menjadi Mode Tambah.

---

## Cara Menjalankan Project

### Persiapan Backend
1.  Pastikan XAMPP/Laragon berjalan (Apache & MySQL).
2.  Pastikan database `toko_api` memiliki tabel `buku`, `member`, dan `member_token`.
3.  Jalankan server CI4 dengan host IP Laptop:
    ```bash
    php spark serve --host [IP laptop]
    ```

### Persiapan Mobile
1.  Sesuaikan IP Address di `lib/helpers/api_url.dart`.
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Jalankan aplikasi:
    ```bash
    flutter run
    ```
