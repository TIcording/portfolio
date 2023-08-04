
function sendit(){
    const userid =document.getElementById("userid");
    const userpw = document.getElementById("userpw");
    const userpw_re = document.getElementById("userpw_re");
    const username = document.getElementById("username");
    const hp = document.getElementById("hp");
    const email = document.getElementById("email");
    const ssn1 = document.getElementById("ssn1");
    const ssn2 = document.getElementById("ssn2");

    //정규표현식
    //아이디 정규 표현식
    const expIdText = /^[A-Za-z]{4,20}$/; //ID
    //비밀번호 정규 표현식 과제
    const exPwText = /^[A-Za-z0-9]{6,20}$/; //비밀번호 
    //이름 정규표현식
    const exNameText =  /^[가-힣]{2,6}$/;
    //휴대폰 번호 정규 표현식
    const exPhoneText = /^\d{3}-\d{3,4}-\d{4}$/;
    //이메일 정규표현식
    const exEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9\-\.]+$/
    //주민등록번호 정규 표현식

    const exSsn1Text = /^[0-9]{6}$/
    const exSsn2Text = /^[0-9]{7}$/


    if(!expIdText.test(userid.value)){
        alert('아이디는 4~20자리로 입력해주세요.');
        userid.focus();
        return false;
    }
    if(userpw.value!= userpw_re.value){ // 다르면 true   
        alert('비밀번호가 일치하지 않습니다.');
        userpw.focus();
        return false;
    }
    if(!exNameText.test(username.value)){
        alert('이름는 2~6자리 한글로 입력해주세요.');
        username.focus();
        return false;

    }if(!exPhoneText.test(hp.value)){
        alert('휴대폰 번호를 다시 입력해주세요(-포함).');
        hp.focus();
        return false;

    }if(!exEmailText.test(email.value)){
        alert('이메일을 다시 입력해주세요.');
        email.focus();
        return false;
    }
    if(!exSsn1Text.test(ssn1.value)){
        alert('주민번호 앞자리는 6자리로 입력해주세요.');
        ssn1.focus();
        return false;
    }
    if(!exSsn2Text.test(ssn2.value)){
        alert('주민번호 뒷자리는 7자리로 입력해주세요.');
        ssn2.focus();
        return false;
    }

}

