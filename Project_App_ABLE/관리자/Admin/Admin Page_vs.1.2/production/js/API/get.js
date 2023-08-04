// 마이페이지 API 요청 함수
async function fetchMyPage() {
    const token = localStorage.getItem('token');
    console.log(token);
    if (!token) {
        // 토큰이 없을 경우, 즉 로그인하지 않은 상태
        console.log('로그인이 필요합니다.');
        window.location.href = './login.html'; // 로그인 페이지로 리다이렉션
        return;
    }

    // API 요청 및 응답 처리
    try {
        const response = await fetch('https://port-0-teamprojectadmin-jkg2alhqyguv1.sel4.cloudtype.app/auth/me', {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`
            }
        })

        if (response.ok) {
            // 응답이 성공적인 경우 사용자 정보 표시
            const data = await response.json();
            console.log(data);
            return data;
        } else {
            // 응답이 실패한 경우 오류 처리
            const errorData = await response.json();
            console.error('마이페이지 요청 실패:', errorData.message);
            // 오류 발생 시 로그인 페이지로 리다이렉션
            // window.location.href = '../../../Admin%20Page_vs.1.2/production/login.html';
        }
    } catch (error) {
        console.error('마이페이지 요청 중 오류 발생:', error);
        // 오류 발생 시 로그인 페이지로 리다이렉션
        // window.location.href = '../../../Admin%20Page_vs.1.2/production/login.html';
    }
}

// 마이페이지 접근 시 로그인 여부 확인
const isLoggedIn = localStorage.getItem('token') !== null;
console.log(isLoggedIn)
if (!isLoggedIn) {
    console.log('로그인이 필요합니다.');
    window.location.href = './login.html'; // 로그인 페이지로 리다이렉션
} else {
    fetchMyPage(); // 마이페이지 API 요청
}

const logoutButtons = document.querySelectorAll('#logout');
logoutButtons.forEach(button => {
    button.addEventListener('click', logout);
  });
  

// 로그아웃 함수
function logout() {
    // 로컬 스토리지에서 토큰 삭제
    localStorage.removeItem('token');

    // 로그인 페이지로 리다이렉션
    window.location.href = './login.html';
}

