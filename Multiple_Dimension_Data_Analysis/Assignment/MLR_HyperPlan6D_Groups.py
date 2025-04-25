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

# Load datasets
physical_file_path = r"C:\Users\DungNguyen\Documents\Multiple_Dimension_Data_Analysis\Assignment\rice_physical.xlsx"
spectrum_file_path = r"C:\Users\DungNguyen\Documents\Multiple_Dimension_Data_Analysis\Assignment\rice_spectrum.xlsx"

df_physical = pd.read_excel(physical_file_path, sheet_name="Sheet1")
df_spectrum = pd.read_excel(spectrum_file_path, sheet_name="Sheet1")

# Chọn biến
target = "Starch"
physico_chemical = ["Moisture", "Protein", "Lipid", "Ash", "Amylose", "Moisture", "Length", "Height", "Whiteness", "L", "a", "b"]
spectral_columns = [col for col in df_spectrum.columns if col.startswith("Water_")]

# Chuẩn bị dữ liệu
X_phy = df_physical[physico_chemical]
X_spec = df_spectrum[spectral_columns]
y = df_physical[target]

# Xử lý NaN trong dữ liệu quang phổ
X_spec = df_spectrum[spectral_columns]
if X_spec.isnull().values.any():
    print("Dữ liệu quang phổ chứa giá trị NaN. Đang xử lý...")
    X_spec = X_spec.fillna(X_spec.mean())  # Thay thế NaN bằng giá trị trung bình của từng cột

# PCA cho dữ liệu quang phổ
pca = PCA(n_components=0.95)  # Giữ 95% phương sai
X_pca = pca.fit_transform(X_spec)

print(f"Số chiều ban đầu của spectral data: {X_spec.shape[1]}")
print(f"Số chiều sau PCA: {X_pca.shape[1]}")

# Kết hợp dữ liệu (bao gồm cả biến hóa lý và PCA)
X_combined = np.concatenate([X_phy, X_pca], axis=1)
# X_combined = np.concatenate([X_phy], axis=1)

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

# Replace the current radio buttons creation with fig.add_axes so that they are drawn in the same figure:
ax_radio = fig.add_axes([0.01, 0.5, 0.15, 0.3])  # Using fig.add_axes to attach radio buttons to the main figure
radio = RadioButtons(ax_radio, [
    "Moisture-Protein-Starch",
    # "PCA1-PCA2-PCA3",
    # "PCA1-PCA2-PCA4",
    # "PCA1-PCA3-PCA4",
    # "PCA2-PCA3-PCA4"
])

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

# Lưu biểu đồ vào file (tùy chọn)
# plt.savefig("3d_full_regression_plane_with_options.png", dpi=300)

# Hiển thị đồ thị
plt.show()
