#!/bin/bash

# Lấy danh sách các máy chủ từ file Vagrantfile (thư mục hiện tại)
VAGRANT_MACHINES=$(vagrant status | awk '/running/{print $1}')

# Kiểm tra nếu không có máy chủ nào chạy
if [ -z "$VAGRANT_MACHINES" ]; then
  echo "Không có máy chủ Vagrant nào đang chạy."
  exit 1
fi

# Hiển thị danh sách máy chủ
echo "Danh sách máy chủ Vagrant đang chạy:"
i=1
declare -A MACHINES

for MACHINE in $VAGRANT_MACHINES; do
  MACHINES[$i]=$MACHINE
  echo "$i) $MACHINE"
  i=$((i + 1))
done

# Yêu cầu người dùng chọn máy chủ
echo -n "Vui lòng chọn số tương ứng với máy chủ bạn muốn SSH vào: "
read -r SELECTION

# Kiểm tra xem lựa chọn có hợp lệ không
if [[ ! $SELECTION =~ ^[0-9]+$ ]] || [[ -z "${MACHINES[$SELECTION]}" ]]; then
  echo "Lựa chọn không hợp lệ."
  exit 1
fi

# SSH vào máy chủ được chọn
SELECTED_MACHINE=${MACHINES[$SELECTION]}
echo "Đang kết nối tới $SELECTED_MACHINE..."
vagrant ssh "$SELECTED_MACHINE"

