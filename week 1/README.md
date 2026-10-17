# 📘 Báo Cáo Tuần 1 — Kiến Trúc Máy Tính (MIPS với MARS)

> **Sinh viên:** Nguyễn Quang Thịnh — **MSSV:** 25112108
> **Repo:** [codekhongdo/computer-architechture](https://github.com/codekhongdo/computer-architechture)
> **Thư mục:** `week 1/`

Báo cáo tổng hợp kết quả thực hành Tuần 1: làm quen MIPS, dịch biểu thức C sang Assembly, mã hóa/giải mã mã máy, và kiểm chứng trên phần mềm MARS.

## 1. Cấu trúc thư mục `week 1/`

```text
week 1/
├── README.md              <- file này: giới thiệu chung báo cáo tuần 1
├── lab1.asm               <- Bài 4.1: f = (g + h) - (i + j)
├── lab2.asm               <- Bài 4.4: mã hóa / giải mã lệnh R-type & I-type
└── bai_tap_viet_tay/
    └── bài 4.4.jpg        <- ảnh bài tập tính tay mã máy
```

| File / Folder | Nội dung | Báo cáo chi tiết (Issue) |
|---|---|---|
| `lab1.asm` | Bài **4.1**: dịch `f = (g+h)-(i+j)` sang MIPS | [#2 — 4.1-report](https://github.com/codekhongdo/computer-architechture/issues/2) |
| `lab2.asm` | Bài **4.4**: kiểm chứng mã máy `add / lw / sw` | [#1 — 4.4-report](https://github.com/codekhongdo/computer-architechture/issues/1) |
| `bai_tap_viet_tay/` | Bài tập viết tay (giấy) | Ảnh `bài 4.4.jpg` |

> **Ghi chú tên:** theo yêu cầu đề bài bạn ghi `lab2.asm là bài 4.4, báo cáo là issue 4.2-report` — thực tế trên repo issue là `4.4-report (#1)`. README này link đúng issue #1.

## 2. Bài 4.1 — `lab1.asm` + Issue [#2 4.1-report](https://github.com/codekhongdo/computer-architechture/issues/2)

**Đề bài:** Cho ánh xạ thanh ghi: `f:$s0, g:$s1, h:$s2, i:$s3, j:$s4`. Viết MIPS cho `f = (g + h) - (i + j)`.

**Lời giải 3 lệnh cốt lõi (trong `lab1.asm`):**

```assembly
add $t1, $s1, $s2  # $t1 = g + h
add $t2, $s3, $s4  # $t2 = i + j
sub $s0, $t1, $t2  # f = (g+h) - (i+j)
```

Giải thích thay đổi thanh ghi từng bước:
1. `add $t1,$s1,$s2` → `$t1` bị ghi đè = `g+h`.
2. `add $t2,$s3,$s4` → `$t2` bị ghi đè = `i+j`.
3. `sub $s0,$t1,$t2` → `$s0` (=f) nhận hiệu số.

File `lab1.asm` còn có đoạn test với `g=10, h=20, i=3, j=5` → `f=22`, in ra bằng syscall `li $v0,1`.

**Câu hỏi suy nghĩ:** *Vì sao phải `lw` đọc lại từ bộ nhớ trước khi in dù giá trị vẫn còn trong thanh ghi?*
→ Để kiểm chứng `sw` đã ghi đúng RAM chưa. In trực tiếp từ thanh ghi chỉ chứng minh tính toán đúng, còn `lw` lại mới xác nhận thao tác lưu trữ thành công.

**Kiểm chứng MARS:** Issue #2 đính kèm 4 bộ giá trị + 5 ảnh screenshot Text Segment / Run I/O. Xem đầy đủ tại [4.1-report](https://github.com/codekhongdo/computer-architechture/issues/2).

## 3. Bài 4.4 — `lab2.asm` + Issue [#1 4.4-report](https://github.com/codekhongdo/computer-architechture/issues/1)

**Đề bài:** Mã hóa / giải mã tay + kiểm chứng bằng MARS.

| Ý | Lệnh / Mã máy | Kết quả |
|---|---|---|
| (a) | `add $s0, $s1, $s2` | `0x02328020` |
| (b) | `lw $t0, 8($s1)` | `0x8E280008` |
| (c) | `0xAE48000C` | `sw $t0, 12($s2)` |

**File kiểm chứng `lab2.asm`:**

```assembly
.text
main:
add $s0, $s1, $s2  # Bai 4.4 y (a)
lw $t0, 8($s1)     # Bai 4.4 y (b)
sw $t0, 12($s2)    # Bai 4.4 y (c)
```

Assemble trên MARS → cột `Code` ở Text Segment hiển thị đúng `02328020 / 8e280008 / ae48000c`, khớp tính tay 100%. Ảnh minh chứng trong [4.4-report](https://github.com/codekhongdo/computer-architechture/issues/1).

## 4. Bài tập viết tay — `bai_tap_viet_tay/`

Folder chứa bài làm giấy chụp lại:

- `bài 4.4.jpg` (82KB): tính tay chi tiết các trường `op / rs / rt / rd / shamt / funct` (R-type) và `op / rs / rt / offset` (I-type) cho bài 4.4, là cơ sở đối chiếu với kết quả MARS ở mục 3.

> Xem ảnh: [`week 1/bai_tap_viet_tay/bài 4.4.jpg`](./bai_tap_viet_tay/bài%204.4.jpg)

## 5. Cách chạy lại trên MARS

1. Mở MARS → `File > Open` → chọn `week 1/lab1.asm` hoặc `lab2.asm`.
2. `Run > Assemble (F3)` → kiểm tra Text Segment (cột Code/Basic).
3. `Run > Go (F5)` → xem Run I/O (lab1 in ra `f`).
4. Đối chiếu với bảng trong Issue #1, #2.

---
*Tổng kết: Tuần 1 hoàn thành 2 bài lab MIPS cơ bản + 1 bài viết tay, tất cả đã có mã nguồn `.asm`, tính toán tay và ảnh kiểm chứng MARS.*
