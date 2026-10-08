# Data Warehouse & OLAP - Airbnb Los Angeles 2025
##  Giới thiệu đề tài

Đồ án tập trung vào việc xây dựng **kho dữ liệu (Data Warehouse)**, thực hiện **quy trình ETL**, xây dựng **mô hình OLAP**, và phát triển **Data Mining** để phân tích dữ liệu Airbnb tại khu vực Los Angeles năm 2025.

**Mục tiêu chính:**
- Thu thập, làm sạch và chuẩn hóa dữ liệu từ các nguồn khác nhau
- Xây dựng mô hình đa chiều (Star Schema) để phục vụ phân tích OLAP
- Phát triển các mô hình Machine Learning để **dự đoán mức độ ảnh hưởng của thuộc tính lên doanh thu**
- Tích hợp kết quả vào SSAS để hỗ trợ quyết định kinh doanh

---

## Thông tin đề tài

| Thông tin | Chi tiết |
|-----------|---------|
| **Giảng viên hướng dẫn** | Đỗ Thị Minh Phụng |
| **Lớp** | IS217.Q13 |
| **Nhóm thực hiện** | Nhóm 1 |
| **Thành viên** | Huỳnh Trần Anh Thư – 23521535 |

---

## 📊 Bộ dữ liệu (Dataset)

