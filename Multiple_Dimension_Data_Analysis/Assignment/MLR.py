import os
import pandas as pd
import numpy as np
import openpyxl
from sklearn.decomposition import PCA
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # Import 3D plotting tools

# Load datasets
physical_file_path = r"C:\Users\DungNguyen\Documents\Multiple_Dimension_Data_Analysis\Assignment\rice_physical.xlsx"
spectrum_file_path = r"C:\Users\DungNguyen\Documents\Multiple_Dimension_Data_Analysis\Assignment\rice_spectrum.xlsx"

df_physical = pd.read_excel(physical_file_path, sheet_name="Sheet1")
df_spectrum = pd.read_excel(spectrum_file_path, sheet_name="Sheet1")

# Chọn biến
target = "Starch"
physico_chemical = ["Moisture", "Protein"]
spectral_columns = [col for col in df_spectrum.columns if col.startswith("Water_") or col.startswith("Etanol_")]

# Chuẩn bị dữ liệu
X_phy = df_physical[physico_chemical]
X_spec = df_spectrum[spectral_columns]
y = df_physical[target]

# PCA cho dữ liệu quang phổ
pca = PCA(n_components=0.95)  # Giữ 95% phương sai
X_pca = pca.fit_transform(X_spec)

print(f"Số chiều ban đầu của spectral data: {X_spec.shape[1]}")
print(f"Số chiều sau PCA: {X_pca.shape[1]}")

# Kết hợp dữ liệu
X_combined = np.concatenate([X_phy, X_pca], axis=1)

# Sử dụng toàn bộ dữ liệu để huấn luyện và kiểm tra
X_train, y_train = X_combined, y  # Không chia dữ liệu
X_test, y_test = X_combined, y  # Sử dụng toàn bộ dữ liệu để kiểm tra

# Huấn luyện mô hình
model = LinearRegression()
model.fit(X_train, y_train)

# In phương trình hồi quy
print("Phương trình hồi quy:")
print(f"y = {model.intercept_:.4f}", end="")
for i, coef in enumerate(model.coef_):
    print(f" + ({coef:.4f}) * x{i + 1}", end="")
print()  # Xuống dòng sau khi in phương trình

# Dự đoán và đánh giá
y_pred = model.predict(X_test)
r2 = r2_score(y_test, y_pred)
rmse = np.sqrt(mean_squared_error(y_test, y_pred))

print(f"R²: {r2:.4f}")
print(f"RMSE: {rmse:.4f}")
print("Hệ số hồi quy lớn nhất:", np.max(np.abs(model.coef_)))

# Sử dụng một biến hóa lý và hai principal components cho biểu đồ 3D
feature_1 = X_phy["Moisture"].values  # Biến hóa lý "Moisture"
feature_2 = X_pca[:, 0]  # First principal component
feature_3 = X_pca[:, 1]  # Second principal component

# Sử dụng Moisture, Protein, PCA (PC1, PC2, PC3, PC4), Starch Measured, và Starch Predict
moisture = X_phy["Moisture"].values  # Biến hóa lý "Moisture"
protein = X_phy["Protein"].values  # Biến hóa lý "Protein"
pca_1 = X_pca[:, 0]  # First principal component
pca_2 = X_pca[:, 1]  # Second principal component
pca_3 = X_pca[:, 2] if X_pca.shape[1] > 2 else np.zeros_like(pca_1)  # Third principal component
pca_4 = X_pca[:, 3] if X_pca.shape[1] > 3 else np.zeros_like(pca_1)  # Fourth principal component
starch_measured = y_test.values  # Giá trị thực tế
starch_predict = y_pred  # Giá trị dự đoán

# Ensure starch_measured and starch_predict contain valid, non-negative values
starch_measured = np.maximum(starch_measured, 0)  # Replace negative values with 0
starch_predict = np.maximum(starch_predict, 0)  # Replace negative values with 0

# Tạo biểu đồ 3D với PCA và phân biệt giữa Starch Measured và Starch Predict
fig = plt.figure(figsize=(12, 10))
ax = fig.add_subplot(111, projection='3d')

# Vẽ các điểm dữ liệu kiểm tra (giá trị thực tế)
sc1 = ax.scatter(moisture[len(y_train):], protein[len(y_train):], starch_measured,
                 c=pca_1[len(y_train):], cmap='Blues', alpha=0.7, label="Measured Data", marker='o')

# Vẽ các điểm dữ liệu kiểm tra (giá trị dự đoán)
sc2 = ax.scatter(moisture[len(y_train):], protein[len(y_train):], starch_predict,
                 c=pca_2[len(y_train):], cmap='Oranges', alpha=0.7, label="Predicted Data", marker='^')

# Thêm thanh màu để biểu diễn PCA
cbar1 = plt.colorbar(sc1, ax=ax, pad=0.1, location='left')
cbar1.set_label("Principal Component 1 (Color)")

cbar2 = plt.colorbar(sc2, ax=ax, pad=0.1, location='right')
cbar2.set_label("Principal Component 2 (Color)")

# Đặt nhãn và tiêu đề
ax.set_xlabel("Moisture (Physico-chemical Feature)")
ax.set_ylabel("Protein (Physico-chemical Feature)")
ax.set_zlabel("Starch Content")
ax.set_title("3D Visualization: PCA (PC3, PC4), Starch Measured vs Predicted")

# Hiển thị chú thích
ax.legend()

# Lưu biểu đồ vào file (tùy chọn)
plt.savefig("3d_pca_measured_vs_predicted_updated.png", dpi=300)

# Hiển thị biểu đồ
plt.show()
