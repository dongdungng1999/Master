import os
import pandas as pd
import numpy as np
import openpyxl
from sklearn.decomposition import PCA
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score, mean_squared_error
from sklearn.preprocessing import StandardScaler  # ADDED IMPORT
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # Import 3D plotting tools
from matplotlib.widgets import Button, RadioButtons  # Import Button and RadioButtons widgets
import textwrap  # Import thêm thư viện textwrap để xử lý xuống dòng
from scipy.signal import detrend  # Import thêm detrend để loại bỏ nền
import pybaselines  # Import pybaselines nếu cần loại bỏ nền đa thức

# Load dataset
file_path = r"C:\Users\DungNguyen\Documents\Multiple_Dimension_Data_Analysis\Assignment\rice.xlsx"
df = pd.read_excel(file_path, sheet_name="Sheet1")

# Chọn biến
target = "Starch"
physico_chemical = ["Moisture", "Protein", "Lipid", "Ash", "Amylose", "Moisture", "Length", "Height", "Whiteness", "L", "a", "b"]
spectral_water = [col for col in df.columns if col.startswith("Water_")]
spectral_etanol = [col for col in df.columns if col.startswith("Etanol_")]

# Chuẩn bị dữ liệu
X_phy = df[physico_chemical]
X_spec = df[spectral_water]  # Hoặc spectral_etanol tùy chọn
y = df[target]

# Loại bỏ nền (Baseline Correction)
def baseline_correction(data, method="linear", polyorder=2):
    if method == "linear":
        return detrend(data, axis=0)  # Loại bỏ nền tuyến tính
    elif method == "polynomial":
        corrected_data = np.zeros_like(data)
        for i in range(data.shape[1]):
            baseline = pybaselines.polynomial(data[:, i], polyorder=polyorder)[0]
            corrected_data[:, i] = data[:, i] - baseline
        return corrected_data
    else:
        raise ValueError("Phương pháp loại bỏ nền không hợp lệ. Chọn 'linear' hoặc 'polynomial'.")

# Áp dụng loại bỏ nền
baseline_method = "linear"  # Chọn phương pháp: "linear" hoặc "polynomial"
polyorder = 2  # Bậc đa thức nếu dùng phương pháp polynomial
X_spec_corrected = baseline_correction(X_spec.values, method=baseline_method, polyorder=polyorder)

# Chuyển đổi X_spec_corrected thành DataFrame để giữ nguyên các cột
X_spec_corrected = pd.DataFrame(X_spec_corrected, columns=X_spec.columns)

# Kiểm tra dữ liệu phổ sau khi loại bỏ nền
print("Dữ liệu phổ sau khi loại bỏ nền:")
print(X_spec_corrected.head())

# Chọn vùng phổ quan trọng (nếu cần)
important_wavelengths = [col for col in X_spec_corrected.columns if 400 <= int(col.split('_')[-1]) <= 700]
X_spec_selected = X_spec_corrected[important_wavelengths]

print(f"Số lượng bước sóng được chọn: {len(important_wavelengths)}")
print(f"Các bước sóng được chọn: {important_wavelengths}")

# Kiểm tra dữ liệu phổ để phát hiện outliers
absorption_mean = X_spec_selected.mean(axis=0)  # Tính trung bình theo từng cột
absorption_std = X_spec_selected.std(axis=0)  # Tính độ lệch chuẩn theo từng cột

# Xác định ngưỡng để phát hiện outliers (ví dụ: giá trị nằm ngoài 3 lần độ lệch chuẩn)
threshold_high = absorption_mean + 3 * absorption_std
threshold_low = absorption_mean - 3 * absorption_std

# Tìm các mẫu có giá trị vượt ngưỡng
outliers = (X_spec_selected > threshold_high) | (X_spec_selected < threshold_low)
outlier_indices = np.where(outliers.any(axis=1))[0]  # Lấy chỉ số của các mẫu có outliers

# In thông tin về các outliers
if len(outlier_indices) > 0:
    print(f"Phát hiện {len(outlier_indices)} mẫu có giá trị bất thường:")
    print(f"Các chỉ số mẫu bất thường: {outlier_indices}")
    print("Chi tiết các hàng bất thường:")
    print(X_spec_selected.iloc[outlier_indices])  # In chi tiết các hàng có giá trị bất thường
else:
    print("Không phát hiện giá trị bất thường trong dữ liệu phổ.")

# Loại bỏ các outliers vượt ngưỡng cao và thấp
valid_indices = ~((X_spec_selected > threshold_high).any(axis=1) | (X_spec_selected < threshold_low).any(axis=1))
X_spec_filtered = X_spec_selected[valid_indices]
y_filtered = y[valid_indices]

