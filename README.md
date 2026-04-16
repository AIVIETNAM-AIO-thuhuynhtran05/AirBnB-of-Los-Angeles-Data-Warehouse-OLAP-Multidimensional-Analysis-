# 🏠 Data Warehouse & OLAP - Airbnb Los Angeles 2025

## 📝 Giới thiệu đề tài
Đồ án tập trung vào việc xây dựng kho dữ liệu (Data Warehouse) và thực hiện quy trình ETL để phân tích dữ liệu Airbnb tại khu vực Los Angeles năm 2025. Mục tiêu chính là thu thập, làm sạch và chuẩn hóa dữ liệu từ các nguồn khác nhau, sau đó xây dựng mô hình đa chiều để phục vụ phân tích báo cáo (OLAP).

- **Giảng viên hướng dẫn:** Đỗ Thị Minh Phụng
- **Lớp:** IS217.Q13
- **Nhóm thực hiện:** Nhóm 1
- **Thành viên:** - Huỳnh Trần Anh Thư – 23521535
  ---

## 📊 Bộ dữ liệu (Dataset)
- **Tên cơ sở dữ liệu:** Airbnb Los Angeles 2025.
- **Nguồn cung cấp:** [Inside Airbnb](http://insideairbnb.com/)
- **Thời gian thu thập:** Năm 2025.
- **Các thành phần chính:** Thông tin về địa điểm cho thuê (listings), chủ sở hữu (hosts), khu vực (neighbourhoods), và các đánh giá (reviews).

---

## 🏗 Kiến trúc hệ thống
Hệ thống tuân thủ quy trình **ETL (Extract - Transform - Load)** chuẩn:
1. **Dữ liệu thô (Raw Data):** File CSV từ Inside Airbnb.
2. **Công cụ ETL:** SQL Server Integration Services (SSIS).
3. **Kho dữ liệu (Data Warehouse):** SQL Server theo mô hình **Star Schema** (Sơ đồ hình sao).
4. **Phân tích:** SQL Server Analysis Services (SSAS).

---

## 🛠 Quy trình SSIS (Workflow)
Quy trình được thiết kế chặt chẽ đảm bảo tính toàn vẹn dữ liệu:
- **Data Flow:** Trích xuất dữ liệu từ Flat File -> Chuyển đổi qua các công cụ: `Sort`, `Merge Join`, `Derived Column`, `Multicast`.
- **Xử lý Dimension:** Xây dựng các bảng chiều: `DimHost`, `DimLocation`, `DimRoomType`.
- **Xử lý Fact:** Tính toán và đẩy dữ liệu vào `FactListing` với các khóa ngoại tham chiếu tương ứng.

---

## 📂 Cấu trúc thư mục Project
```text
├── Data/                   # Chứa file dữ liệu thô (.csv)
├── SQL_Scripts/            # Script tạo Database, Tables và Constraints
├── SSIS_Project/           # Source code Visual Studio (Solution & dtsx)
├── Documentation/          # File báo cáo chi tiết (SSIS_BAOCAO.docx)
└── README.md               # Hướng dẫn này
