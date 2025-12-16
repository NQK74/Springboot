-- Insert roles
INSERT IGNORE INTO roles (id, name, description) VALUES 
(1, 'USER', 'Regular user role'),
(2, 'ADMIN', 'Administrator role'),
(3, 'STAFF', 'Staff role - manage products and orders'),
(4, 'SUPER_ADMIN', 'Super Administrator - highest level access');

-- Insert super admin user (password: 123456) - ID = 1 is SUPER_ADMIN
INSERT IGNORE INTO users (id, email, password, full_name, phone, address, avatar, role_id) VALUES 
(1, 'superadmin@laptopshop.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqvBLRn9jN6IvBzP2CJcPfLDRPYTC', 'Super Administrator', '0123456789', 'Hanoi, Vietnam', '', 4);

-- Insert regular admin user (password: 123456)
INSERT IGNORE INTO users (id, email, password, full_name, phone, address, avatar, role_id) VALUES 
(2, 'admin@laptopshop.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqvBLRn9jN6IvBzP2CJcPfLDRPYTC', 'Administrator', '0123456789', 'Hanoi, Vietnam', '', 2);

INSERT INTO products (name, price, detail_desc, short_desc, quantity, so_id, factory, target, image) VALUES 
('ASUS TUF Gaming F15 FX506HF', 17490000, 'Laptop gaming với Intel Core i5 thế hệ 11, card đồ họa RTX 2050, RAM 16GB DDR4. Thiết kế bền bỉ chuẩn quân đội, tản nhiệt Arc Flow Fans, phím RGB.', 'Laptop gaming ASUS hiệu năng cao', 85, 0, 'ASUS', 'GAMING', '1711078092373-asus-tuf-gaming-f15.webp'),

('Dell Inspiron 15 3520', 15490000, 'Intel Core i5-1235U, RAM 16GB, SSD 512GB NVMe. Màn hình 15.6 inch Full HD chống chói, bàn phím số tiện lợi, pin 54Wh.', 'Laptop Dell văn phòng đa năng', 120, 0, 'DELL', 'SINHVIEN-VANPHONG', '1711078452562-dell-inspiron-15-3520.png'),

('Lenovo IdeaPad Gaming 3 15IAH7', 19500000, 'Intel Core i5-12450H, NVIDIA GTX 1650 4GB, RAM 8GB. Màn hình 15.6 inch 120Hz, bàn phím LED trắng, âm thanh Nahimic.', 'Gaming laptop Lenovo giá tốt', 95, 0, 'LENOVO', 'GAMING', '1711079496409-lenovo-ideapad-gaming-3.jpg'),

('ASUS Vivobook 15 OLED', 16990000, 'Intel Core i5-13500H, Intel Iris Xe Graphics, RAM 16GB. Màn hình OLED 15.6 inch 2.8K, 100% DCI-P3, bảo vệ mắt.', 'Laptop ASUS màn hình OLED đẹp', 110, 0, 'ASUS', 'THIET-KE-DO-HOA', '1711079954990-asus-vivobook-15-oled.webp'),

('MacBook Air 13 M2 2022', 27490000, 'Chip Apple M2 8 nhân CPU 10 nhân GPU, RAM 16GB. Màn hình Liquid Retina 13.6 inch, MagSafe 3, thiết kế 4 màu.', 'MacBook Air M2 mỏng nhẹ', 75, 0, 'APPLE', 'SINHVIEN-VANPHONG', '1711080286941-macbook-air-13-m2.png'),

('LG Gram 17 2023', 35990000, 'Intel Core i7-1360P, Intel Iris Xe, RAM 16GB. Màn hình 17 inch 2K, trọng lượng chỉ 1.35kg, pin 80Wh 19.5 giờ.', 'Laptop LG Gram siêu nhẹ 17 inch', 65, 0, 'LG', 'THIET-KE-DO-HOA', '1711080707179-lg-gram-17-2023.jpg'),

('Acer Nitro 5 AN515-58', 21990000, 'Intel Core i7-12650H, NVIDIA RTX 3050 Ti 4GB, RAM 16GB. Màn hình 15.6 inch 144Hz, bàn phím RGB 4 vùng, NitroSense.', 'Laptop gaming Acer tản nhiệt tốt', 100, 0, 'ACER', 'GAMING', '1711080973171-acer-nitro-5-an515.jpg'),

('HP Pavilion 15-eg2xxx', 18490000, 'Intel Core i5-1235U, Intel Iris Xe, RAM 16GB, SSD 512GB. Màn hình 15.6 inch Full HD IPS, loa B&O, vỏ nhôm.', 'Laptop HP đa năng cao cấp', 130, 0, 'HP', 'SINHVIEN-VANPHONG', '1711081278418-hp-pavilion-15-eg2.webp'),

('MSI Modern 14 C13M', 14990000, 'Intel Core i5-1335U, Intel Iris Xe, RAM 16GB. Màn hình 14 inch Full HD, trọng lượng 1.4kg, pin 56Wh, thiết kế mỏng.', 'Laptop MSI Modern di động nhẹ', 140, 0, 'MSI', 'SINHVIEN-VANPHONG', '1711082152818-msi-modern-14-c13m.jpg'),

('Lenovo ThinkBook 14 G4', 17990000, 'AMD Ryzen 5 5625U, AMD Radeon Graphics, RAM 16GB. Màn hình 14 inch Full HD IPS, bàn phím chống tràn, bảo mật vân tay.', 'Laptop Lenovo doanh nghiệp', 105, 0, 'LENOVO', 'SINHVIEN-VANPHONG', '1711083025647-lenovo-thinkbook-14-g4.webp');