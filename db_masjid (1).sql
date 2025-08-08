-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 30, 2025 at 02:21 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_masjid`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_masjid`
--

CREATE TABLE `about_masjid` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `visi` text DEFAULT NULL,
  `misi` text DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `about_masjid`
--

INSERT INTO `about_masjid` (`id`, `nama`, `alamat`, `deskripsi`, `visi`, `misi`, `latitude`, `longitude`) VALUES
(1, 'Masjid Baiturrahman', 'Jalan Jenderal Sudirman, Sumahilang Subdistrict, District of Pekanbaru Kota, Pekanbaru, Pekanbaru Kota, Riau, Sumatra, 28156, Indonesia', 'Masjid terbesar di kota dengan berbagai kegiatan ibadah dan sosial.', 'Menjadi pusat dakwah Islam', 'Meningkatkan iman dan takwa', '0.526564', '101.447578');

-- --------------------------------------------------------

--
-- Table structure for table `inventaris`
--

CREATE TABLE `inventaris` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(100) DEFAULT NULL,
  `asal` enum('sedekah','pembelian','hibah') DEFAULT NULL,
  `kondisi` enum('baik','rusak','perlu perbaikan') DEFAULT NULL,
  `jenis` enum('elektronik','perabot','alat ibadah','lainnya') DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventaris`
--

INSERT INTO `inventaris` (`id`, `nama_barang`, `asal`, `kondisi`, `jenis`, `jumlah`, `keterangan`, `tanggal`) VALUES
(1, 'Meja', 'sedekah', 'rusak', 'alat ibadah', 1, 'ssasa', '2025-07-20'),
(2, 'Kursi', 'pembelian', 'perlu perbaikan', 'perabot', 20, 'qsqsq', '2025-07-21');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_sholat`
--