# Kiểm tra số lượng mẫu sau khi loại bỏ outliers
print(f"Số lượng mẫu ban đầu: {X_spec.shape[0]}")
print(f"Số lượng mẫu sau khi loại bỏ outliers: {X_spec_filtered.shape[0]}")

# PCA cho dữ liệu quang phổ sau khi loại bỏ nền và chọn vùng phổ
pca = PCA(n_components=0.99)  # Giữ 95% phương sai
X_pca = pca.fit_transform(X_spec_filtered)

print(f"Số chiều ban đầu của spectral_water: {X_spec_filtered.shape[1]}")
print(f"Số chiều sau PCA: {X_pca.shape[1]}")

# Kết hợp dữ liệu (bao gồm cả biến hóa lý và PCA)
X_combined = np.concatenate([X_phy[valid_indices], X_pca], axis=1)

# Sử dụng dữ liệu đã loại bỏ outliers để huấn luyện và kiểm tra
X_train, y_train = X_combined, y_filtered  # Không chia dữ liệu
X_test, y_test = X_combined, y_filtered  # Sử dụng toàn bộ dữ liệu để kiểm tra

# Huấn luyện mô hình với dữ liệu chuẩn hóa
model = LinearRegression()
model.fit(X_train, y_train)

# In phương trình hồi quy
print("Phương trình hồi quy:")
print(f"y = {model.intercept_:.4f}", end="")
for i, coef in enumerate(model.coef_):
    print(f" + ({coef:.4f}) * x{i + 1}", end="")
print()  # Xuống dòng sau khi in phương trình

# Dự đoán và đánh giá sử dụng dữ liệu chuẩn hóa
y_pred = model.predict(X_test)
r2 = r2_score(y_test, y_pred)
rmse = np.sqrt(mean_squared_error(y_test, y_pred))

print(f"R²: {r2:.4f}")
print(f"RMSE: {rmse:.4f}")
print("Hệ số hồi quy lớn nhất:", np.max(np.abs(model.coef_)))

# Tạo phương trình hồi quy đầy đủ
regression_equation = f"y = {model.intercept_:.4f}"
for i, coef in enumerate(model.coef_):
    regression_equation += f" + ({coef:.4f}) * x{i + 1}"

# Tạo lưới (meshgrid) cho các trục x và y (Moisture và Protein)
x_range = np.linspace(X_phy["Moisture"].min(), X_phy["Moisture"].max(), 10)
y_range = np.linspace(X_phy["Protein"].min(), X_phy["Protein"].max(), 10)
x_mesh, y_mesh = np.meshgrid(x_range, y_range)

# Đoạn khởi tạo biểu đồ ban đầu: xóa vẽ measured data, chỉ vẽ predicted data
fig = plt.figure(figsize=(12, 10))
ax = fig.add_subplot(111, projection='3d')

sc2 = ax.scatter(X_test[:, 0], X_test[:, 1], y_pred,
                 c='orange', alpha=0.7, label="Predicted Data", marker='^')

ax.plot_surface(x_mesh, y_mesh, model.intercept_ + model.coef_[0]*x_mesh + model.coef_[1]*y_mesh,
                color='green', alpha=0.3, label="Regression Plane")

ax.set_xlabel("Moisture (Physico-chemical Feature)")
ax.set_ylabel("Protein (Physico-chemical Feature)")
ax.set_zlabel("Starch Content")
ax.set_title("3D Visualization with MLR Model and Prediction")

# Thêm remark vào đồ thị
ax.text2D(0.05, 0.95, "Remark: Regression Hyperplane simulates 3 spatial dimensions (Moisture, Protein & the main Starch), other dimensions are hidden",
          transform=ax.transAxes, fontsize=10, color='blue', bbox=dict(facecolor='white', alpha=0.8))

# Đặt regression_info bên dưới các nút radio
ax_info = fig.add_axes([0.01, 0.3, 0.15, 0.15])  # Vị trí và kích thước của vùng thông tin
ax_info.axis("off")  # Tắt khung và trục
wrapped_regression_equation = "\n".join(textwrap.wrap(regression_equation, width=30))  # Tự động xuống dòng với độ rộng 30 ký tự
regression_info = (
    f"Regression Equation:\n{wrapped_regression_equation}\n"
    f"R² = {r2:.4f}\n"
    f"RMSE = {rmse:.4f}"
)
ax_info.text(0, 1, regression_info, fontsize=10, color='black', verticalalignment='top')
# Hiển thị chú thích
ax.legend()
# Hiển thị đồ thị
plt.show()
