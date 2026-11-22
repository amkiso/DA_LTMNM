-- =========================================================================
-- CƠ SỞ DỮ LIỆU: QuanLyThuVien (MySQL / MariaDB)
-- Hệ thống Quản lý Thư viện - Laravel 13
-- =========================================================================

SET NAMES utf8mb4;
SET time_zone = '+07:00';
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `QuanLyThuVien`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `QuanLyThuVien`;

-- -------------------------------------------------------------------------
-- 1. Bảng `migrations`
-- -------------------------------------------------------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_09_29_034524_add_role_to_users_table', 1),
(5, '2026_09_29_034530_create_tac_gias_table', 1),
(6, '2026_09_29_034531_create_the_loais_table', 1),
(7, '2026_09_29_034533_create_saches_table', 1),
(8, '2026_09_29_034534_create_sach_tac_gia_table', 1),
(9, '2026_09_29_034536_create_phieu_muons_table', 1),
(10, '2026_09_29_144809_add_profile_fields_to_users_table', 1),
(11, '2026_09_29_160717_create_phieu_phats_table', 1),
(12, '2026_09_29_162230_add_credit_and_notes_to_users_table', 1);

-- -------------------------------------------------------------------------
-- 2. Bảng `users`, `password_reset_tokens`, `sessions`
-- -------------------------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `ghi_chu_thu_thu` text DEFAULT NULL,
  `khoa_muon_sach` tinyint(1) NOT NULL DEFAULT '0',
  `ly_do_khoa` varchar(255) DEFAULT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `google2fa_secret` varchar(64) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------------------
-- 3. Bảng `cache`, `cache_locks`, `jobs`, `job_batches`, `failed_jobs`
-- -------------------------------------------------------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` varchar(255) NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------------------
-- 4. Bảng nghiệp vụ: `tac_gias`, `the_loais`, `saches`, `sach_tac_gia`, `phieu_muons`, `phieu_phats`
-- -------------------------------------------------------------------------
DROP TABLE IF EXISTS `tac_gias`;
CREATE TABLE `tac_gias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten_tac_gia` varchar(150) NOT NULL,
  `nam_sinh` int DEFAULT NULL,
  `quoc_tich` varchar(100) DEFAULT NULL,
  `tieu_su` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `the_loais`;
CREATE TABLE `the_loais` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten_the_loai` varchar(100) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `the_loais_ten_the_loai_unique` (`ten_the_loai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `saches`;
CREATE TABLE `saches` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten_sach` varchar(200) NOT NULL,
  `the_loai_id` bigint unsigned NOT NULL,
  `nam_xuat_ban` int DEFAULT NULL,
  `nha_xuat_ban` varchar(150) DEFAULT NULL,
  `so_luong` int NOT NULL DEFAULT '0',
  `hinh_anh` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `saches_the_loai_id_foreign` (`the_loai_id`),
  CONSTRAINT `saches_the_loai_id_foreign` FOREIGN KEY (`the_loai_id`) REFERENCES `the_loais` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sach_tac_gia`;
CREATE TABLE `sach_tac_gia` (
  `sach_id` bigint unsigned NOT NULL,
  `tac_gia_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`sach_id`,`tac_gia_id`),
  KEY `sach_tac_gia_tac_gia_id_foreign` (`tac_gia_id`),
  CONSTRAINT `sach_tac_gia_sach_id_foreign` FOREIGN KEY (`sach_id`) REFERENCES `saches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sach_tac_gia_tac_gia_id_foreign` FOREIGN KEY (`tac_gia_id`) REFERENCES `tac_gias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `phieu_muons`;
CREATE TABLE `phieu_muons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `sach_id` bigint unsigned NOT NULL,
  `ngay_muon` date NOT NULL,
  `ngay_tra_du_kien` date NOT NULL,
  `ngay_tra_thuc_te` date DEFAULT NULL,
  `trang_thai` enum('dang_muon','da_tra','qua_han') NOT NULL DEFAULT 'dang_muon',
  `ghi_chu` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `phieu_muons_user_id_foreign` (`user_id`),
  KEY `phieu_muons_sach_id_foreign` (`sach_id`),
  CONSTRAINT `phieu_muons_sach_id_foreign` FOREIGN KEY (`sach_id`) REFERENCES `saches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_muons_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `phieu_phats`;
CREATE TABLE `phieu_phats` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `phieu_muon_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `nguoi_thu_id` bigint unsigned DEFAULT NULL,
  `so_ngay_qua_han` int NOT NULL DEFAULT '0',
  `tien_phat_moi_ngay` int unsigned NOT NULL DEFAULT '5000',
  `tong_tien_phat` int unsigned NOT NULL DEFAULT '0',
  `ly_do` varchar(255) DEFAULT NULL,
  `trang_thai` enum('chua_nop','da_nop') NOT NULL DEFAULT 'chua_nop',
  `ngay_nop` datetime DEFAULT NULL,
  `ghi_chu` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phieu_phats_phieu_muon_id_unique` (`phieu_muon_id`),
  KEY `phieu_phats_user_id_foreign` (`user_id`),
  KEY `phieu_phats_nguoi_thu_id_foreign` (`nguoi_thu_id`),
  CONSTRAINT `phieu_phats_nguoi_thu_id_foreign` FOREIGN KEY (`nguoi_thu_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `phieu_phats_phieu_muon_id_foreign` FOREIGN KEY (`phieu_muon_id`) REFERENCES `phieu_muons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_phats_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------------------
-- 5. Dữ liệu mẫu (Seed Data) - Mật khẩu mặc định: 12345678
-- -------------------------------------------------------------------------
INSERT INTO `users` (`id`, `name`, `email`, `so_dien_thoai`, `dia_chi`, `ghi_chu_thu_thu`, `khoa_muon_sach`, `ly_do_khoa`, `ngay_sinh`, `password`, `role`, `google2fa_secret`, `created_at`, `updated_at`) VALUES
(1, 'Thủ thư Quản trị', 'admin@gmail.com', '0901234567', '140 Lê Trọng Tấn, P. Tây Thạnh, Q. Tân Phú, TP. HCM', NULL, 0, NULL, '1992-05-15', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHeFx5rG1xG9/8v7pM1.0p0wQ8K8K8K8K.', 'admin', 'JBSWY3DPEHPK3PXP', NOW(), NOW()),
(2, 'Nguyễn Thị Bích Thủy (Thủ thư quầy)', 'thuthu@thuvien.vn', '0909888999', 'Quận 1, TP. Hồ Chí Minh', NULL, 0, NULL, '1995-10-20', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHeFx5rG1xG9/8v7pM1.0p0wQ8K8K8K8K.', 'admin', 'JBSWY3DPEHPK3PXP', NOW(), NOW());
