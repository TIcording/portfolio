// 로그인 API 요청 함수
async function login() {
    const mi_userid = document.getElementById('id__input').value;
    const mi_password = document.getElementById('pw__input').value;

    // API 요청
    const response = await fetch('https://port-0-teamprojectadmin-jkg2alhqyguv1.sel4.cloudtype.app/manager/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ mi_userid, mi_password })
    });

    // 응답 처리
    if (response.ok) {
        // 로그인 성공
        const data = await response.json();
        const token = data.token;
        localStorage.setItem('token', token); // 토큰 저장
        
        // 메인 페이지로 리다이렉션
        window.location.href = '../../Admin%20Page_vs.1.2/production/index.html';   
        console.log('로그인 성공');
    } else {
        // 로그인 실패
        const errorData = await response.json();
        console.error('로그인 실패:', errorData.message);
    }
}


// 로그인 버튼 클릭 이벤트 핸들러 등록
const loginBtn = document.getElementById('login__btn');
loginBtn.addEventListener('click', login);

