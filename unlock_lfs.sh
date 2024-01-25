#!/bin/bash

# 현재 로그인한 사용자의 이름을 소문자로 변환하여 가져옵니다.
current_user=$(whoami | tr '[:upper:]' '[:lower:]')

# 현재 디렉토리가 Git 저장소인지 확인
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "This is not a Git repository."
    exit 1
fi

# 서버에서 잠긴 파일 목록을 가져와서 현재 사용자가 잠근 파일의 잠금 해제
git lfs locks | tail -n +2 | while read -r file_path lock_owner file_id rest; do
    # lock_owner를 소문자로 변환하여 대소문자를 무시하고 비교
    lock_owner=$(echo "$lock_owner" | tr '[:upper:]' '[:lower:]')
    if [[ "$lock_owner" == "$current_user" ]]; then
        echo "Unlocking file: $file_path..."
        git lfs unlock "$file_path"
    fi
done

echo "All LFS locks set by $current_user have been released."
