// Add animation on scroll and delete confirm
document.addEventListener('DOMContentLoaded', function() {
    const observerOptions = { threshold: 0.1, rootMargin: '0px 0px -50px 0px' };
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all table rows
    document.querySelectorAll('tbody tr').forEach(row => {
        row.style.opacity = '0';
        row.style.transform = 'translateY(20px)';
        row.style.transition = 'all 0.5s ease';
        observer.observe(row);
    });

    // Confirm delete
    document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            const confirmed = confirm('⚠️ Bạn có chắc chắn muốn hủy đơn hàng này?\n\nĐơn hàng đã hủy không thể khôi phục.');
            if (!confirmed) { e.preventDefault(); }
        });
    });
});