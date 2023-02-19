-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Waktu pembuatan: 26 Apr 2022 pada 04.34
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ci_barang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

DROP TABLE IF EXISTS `barang`;
CREATE TABLE IF NOT EXISTS `barang` (
  `id_barang` char(7) NOT NULL,
  `kode_barang` varchar(255) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `stok` int(11) NOT NULL,
  `jenis_id` int(11) NOT NULL,
  `nama_satuan` varchar(255) NOT NULL,
  `type_barang` varchar(255) NOT NULL,
  `warna_barang` varchar(255) NOT NULL,
  `ukuran_barang` varchar(255) NOT NULL,
  `berat_barang` varchar(255) NOT NULL,
  `merk_barang` varchar(255) NOT NULL,
  `seri_barang` varchar(255) NOT NULL,
  PRIMARY KEY (`id_barang`),
  KEY `kategori_id` (`jenis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `kode_barang`, `nama_barang`, `stok`, `jenis_id`, `nama_satuan`, `type_barang`, `warna_barang`, `ukuran_barang`, `berat_barang`, `merk_barang`, `seri_barang`) VALUES
('B000001', '1001', 'Kertas HVS', 0, 1, 'RIM', 'Polos', 'Putih', 'F4', '70 gsm', 'Copy Paper', '-'),
('B000002', '1002', 'Kertas HVS', 0, 1, 'RIM', 'Polos', 'Putih', 'F4', '70 gsm', 'Natural', '-'),
('B000003', '1003', 'Kertas HVS', 0, 1, 'RIM', 'Polos', 'Putih', 'F4', '70 gsm', 'Sidu', '-');

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_keluar`
--

DROP TABLE IF EXISTS `barang_keluar`;
CREATE TABLE IF NOT EXISTS `barang_keluar` (
  `id_barang_keluar` char(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_keluar` int(11) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  PRIMARY KEY (`id_barang_keluar`),
  KEY `id_user` (`user_id`),
  KEY `barang_id` (`barang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Trigger `barang_keluar`
--
DROP TRIGGER IF EXISTS `update_stok_keluar`;
DELIMITER $$
CREATE TRIGGER `update_stok_keluar` BEFORE INSERT ON `barang_keluar` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - NEW.jumlah_keluar WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_masuk`
--

DROP TABLE IF EXISTS `barang_masuk`;
CREATE TABLE IF NOT EXISTS `barang_masuk` (
  `id_barang_masuk` char(16) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_masuk` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  PRIMARY KEY (`id_barang_masuk`),
  KEY `id_user` (`user_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `barang_id` (`barang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Trigger `barang_masuk`
--
DROP TRIGGER IF EXISTS `update_stok_masuk`;
DELIMITER $$
CREATE TRIGGER `update_stok_masuk` BEFORE INSERT ON `barang_masuk` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + NEW.jumlah_masuk WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis`
--

DROP TABLE IF EXISTS `jenis`;
CREATE TABLE IF NOT EXISTS `jenis` (
  `id_jenis` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jenis` varchar(20) NOT NULL,
  PRIMARY KEY (`id_jenis`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jenis`
--

INSERT INTO `jenis` (`id_jenis`, `nama_jenis`) VALUES
(1, 'ATK'),
(8, 'Sekolah'),
(10, 'Buku'),
(11, 'Komputer'),
(12, 'Aksesoris'),
(13, 'Ulang Tahun'),
(14, 'Konsinyasi'),
(15, 'Makanan'),
(16, 'Minuman'),
(17, 'Rumah Tangga'),
(18, 'Jasa');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier` (
  `id_supplier` int(11) NOT NULL AUTO_INCREMENT,
  `nama_supplier` varchar(50) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `no_telp`, `alamat`) VALUES
(1, 'Fajri', '085348439785', 'Kalimantan Utara'),
(2, 'Khoirul', '081993335313', 'Madiun'),
(3, 'Tatak', '082245271900', 'Madiun');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `role` enum('gudang','admin') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  `foto` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `email`, `no_telp`, `role`, `password`, `created_at`, `foto`, `is_active`) VALUES
(1, 'Adminisitrator', 'admin', 'admin@admin.com', '025123456789', 'admin', '$2y$10$wMgi9s3FEDEPEU6dEmbp8eAAEBUXIXUy3np3ND2Oih.MOY.q/Kpoy', 1568689561, 'd5f22535b639d55be7d099a7315e1f7f.png', 1),
(14, 'Feby Velerina', 'feby', 'feby@gmail.com', '0895399680461', 'gudang', '$2y$10$soyt1j//hRyW0VOXmbasyeydeyg0ci6q5oqNky.g96ORG.oCfAC3q', 1650941576, '0aba9f2a1184b134f63f821d905b82fc.JPG', 1),
(15, 'Hema', 'hema', 'hema@gmail.com', '085853587558', 'gudang', '$2y$10$2BsDCd6L7bEaYYT9RsJK5uEdd114tYfAKcY7Lgws8/X778UxjHnua', 1650941830, 'user.png', 1),
(16, 'Khoirul', 'khoirul', 'khoirul@gmail.com', '081993335310', 'gudang', '$2y$10$OYlqd6p1n029vsNypHjlJ.ca9ilCLk4BFG8gHnemtwL.k11a0QJbq', 1650941937, 'user.png', 1),
(17, 'Fajri', 'fajri', 'fajri@gmail.com', '085348439785', 'gudang', '$2y$10$9RWvMTkxnFGo3Cly9hFWneS.cZQvnuSm5f332JxVdkW4SlF9KDxLO', 1650941978, 'user.png', 1),
(18, 'Tatak', 'tatak', 'tatak@gmail.com', '082245271900', 'gudang', '$2y$10$uBkUKxMVAVO7Cv7VeG.6X.2VkbOMf0KzqoVTV21hHFi.dusmY.3ku', 1650942014, 'user.png', 1);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`jenis_id`) REFERENCES `jenis` (`id_jenis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_3` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
