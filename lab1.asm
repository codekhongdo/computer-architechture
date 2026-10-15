.text
main:
addi $s1, $zero, 10 # g = 10 (gia tri thu)
addi $s2, $zero, 20 # h = 20
addi $s3, $zero, 3 # i = 3
addi $s4, $zero, 5 # j = 5
# ------- LOI GIAI BAI 4.1 CUA EM: viet vao day -------
add $t1,$s1,$2 #Bước 1 - Lệnh add $t1, $s1, $s2: Thanh ghi $t1 thay đổi. Nó được ghi đè bằng tổng giá trị của $s1 và $s2 (tức là g + h).
add $t2,$s3,$s4 #Bước 2 - Lệnh add $t2, $s3, $s4: Thanh ghi $t2 thay đổi. Nó được ghi đè bằng tổng giá trị của $s3 và $s4 (tức là i + j).
sub $s0,$t1,$t2 #Bước 3 - Lệnh sub $s0,$t1,$t2: Thanh ghi $s0 thay đổi. Nó nhận kết quả của phép trừ giá trị trong $t1 khỏi $t2. Đây chính là giá trị của $s0

# -----------------------------------------------------
move $a0, $s0    # in f
li   $v0, 1
syscall
li   $v0, 10
syscall
#Mục đích chính của việc dùng lệnh lw đọc lại giá trị từ bộ nhớ là để kiểm tra xem lệnh sw trước đó đã ghi dữ liệu vào đúng địa chỉ RAM hay chưa.
#Nếu chỉ in trực tiếp từ thanh ghi,mới chỉ chứng minh được phép toán tính đúng, chứ chưa xác nhận được thao tác lưu trữ dữ liệu vào bộ nhớ đã thành công.

