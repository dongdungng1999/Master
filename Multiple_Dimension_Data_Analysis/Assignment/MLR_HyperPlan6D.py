import os
import pandas as pd
import numpy as np
import openpyxl
from sklearn.decomposition import PCA
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score, mean_squared_error
from sklearn.preprocessing import StandardScaler  # ADDED IMPORT
from scipy.signal import savgol_filter, detrend  # Import thêm các công cụ xử lý tín hiệu
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # Import 3D plotting tools
from matplotlib.widgets import Button, RadioButtons  # Import Button and RadioButtons widgets
import textwrap  # Import thêm thư viện textwrap để xử lý xuống dòng
# Load dataset
file_path = r"C:\Users\DungNguyen\Documents\Multiple_Dimension_Data_Analysis\Assignment\rice.xlsx"
df = pd.read_excel(file_path, sheet_name="Sheet1")

# Chọn biến
target = "Starch"
physico_chemical = ["Moisture", "Protein", "Lipid", "Ash", "Amylose", "Moisture", "Length", "Height", "Whiteness"]
spectral_water = [col for col in df.columns if col.startswith("Water_")]
spectral_etanol = [col for col in df.columns if col.startswith("Etanol_")]

# Chuẩn bị dữ liệu
X_phy = df[physico_chemical]
X_spec = df[spectral_water]  # Hoặc spectral_etanol tùy chọn
y = df[target]

# # Bước 1: Kiểm tra dữ liệu phổ
# # Vẽ đồ thị quang phổ trung bình
# mean_spectrum = X_spec.mean(axis=0)
# plt.figure(figsize=(10, 6))
# plt.plot(mean_spectrum, label="Mean Spectrum")
# plt.title("Mean Spectrum of All Samples")
# plt.xlabel("Wavelength Index")
# plt.ylabel("Absorbance")
# plt.legend()
# plt.show()

# Kiểm tra các giá trị bất thường (outliers)
absorption_mean = X_spec.mean(axis=0)
absorption_std = X_spec.std(axis=0)
threshold_high = absorption_mean + 3 * absorption_std
threshold_low = absorption_mean - 3 * absorption_std
outliers = (X_spec > threshold_high) | (X_spec < threshold_low)
outlier_indices = np.where(outliers.any(axis=1))[0]
if len(outlier_indices) > 0:
    print(f"Phát hiện {len(outlier_indices)} mẫu có giá trị bất thường:")
    print(f"Các chỉ số mẫu bất thường: {outlier_indices}")
else:
    print("Không phát hiện giá trị bất thường trong dữ liệu phổ.")
# Bước 2: Tiền xử lý dữ liệu phổ
# Loại bỏ nhiễu (Smoothing) bằng Savitzky-Golay filter
window_length = 7  # Chiều dài cửa sổ (phải là số lẻ)
polyorder = 2  # Bậc đa thức
X_spec_smoothed = savgol_filter(X_spec, window_length=window_length, polyorder=polyorder, axis=0)

# Chuẩn hóa (Normalization) bằng z-score
X_spec_normalized = (X_spec_smoothed - X_spec_smoothed.mean(axis=0)) / X_spec_smoothed.std(axis=0)

# Loại bỏ nền (Baseline Correction) bằng detrend
X_spec_corrected = detrend(X_spec_normalized, axis=0)

# Chọn vùng phổ quan trọng (ví dụ: 300-700 nm)
important_columns = [col for col in X_spec.columns if 200 <= int(col.split('_')[-1]) <= 1000]
X_spec_selected = pd.DataFrame(X_spec_corrected, columns=X_spec.columns)[important_columns]

# Recompute thresholds based on X_spec_selected to ensure alignment
# The line below calculates the column-wise mean of the selected spectral data stored in the DataFrame X_spec_selected.
absorption_mean_selected = X_spec_selected.mean(axis=0)
absorption_std_selected = X_spec_selected.std(axis=0)
threshold_high_selected = absorption_mean_selected + 3 * absorption_std_selected
threshold_low_selected = absorption_mean_selected - 3 * absorption_std_selected

# Loại bỏ các outliers vượt ngưỡng với các thresholds được căn chỉnh cho X_spec_selected
valid_indices = ~(((X_spec_selected > threshold_high_selected) | (X_spec_selected < threshold_low_selected)).any(axis=1))
X_spec_filtered = X_spec_selected[valid_indices]
y_filtered = y[valid_indices]

# Kiểm tra số lượng mẫu sau khi loại bỏ outliers
print(f"Số lượng mẫu ban đầu: {X_spec.shape[0]}")
print(f"Số lượng mẫu sau khi loại bỏ outliers: {X_spec_filtered.shape[0]}")
# # Bước 3: Kiểm tra sau tiền xử lý
# # Vẽ lại đồ thị quang phổ sau khi tiền xử lý
# mean_spectrum_processed = X_spec_selected.mean(axis=0)
# plt.figure(figsize=(10, 6))
# plt.plot(mean_spectrum, label="Original Mean Spectrum", linestyle="--")
# plt.plot(mean_spectrum_processed, label="Processed Mean Spectrum")
# plt.title("Comparison of Original and Processed Mean Spectrum")
# plt.xlabel("Wavelength Index")
# plt.ylabel("Absorbance")
# plt.legend()
# plt.show()

# PCA cho dữ liệu quang phổ
pca = PCA(n_components=0.98)  # Giữ 95% phương sai
X_pca = pca.fit_transform(X_spec_selected)

print(f"Số chiều ban đầu của spectral_water: {X_spec.shape[1]}")
print(f"Số chiều sau PCA: {X_pca.shape[1]}")

# Kết hợp dữ liệu (bao gồm cả biến hóa lý và PCA)
X_combined = np.concatenate([X_phy, X_pca], axis=1)

# Sử dụng toàn bộ dữ liệu để huấn luyện và kiểm tra
X_train, y_train = X_combined, y  # Không chia dữ liệu
X_test, y_test = X_combined, y  # Sử dụng toàn bộ dữ liệu để kiểm tra

# Apply standardization to features
# scaler = StandardScaler()
# X_train = scaler.fit_transform(X_train)
# X_test = scaler.transform(X_test)

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

# In hệ số hồi quy lớn nhất và biến x tương ứng
max_coef = np.max(model.coef_)
max_coef_index = np.argmax(model.coef_)  # Lấy chỉ số của hệ số hồi quy lớn nhất
print(f"Hệ số hồi quy lớn nhất: {max_coef:.4f}, tương ứng với x{max_coef_index + 1}")

# Tạo phương trình hồi quy đầy đủ
regression_equation = f"y = {model.intercept_:.4f}"
for i, coef in enumerate(model.coef_):
    regression_equation += f" + ({coef:.4f}) * x{i + 1}"

############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
##########################Visualization#####################################
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
