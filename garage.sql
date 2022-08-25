CREATE TABLE `owned_vehicles` (
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `renamecar` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fuel` int(12) DEFAULT 50,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `vip` tinyint(1) NOT NULL DEFAULT 0,
  `etatmoteur` int(10) NOT NULL DEFAULT 1000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);
COMMIT;