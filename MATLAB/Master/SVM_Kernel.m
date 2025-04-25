function SVM_Kernel_res = SVM_Kernel(x1, x2)
    SVM_Kernel_res = [1, x1^2, sqrt(2) * x1 * x2, x2^2, sqrt(2) * x1, sqrt(2) * x2];
end