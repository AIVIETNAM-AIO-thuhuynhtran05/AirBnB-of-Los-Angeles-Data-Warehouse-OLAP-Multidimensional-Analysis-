Đồ án Kho dữ liệu (Data Warehouse) & OLAP - Airbnb Los Angeles 2025
📝 Giới thiệu đề tài
Đồ án tập trung vào việc xây dựng kho dữ liệu và phân tích dữ liệu Airbnb tại khu vực Los Angeles năm 2025. Mục tiêu chính là thu thập, làm sạch và chuẩn hóa dữ liệu từ các nguồn khác nhau, sau đó xây dựng mô hình đa chiều để phục vụ phân tích báo cáo (OLAP).

Giảng viên hướng dẫn: Đỗ Thị Minh Phụng

Lớp: IS217.Q13

Nhóm thực hiện: Nhóm 1

Thành viên: * Huỳnh Trần Anh Thư – 23521535

📊 Bộ dữ liệu (Dataset)
Tên cơ sở dữ liệu: Airbnb Los Angeles 2025.

Nguồn cung cấp: Inside Airbnb.

Thời gian thu thập: Năm 2025.

Các thành phần chính: Thông tin về các địa điểm cho thuê (listings), chủ sở hữu (hosts), khu vực (neighbourhoods), và các đánh giá (reviews).

🏗 Kiến trúc hệ thống
Hệ thống được xây dựng dựa trên quy trình ETL (Extract - Transform - Load) chuẩn:

Dữ liệu thô (Raw Data): File CSV/Excel từ Inside Airbnb.

Công cụ ETL: SQL Server Integration Services (SSIS).

Kho dữ liệu (Data Warehouse): SQL Server theo mô hình Star Schema (Sơ đồ hình sao).

Phân tích: SQL Server Analysis Services (SSAS) và các công cụ Visualization.

🛠 Các bước thực hiện chính (SSIS Workflow)
Quy trình SSIS được thiết kế chặt chẽ để đảm bảo tính toàn vẹn của dữ liệu:

Data Flow: Trích xuất dữ liệu từ nguồn file phẳng -> Sử dụng các công cụ chuyển đổi như Sort, Merge Join, Derived Column, Multicast.

Xử lý Dimension: Xây dựng các bảng chiều như DimHost, DimLocation, DimRoomType.

Xử lý Fact: Tính toán và đẩy dữ liệu vào bảng FactListing với các khóa ngoại tham chiếu đến các bảng Dimension đã tạo.

🚀 Hướng dẫn cài đặt & Chạy Project
Tiền đề: * Cài đặt SQL Server Management Studio (SSMS) 2021 hoặc mới hơn.

Cài đặt Visual Studio có tích hợp gói SSIS.

Khởi tạo Database: * Chạy script SQL để tạo cấu trúc bảng trong SSMS.

Chạy ETL:

Mở project SSIS trong Visual Studio.

Cấu hình Connection Managers để trỏ về đúng Server và Database của bạn.

Nhấn Start để tiến hành đổ dữ liệu từ file CSV vào SQL Server.

Kiểm tra kết quả:

Vào SQL Server để kiểm tra dữ liệu trong các bảng Fact và Dimension.

📈 Kết quả đạt được
Xây dựng thành công kho dữ liệu sạch, không còn giá trị rác (null) hoặc sai định dạng.

Tối ưu hóa việc truy vấn dữ liệu lớn thông qua mô hình Star Schema.

Sẵn sàng kết nối với Power BI hoặc Excel để tạo các báo cáo Dashboard phân tích xu hướng du lịch tại Los Angeles.
