document.addEventListener('DOMContentLoaded', function() {
    const profileForm = document.getElementById('profile-form');

    if (profileForm) {
        profileForm.addEventListener('submit', function(e) {
            e.preventDefault();
            // Logic xử lý gửi dữ liệu về Server (Spring Boot) ở đây
            alert('Thông tin của bạn đã được cập nhật thành công!');
        });
    }

    // Hiệu ứng hover cho sidebar nếu cần thêm
    const menuItems = document.querySelectorAll('.sidebar-menu .list-group-item');
    menuItems.forEach(item => {
        item.addEventListener('mouseenter', () => {
            if(!item.classList.contains('active')) {
                item.style.color = '#000';
            }
        });
    });
});