| Thuộc tính | Nội dung |
|-----------|---------|
| **Tên cơ sở dữ liệu** | Airbnb Los Angeles 2025 |
| **Nguồn cung cấp** | [Inside Airbnb](http://insideairbnb.com/) |
| **Thời gian thu thập** | Năm 2025 |
| **Số lượng records** | 11,996 listings |
| **Số lượng cột** | 27 thuộc tính |
| **Các thành phần chính** | Listings, Hosts, Neighbourhoods, Reviews |

---

## 🏗 Kiến trúc hệ thống

Hệ thống tuân thủ quy trình **ETL (Extract - Transform - Load)** chuẩn:

```
┌─────────────────────────────────────────────────────────────────┐
│                      1. DATA SOURCES                             │
│               CSV files from Inside Airbnb                        │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                      2. ETL PROCESS (SSIS)                       │
│   • Extract: Trích xuất từ Flat File                            │
│   • Transform: Sort, Merge Join, Derived Column, Multicast      │
│   • Load: Đẩy vào SQL Server                                    │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│              3. DATA WAREHOUSE (SQL Server)                      │
│   • Star Schema: Fact & Dimension Tables                        │
│   • Tables: DimHost, DimLocation, DimRoomType, FactListing     │
└──────────────────────────┬──────────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        ▼                  ▼                  ▼
   ┌─────────┐        ┌──────────┐      ┌──────────┐
   │  OLAP   │        │Data Mining│      │ Reports  │
   │ (SSAS)  │        │   (ML)   │      │ & BI     │
   └─────────┘        └──────────┘      └──────────┘
```

---

## 🛠 Quy trình SSIS (Workflow)

Quy trình được thiết kế chặt chẽ đảm bảo tính toàn vẹn dữ liệu:

### Data Flow:
- **Extract:** Trích xuất dữ liệu từ Flat File (CSV)
- **Transform:** 
  - `Sort`: Sắp xếp dữ liệu
  - `Merge Join`: Kết nối dữ liệu từ nhiều nguồn
  - `Derived Column`: Tính toán cột mới
  - `Multicast`: Phân phối dữ liệu đến nhiều đích
- **Load:** Đẩy dữ liệu vào các bảng Dimension và Fact

### Xử lý Dimension:
- **DimHost**: Thông tin chủ sở hữu
- **DimLocation**: Thông tin khu vực địa lý
- **DimRoomType**: Loại phòng

### Xử lý Fact:
- **FactListing**: Tính toán doanh thu, số đặt phòng, với khóa ngoại tham chiếu

---

## 📁 Cấu trúc thư mục Project

Các thư mục được đánh số theo đúng thứ tự của pipeline, từ dữ liệu đầu vào đến phân tích:

```
├── 01_data/
│   └── listings_ready_change.csv     # Dữ liệu đã qua EDA và chuyển đổi (11,996 listings, 27 cột)
├── 02_data_warehouse_sql/
│   └── SQL_AIRBNB.sql                # Tạo database, bảng Fact & Dimension (Star Schema)
├── 03_etl_ssis/                      # SSIS project: nạp dữ liệu vào Data Warehouse
│   ├── AirBnB.sln
│   └── AirBnB/
│       ├── Package.dtsx              # Luồng ETL chính (Sort, Merge Join, Derived Column, Multicast)
│       ├── AirBnB.dtproj
│       ├── AirBnB.database
│       └── Project.params
├── 04_olap_ssas/                     # SSAS project: Cube OLAP đa chiều
│   ├── SSAS_AIRBNB.sln
│   └── SSAS_AIRBNB/
│       ├── Final.cube                # Cube chính
│       ├── Dim Host Final.dim        # Dimension: Host
│       ├── Dim Location.dim          # Dimension: Location
│       ├── Dim Room Type.dim         # Dimension: Room Type
│       ├── Dim Time.dim              # Dimension: Time
│       ├── Final.ds / Final.dsv      # Data source & data source view
│       └── ...
├── 05_powerbi/
│   └── PowerBI_OLAP.pbix             # Báo cáo Power BI kết nối OLAP
├── 06_data_mining/                   # Kết quả notebook (xuất PDF từ Google Colab)
│   ├── 01_Logistic_Regression.pdf
│   ├── 02_Random_Forest.pdf
│   ├── 03_XGBoost.pdf
│   └── 04_OLAP_Analysis.pdf
├── docs/
│   └── IS217_23521535_23520537.docx  # Báo cáo đồ án
└── README.md
```

> **Lưu ý:** `listings_ready_change.csv` là dữ liệu **sau khi đã EDA và chuyển đổi** từ dữ liệu gốc của [Inside Airbnb](http://insideairbnb.com/), sẵn sàng để nạp vào Data Warehouse qua SSIS.

---

## 🤖 Data Mining & Machine Learning

### 📋 Tổng Quan

Phần Data Mining sử dụng **3 mô hình Machine Learning** để dự đoán mức độ ảnh hưởng của các thuộc tính lên **liệu một host có phải Superhost hay không** (bài toán classification nhị phân). Các kết quả này giúp hiểu rõ những yếu tố quan trọng nhất ảnh hưởng đến chất lượng dịch vụ và doanh thu.

### 📊 Dữ Liệu Huấn Luyện

**Đặc trưng (Features) sử dụng:**

| Đặc trưng | Mô tả | Loại |
|----------|-------|------|
| `host_response_rate` | Tỷ lệ phản hồi của host | Số (0-1) |
| `host_acceptance_rate` | Tỷ lệ chấp nhận yêu cầu | Số (0-1) |
| `host_experience` | Năm kinh nghiệm làm host | Số (0-17) |
| `number_of_reviews` | Tổng số đánh giá nhận được | Số (0-3119) |
| `reviews_per_month` | Số đánh giá per tháng | Số (0.01-48.73) |
| `review_scores_rating` | Điểm đánh giá trung bình | Số (1.0-5.0) |

**Target Variable:**
- `host_is_superhost` = 1 (Superhost) hoặc 0 (Host thường)

**Phân tách dữ liệu:**
- Training set: 70% (9,111 samples)
- Test set: 30% (3,885 samples)

---

##  Ba Mô Hình Machine Learning

### Logistic Regression

**Mô tả:**
Mô hình tuyến tính dùng cho phân loại nhị phân. Dự đoán xác suất một host là Superhost dựa trên các đặc trưng đầu vào.

**Ưu điểm:**
-  Đơn giản, dễ hiểu và giải thích
- Tốc độ huấn luyện nhanh
-  Hiệu quả với dữ liệu tuyến tính

**Nhược điểm:**
- Không xử lý được mối quan hệ phi tuyến phức tạp
- Độ chính xác có thể thấp hơn các mô hình phức tạp

**Kết quả trên Test Set:**

| Metric | Giá trị |
|--------|--------|
| Accuracy | 70.49% |
| Precision | 70.64% |
| Recall | 87.03% |
| F1-Score | 77.99% |
| ROC-AUC | 74.85% |

**Feature Importance (Top 3):**

| Đặc trưng | Mức độ ảnh hưởng |
|----------|-----------------|
| `host_response_rate` | 3.423 |
| `review_scores_rating` | 3.172 |
| `host_acceptance_rate` | 1.819 |

---

###  Random Forest

**Mô tả:**
Ensemble method kết hợp nhiều cây quyết định độc lập. Xây dựng các cây song song và lấy trung bình kết quả để dự đoán.

**Ưu điểm:**
- Xử lý tốt mối quan hệ phi tuyến và tương tác giữa features
- Cung cấp feature importance chi tiết
-  Kháng tính tốt với overfitting
-  Có thể chạy song song (parallel processing)

**Nhược điểm:**
- Khó giải thích so với Logistic Regression
- Tốn kém bộ nhớ và thời gian tính toán
- Tốc độ dự đoán chậm hơn

**Kết quả trên Test Set:**

| Metric | Giá trị |
|--------|--------|
| Accuracy | 80.82% |
| Precision | 77.22% |
| Recall | 81.26% |
| F1-Score | 79.18% |
| ROC-AUC | 90.19% |

**Feature Importance (Top 3):**

| Đặc trưng | Mức độ ảnh hưởng |
|----------|-----------------|
| `host_acceptance_rate` | 0.2504 |
| `reviews_per_month` | 0.2406 |
| `number_of_reviews` | 0.1861 |

---

### XGBoost (eXtreme Gradient Boosting)

**Mô tả:**
Phiên bản cải tiến của Gradient Boosting. Xây dựng cây tuần tự, mỗi cây được huấn luyện để khắc phục lỗi của cây trước đó. XGBoost được biết đến vì hiệu suất cao và tốc độ tối ưu.

**Ưu điểm:**
- **Độ chính xác cao nhất** trong 3 mô hình
-  Xử lý rất tốt mối quan hệ phi tuyến phức tạp
-  Cung cấp feature importance chi tiết
-  Tối ưu hóa tốc độ và hiệu suất
-  Hỗ trợ distributed computing

**Nhược điểm:**
- Khó giải thích kết quả (black-box model)
-  Yêu cầu điều chỉnh nhiều hyperparameters

**Kết quả trên Test Set:**

| Metric | Giá trị |
|--------|--------|
| Accuracy | 77.89% |
| Precision | 78.06% |
| Recall | 87.72% |
| F1-Score | 82.61% |
| ROC-AUC | 83.76% |

**Feature Importance (Top 3):**

| Đặc trưng | Mức độ ảnh hưởng |
|----------|-----------------|
| `review_scores_rating` | 0.2332 |
| `host_response_rate` | 0.2181 |
| `host_acceptance_rate` | 0.1815 |

---

## 📈 Bảng So Sánh 3 Mô Hình

| Tiêu chí | Logistic Regression | Random Forest | XGBoost |
|---------|---------------------|---------------|---------|
| **Accuracy** | 70.49% | 80.82% | 77.89% |
| **Precision** | 70.64% | 77.22% | 78.06% |
| **Recall** | 87.03% | 81.26% | 87.72% |
| **F1-Score** | 77.99% | 79.18% | 82.61% |
| **ROC-AUC** | 74.85% | 90.19% | 83.76% |
| **Tốc độ huấn luyện** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| **Khả năng giải thích** | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| **Độ chính xác** | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |

---

## 🏆 Quyết định Chọn Mô Hình Tối Ưu

**Kết luận:**
- **Random Forest** cho **ROC-AUC cao nhất (90.19%)** - tốt nhất cho việc phân biệt Superhost vs Normal Host
- **XGBoost** cho **F1-Score cao nhất (82.61%)** - cân bằng tốt giữa Precision & Recall
- **Logistic Regression** cho **Recall cao nhất (87.03%)** - tìm được hầu hết Superhosts

**Khuyến nghị sử dụng:**
1. **Random Forest** cho production (đa dụng, hiệu suất cao, giải thích được)
2. **XGBoost** nếu cần độ chính xác tuyệt đối
3. **Logistic Regression** nếu cần mô hình đơn giản, nhanh

---

## 💡 Feature Importance Insights

**Top 5 Đặc trưng Quan Trọng Nhất (theo consensus của 3 mô hình):**

1. **`host_response_rate`** (Tỷ lệ phản hồi)
   - Superhost thường có tỷ lệ phản hồi cao
   - Impact: **Cao**

2. **`review_scores_rating`** (Điểm đánh giá trung bình)
   - Superhost nhận được điểm đánh giá cao
   - Impact: **Cao**

3. **`host_acceptance_rate`** (Tỷ lệ chấp nhận yêu cầu)
   - Superhost chấp nhận nhiều yêu cầu hơn
   - Impact: **Cao**

4. **`reviews_per_month`** (Số đánh giá per tháng)
   - Superhost có tần suất đặt phòng cao
   - Impact: **Trung bình**

5. **`number_of_reviews`** (Tổng số đánh giá)
   - Superhost có kinh nghiệm lâu dài
   - Impact: **Trung bình**

---

## 🔗 Tích Hợp SSAS & OLAP

### Bước 1: Lưu Trữ Kết Quả Dự Đoán

```sql
CREATE TABLE PredictionResults (
    ListingID INT,
    ActualRevenue FLOAT,
    PredictedRevenue FLOAT,
    Model VARCHAR(50),
    Confidence FLOAT,
    PredictionDate DATETIME
);
```

### Bước 2: Xây Dựng Cube SSAS

**Dimensions:**
- `DimHost` - Chủ sở hữu và thuộc tính của họ
- `DimLocation` - Vị trí địa lý
- `DimRoomType` - Loại phòng

**Measures:**
- `ActualRevenue` - Doanh thu thực
- `PredictedRevenue` - Doanh thu dự đoán
- `Confidence` - Độ tin cậy của dự đoán
- `Feature Importance` - Mức độ ảnh hưởng

**KPIs:**
- `Revenue Prediction Accuracy` - Độ chính xác dự đoán

### Bước 3: Tạo Báo Cáo OLAP

Sử dụng Power BI hoặc SQL Server Reporting Services:
- So sánh doanh thu thực vs dự đoán theo vị trí
- Phân tích mức độ ảnh hưởng của từng đặc trưng
- Dự đoán xu hướng doanh thu trong tương lai
- Dashboard theo dõi Superhost rate

---

## 🛠 Công Cụ & Công Nghệ

| Thành phần | Công Cụ |
|-----------|---------|
| **ETL** | SQL Server Integration Services (SSIS) |
| **Data Warehouse** | SQL Server 2019+ |
| **OLAP** | SQL Server Analysis Services (SSAS) |
| **Reporting** | Power BI / Reporting Services |
| **Data Mining** | Python (scikit-learn, XGBoost, pandas) |
| **Development** | Visual Studio, Jupyter Notebook |

---

## 📚 Các Bước Triển Khai

### Phase 1: Database & ETL (1-2 tuần)
1. ✅ Tạo Database & Tables
2. ✅ Develop SSIS Package
3. ✅ Load dữ liệu
4. ✅ Data validation & cleaning

### Phase 2: OLAP & Analysis (1 tuần)
1. ✅ Xây dựng Dimensions & Facts
2. ✅ Tạo SSAS Cube
3. ✅ Viết MDX queries
4. ✅ Build OLAP reports

### Phase 3: Data Mining (2 tuần)
1. ✅ Chuẩn bị & EDA
2. ✅ Train 3 models
3. ✅ Evaluate & compare
4. ✅ Deploy best model

### Phase 4: Integration & Deployment (1 tuần)
1. ✅ Tích hợp predictions vào SSAS
2. ✅ Tạo KPIs & dashboards
3. ✅ Testing & optimization
4. ✅ Documentation

---

## 📖 Hướng Dẫn Sử Dụng

### Thứ tự chạy project:

1. **Data Warehouse:** chạy `02_data_warehouse_sql/SQL_AIRBNB.sql` trên SQL Server để tạo database và các bảng.
2. **ETL:** mở `03_etl_ssis/AirBnB.sln` bằng Visual Studio (SSIS), chỉnh connection về SQL Server của bạn, trỏ Flat File Source tới `01_data/listings_ready_change.csv`, rồi chạy `Package.dtsx`.
3. **OLAP:** mở `04_olap_ssas/SSAS_AIRBNB.sln` bằng Visual Studio (SSAS), cập nhật data source, rồi Deploy và Process cube.
4. **Báo cáo:** mở `05_powerbi/PowerBI_OLAP.pbix` bằng Power BI Desktop.
5. **Data Mining:** xem kết quả các mô hình trong thư mục `06_data_mining/`.

### Sử Dụng SSAS Queries:

```sql
-- Ví dụ MDX query
SELECT
  NON EMPTY [Dimensions].[Location].[Location].Members ON ROWS,
  NON EMPTY [Measures].[Predicted Revenue] ON COLUMNS
FROM [AirbnbLA]
WHERE [Model] = 'XGBoost'
```

---

## 🎓 Kỳ Vọng Kết Quả

Sau khi triển khai thành công:

 **Dự đoán chính xác** doanh thu & Superhost status với độ chính xác 80-90%

 **Xác định rõ ràng** 5-10 đặc trưng quan trọng nhất ảnh hưởng đến doanh thu

 **Cung cấp insight** cho chủ sở hữu để tối ưu hóa chiến lược kinh doanh

 **Hỗ trợ quyết định** nâng cấp hoặc điều chỉnh giá phòng

 **Phát hiện xu hướng** thị trường Airbnb Los Angeles

---

## 📞 Liên Hệ & Hỗ Trợ

Nếu có câu hỏi hoặc cần hỗ trợ, vui lòng liên hệ:

| Người | Email | Chức năng |
|------|-------|---------|
| Huỳnh Trần Anh Thư | anh.thư@student.edu | Nhân viên chính |

---

## 📄 Giấy phép

Dự án này được phát triển cho mục đích giáo dục tại Trường CNTT, Đại học HCM.

---

##  Kết Luận

Đồ án này demonstrate một **hệ thống phân tích dữ liệu toàn diện** từ Data Warehouse, OLAP, cho đến Machine Learning. Việc kết hợp 3 mô hình khác nhau không chỉ giúp đạt được độ chính xác cao mà còn cung cấp **nhiều góc nhìn khác nhau** về dữ liệu, giúp phát hiện những mối quan hệ phức tạp.

Các insights từ Feature Importance cho thấy **host_response_rate**, **review_scores_rating**, và **host_acceptance_rate** là những yếu tố then chốt để trở thành Superhost trên Airbnb Los Angeles. Chủ sở hữu nên tập trung vào:
- Phản hồi nhanh chóng các yêu cầu
- Duy trì điểm đánh giá cao
- Chấp nhận hợp lý các yêu cầu từ khách

---

**Cập nhật lần cuối:** 20 tháng 5, 2026

**Status:**  Hoàn thành & Ready for Deployment