CREATE TABLE `jadwal_sholat` (
  `id` int(11) NOT NULL,
  `subuh` time NOT NULL,
  `dzuhur` time NOT NULL,
  `ashar` time NOT NULL,
  `maghrib` time NOT NULL,
  `isya` time NOT NULL,
  `tanggal` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jadwal_sholat`
--

INSERT INTO `jadwal_sholat` (`id`, `subuh`, `dzuhur`, `ashar`, `maghrib`, `isya`, `tanggal`, `created_at`) VALUES
(20, '04:54:00', '12:21:00', '15:45:00', '18:25:00', '19:38:00', '2025-07-20', '2025-07-20 17:29:44'),
(29, '04:54:00', '12:21:00', '15:44:00', '18:25:00', '19:38:00', '2025-07-21', '2025-07-21 09:01:19'),
(31, '04:54:00', '12:21:00', '15:44:00', '18:25:00', '19:38:00', '2025-07-22', '2025-07-21 17:01:55'),
(32, '04:54:00', '12:21:00', '15:44:00', '18:25:00', '19:38:00', '2025-07-23', '2025-07-23 09:09:38'),
(33, '04:55:00', '12:21:00', '15:44:00', '18:25:00', '19:38:00', '2025-07-26', '2025-07-26 13:56:20'),
(34, '04:55:00', '12:21:00', '15:43:00', '18:25:00', '19:38:00', '2025-07-29', '2025-07-29 10:48:10');

-- --------------------------------------------------------

--
-- Table structure for table `keuangan_pemasukan`
--

CREATE TABLE `keuangan_pemasukan` (
  `id` int(11) NOT NULL,
  `kategori` enum('zakat','infaq','sedekah') NOT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `bukti_pembayaran` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tanggal` date NOT NULL,
  `status` enum('pending','verified','rejected') DEFAULT 'pending',
  `alasan_penolakan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keuangan_pemasukan`
--

INSERT INTO `keuangan_pemasukan` (`id`, `kategori`, `nominal`, `keterangan`, `bukti_pembayaran`, `user_id`, `tanggal`, `status`, `alasan_penolakan`) VALUES
(2, 'zakat', 30000.00, 'Zakat andre\r\n', '1753077537.jpeg', 2, '2025-07-21', 'verified', NULL),
(3, 'sedekah', 30000.00, 'andre', '', 3, '2025-07-21', 'pending', NULL),
(4, 'infaq', 200000.00, 'infaq masjid', '1753078133.png', 2, '2025-07-21', 'verified', NULL),
(5, 'sedekah', 20000.00, 'sedekah', '', 2, '2025-07-21', 'pending', NULL),
(6, 'infaq', 20000.00, 'infaq mesjid', '', 2, '2025-07-21', 'verified', NULL),
(7, 'zakat', 20000.00, 'zakat mal', '1753110093.jpg', 2, '2025-07-21', 'rejected', 'tidak sesuai'),
(8, 'infaq', 30000.00, '', '', 2, '2025-07-26', 'pending', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `keuangan_pengeluaran`
--

CREATE TABLE `keuangan_pengeluaran` (
  `id` int(11) NOT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keuangan_pengeluaran`
--

INSERT INTO `keuangan_pengeluaran` (`id`, `nominal`, `keterangan`, `tanggal`) VALUES
(3, 3000.00, 'service', '2025-07-21');

-- --------------------------------------------------------

--
-- Table structure for table `pengumuman_acara`
--

CREATE TABLE `pengumuman_acara` (
  `id` int(11) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi` text NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengumuman_acara`
--

INSERT INTO `pengumuman_acara` (`id`, `judul`, `isi`, `tanggal`, `jam`, `created_at`) VALUES
(1, 'Ceramah Ustad', 'Ceramah ustad', '2025-07-20', NULL, '2025-07-20 15:16:16'),
(2, 'Gotong Royong', 'Acara nya dihadiri oleh', '2025-07-20', NULL, '2025-07-20 16:18:19'),
(3, 'Ceramah harian', 'dsdjsnds', '2025-07-21', '19:00:00', '2025-07-21 05:01:01'),
(6, 'kajian islam', 'sasajs', '2025-07-21', '10:31:00', '2025-07-21 07:31:14'),
(7, 'tes', 'aasa', '2025-07-21', '10:19:00', '2025-07-21 08:19:29'),
(8, 'ewewe', 'sss', '2025-07-21', '10:39:00', '2025-07-21 08:40:08');

-- --------------------------------------------------------

--
-- Table structure for table `pengumuman_kegiatan`
--

CREATE TABLE `pengumuman_kegiatan` (
  `id` int(11) NOT NULL,
  `jenis` enum('Kegiatan','Pengumuman','Takziah') NOT NULL,
  `judul` varchar(255) NOT NULL,
  `isi` text NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengumuman_kegiatan`
--

INSERT INTO `pengumuman_kegiatan` (`id`, `jenis`, `judul`, `isi`, `tanggal`, `jam`, `created_at`) VALUES
(1, 'Pengumuman', 'Telah meninggalnya bapak irul', 'dsajas', '2025-07-21', '09:40:00', '2025-07-21 07:41:15'),
(2, 'Takziah', 'ewewe', 'jhj\r\n', '2025-07-21', '16:02:00', '2025-07-21 09:02:31');

-- --------------------------------------------------------

--
-- Table structure for table `profil_masjid`
--

CREATE TABLE `profil_masjid` (
  `id` int(11) NOT NULL,
  `nama_masjid` varchar(200) NOT NULL,
  `alamat` text NOT NULL,
  `visi_misi` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `telegram_chat_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `email`, `password`, `role`, `created_at`, `telegram_chat_id`) VALUES
(1, 'Administrator', 'admin@masjid.com', '0192023a7bbd73250516f069df18b500', 'admin', '2025-07-20 19:52:51', NULL),
(2, 'Andre Wahyu', 'andrewahyu10@gmail.com', '19984dcaea13176bbb694f62ba6b5b35', 'user', '2025-07-21 04:51:36', '380459607'),
(3, 'ridho', 'ridho@gmail.com', '926a161c6419512d711089538c80ac70', 'user', '2025-07-21 04:59:03', NULL),
(4, 'ijal', 'ijal@masjid.com', '19984dcaea13176bbb694f62ba6b5b35', 'user', '2025-07-21 08:33:53', '1234556');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_masjid`
--
ALTER TABLE `about_masjid`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventaris`
--
ALTER TABLE `inventaris`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jadwal_sholat`
--
ALTER TABLE `jadwal_sholat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `keuangan_pemasukan`
--
ALTER TABLE `keuangan_pemasukan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `keuangan_pengeluaran`
--
ALTER TABLE `keuangan_pengeluaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengumuman_acara`
--
ALTER TABLE `pengumuman_acara`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengumuman_kegiatan`
--
ALTER TABLE `pengumuman_kegiatan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profil_masjid`
--
ALTER TABLE `profil_masjid`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_masjid`
--
ALTER TABLE `about_masjid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inventaris`
--
ALTER TABLE `inventaris`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jadwal_sholat`
--
ALTER TABLE `jadwal_sholat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `keuangan_pemasukan`
--
ALTER TABLE `keuangan_pemasukan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `keuangan_pengeluaran`
--
ALTER TABLE `keuangan_pengeluaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pengumuman_acara`
--
ALTER TABLE `pengumuman_acara`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pengumuman_kegiatan`
--
ALTER TABLE `pengumuman_kegiatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `profil_masjid`
--
ALTER TABLE `profil_masjid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
