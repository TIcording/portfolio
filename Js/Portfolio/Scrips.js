// 1번문제
const con = document.querySelector(".navbar__menu");
const ba = document.querySelector(".navbar__toggle-btn");
function open() {
    if (con.style.display == 'none') {
        con.style.display = 'flex';
    } else {
        con.style.display = 'none';
    }
    window.onresize = function () {
        document.location.reload();
    };
}
ba.addEventListener('click', open)
// 2번
//스크롤이 들어간 경우
const lis = document.querySelectorAll(".navbar__menu__item");
const sections = document.querySelectorAll("section");
const text = [];
for (let i in lis) {
    text.push(lis[i].textContent)
}
for (let li of lis) {
    const i = Array.from(lis).indexOf(li);
    li.innerHTML = `<a href="#${sections[i].id}">${text[i]}</a>`;
    //누른 위치로 이동
    const link = li.querySelector('a');
    link.addEventListener('click', (event) => {
        // 부드럽게 이동하게 하기 위해 설정
        event.preventDefault();
        const targetSection = document.querySelector(link.getAttribute('href'));
        // 누르는 버튼의 흰색 테두리 선정
        li.addEventListener('click', () => {
            lis.forEach(li => {
                li.classList.remove("active");
            })
            li.classList.add("active");
        })
        targetSection.scrollIntoView({
            behavior: 'smooth'
        });
    });
}
// 3번
// 탭에 맞춰 해당하는
const list_of_project = ['all', 'front_end', 'back_end', 'AI']
const count_of_project = { 'all': 0, 'front_end': 0, 'back_end': 0, 'AI': 0 }
const project = document.querySelectorAll('.project')
const button = document.getElementsByClassName('category__btn');
// event 넣기
for (p of project) {
    p.addEventListener('mouseover', all_project(p))
}
// 개수 계산하기
function all_project(p) {
    const cl_list = p.classList
    for (let i = 1; i < list_of_project.length; i++) {
        if (cl_list.contains(`${list_of_project[i]}`)) {
            count_of_project['all'] += 1
            count_of_project[list_of_project[i]] += 1
        }
    }
    const num = document.getElementsByClassName('category__count')
    for (let i in num) {
        num[i].innerHTML = `${count_of_project[list_of_project[i]]}`
    }
}
// 숫자 보이게 하기
for (let number of button) {
    const count = number.getElementsByClassName('category__count')[0];
    number.addEventListener('mouseover', () => {
        count.style.opacity = 1;
    });
    number.addEventListener('mouseout', () => {
        count.style.opacity = 0;
    });
}
// 눌렀을 때 해당하는 것만 보이게 하기
for (let i = 0; i < button.length; i++) {
    button[i].addEventListener('click', function () {
        hide_and_seek(i);
    });
}
function hide_and_seek(num) {
    const projects = document.getElementsByClassName('project');
    for (let i = 0; i < projects.length; i++) {
        if (!projects[i].classList.contains(list_of_project[num])) {
            projects[i].style.display = 'none';
        } else {
            projects[i].style.display = 'flex';
        }
    }
}

//4번문제
const arrow = document.querySelector('.arrow-up');
const home = document.getElementById('home');
document.addEventListener('scroll', movetop);
function movetop() {
    if (window.scrollY > home.offsetHeight) {
        arrow.classList.add('visible');
    } else {
        arrow.classList.remove('visible');
    }
}
arrow.addEventListener('click', () => {
    home.scrollIntoView({ behavior: 'smooth' });
});

// 2번 스크롤 기능
window.addEventListener('scroll', function () {
    const posY = this.window.pageYOffset;
    const home = this.document.querySelector('#home').getBoundingClientRect().top;
    const about = this.document.querySelector('#about').getBoundingClientRect().top;
    const skills = this.document.querySelector('#skills').getBoundingClientRect().top;
    const work = this.document.querySelector('#work').getBoundingClientRect().top;
    const testimonials = this.document.querySelector('#testimonials').getBoundingClientRect().top;
    const contact = this.document.querySelector('#contact').getBoundingClientRect().top;
    const homeTop = posY + home;
    const aboutTop = posY + about - navbar.offsetHeight*2;
    const skillsTop = posY + skills - navbar.offsetHeight*2;
    const workTop = posY + work - navbar.offsetHeight*2;
    const testimonialsTop = posY + testimonials - navbar.offsetHeight*2;
    const contactTop = posY + contact - navbar.offsetHeight*2
    const menus = document.querySelectorAll('.navbar__menu__item');
    const home__menu = document.getElementById('navbar__menu1');
    const about__menu = document.getElementById('navbar__menu2');
    const skills__menu = document.getElementById('navbar__menu3');
    const work__menu = document.getElementById('navbar__menu4');
    const chuchun__menu = document.getElementById('navbar__menu5');
    const contact__menu = document.getElementById('navbar__menu6');
    let totalHeight = document.body.scrollHeight - this.window.innerHeight - 1;
    if (posY >=0 && (posY >= homeTop) && (posY < aboutTop)) {
        menus.forEach(m => m.classList.remove('active'));
        home__menu.classList.add('active');
    } else if ((posY >= aboutTop) && (posY < skillsTop)) {
        menus.forEach(m => m.classList.remove('active'));
        about__menu.classList.add('active');
    } else if ((posY >= skillsTop) && (posY < workTop)) {
        menus.forEach(m => m.classList.remove('active'));
        skills__menu.classList.add('active');
    } else if ((posY >= workTop) && (posY < testimonialsTop)) {
        menus.forEach(m => m.classList.remove('active'));
        work__menu.classList.add('active');
    } else if (posY >= testimonialsTop && posY < contactTop) {
        menus.forEach(m => m.classList.remove('active'));
        chuchun__menu.classList.add('active');
    } else if (posY >= contactTop && posY <= totalHeight) {
        menus.forEach(m => m.classList.remove('active'));
        contact__menu.classList.add('active');
    }else {
    }
});