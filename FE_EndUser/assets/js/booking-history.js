document.addEventListener('DOMContentLoaded', function() {
    console.log("Booking History Page Loaded");
    
    // Ví dụ xử lý nút Lọc
    const filterBtn = document.querySelector('.btn-outline-dark');
    if(filterBtn) {
        filterBtn.addEventListener('click', function() {
            alert('Tính năng lọc đang được phát triển!');
        });
    }
});