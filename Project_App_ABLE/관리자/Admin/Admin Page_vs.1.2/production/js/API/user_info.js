// 데이터베이스 연결
import { db } from "../../../../Server/db/database";

// HTML 템플릿에 동적으로 데이터 추가
(async function() {
  try {
    const userTableBody = document.getElementById('userTableBody');

    // 데이터베이스에서 사용자 정보 가져오기
    const [rows] = await db.query('SELECT * FROM User_info');

    rows.forEach(user => {
      const row = document.createElement('tr');

      const idCell = document.createElement('td');
      idCell.textContent = user.ui_idx;
      row.appendChild(idCell);

      const nameCell = document.createElement('td');
      nameCell.textContent = user.ui_name;
      row.appendChild(nameCell);

      const usernameCell = document.createElement('td');
      usernameCell.textContent = user.ui_userid;
      row.appendChild(usernameCell);

      const phoneCell = document.createElement('td');
      phoneCell.textContent = user.ui_hp;
      row.appendChild(phoneCell);

      const regDateCell = document.createElement('td');
      regDateCell.textContent = user.ui_regdate;
      row.appendChild(regDateCell);

      const actionsCell = document.createElement('td');
      const editButton = document.createElement('button');
      editButton.textContent = '수정';
      editButton.classList.add('btn', 'btn-primary');
      editButton.style.width = '150px';
      editButton.style.height = '40px';
      const editLink = document.createElement('a');
      editLink.href = 'form_advanced.html';
      editLink.appendChild(editButton);
      actionsCell.appendChild(editLink);
      row.appendChild(actionsCell);

      userTableBody.appendChild(row);
    });
  } catch (error) {
    console.error('데이터베이스 오류:', error);
  }
})();
