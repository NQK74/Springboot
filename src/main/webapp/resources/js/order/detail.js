
// Get CSRF token
var csrfToken = document.querySelector('input[name="_csrf"]') ? document.querySelector('input[name="_csrf"]').value : '';
var csrfHeader = 'X-CSRF-TOKEN';

// Show toast notification
function showToast(message, type) {
    type = type || 'success';
    var container = document.getElementById('toastContainer');
    var toast = document.createElement('div');
    toast.className = 'toast-notification toast-' + type;
    var iconClass = (type === 'success') ? 'fa-check-circle' : 'fa-exclamation-circle';
    toast.innerHTML = '<i class="fas ' + iconClass + '"></i><span>' + message + '</span>';
    container.appendChild(toast);
    
    // Auto remove after 3 seconds
    setTimeout(function() {
        toast.style.animation = 'slideOut 0.3s ease-out forwards';
        setTimeout(function() { toast.remove(); }, 300);
    }, 3000);
}

// Update status badge in header
function updateStatusBadge(status, label) {
    var badgeContainer = document.querySelector('.info-value .status-badge');
    if (badgeContainer) {
        var badgeClasses = {
            'PENDING': 'badge-pending',
            'CONFIRMED': 'badge-confirmed', 
            'SHIPPED': 'badge-shipped',
            'DELIVERED': 'badge-delivered',
            'CANCELLED': 'badge-cancelled'
        };
        var icons = {
            'PENDING': 'fa-clock',
            'CONFIRMED': 'fa-check-circle',
            'SHIPPED': 'fa-shipping-fast',
            'DELIVERED': 'fa-check-double',
            'CANCELLED': 'fa-times-circle'
        };
        badgeContainer.className = 'status-badge ' + (badgeClasses[status] || 'badge-pending');
        badgeContainer.innerHTML = '<i class="fas ' + (icons[status] || 'fa-clock') + '"></i> ' + label;
    }
}

// Update payment status badge
function updatePaymentBadge(status, label) {
    var paymentBadges = document.querySelectorAll('.card-body .info-value .status-badge');
    paymentBadges.forEach(function(badge) {
        var parent = badge.closest('.info-item');
        if (parent && parent.querySelector('.info-label i.fa-receipt')) {
            badge.className = (status === 'PAID') ? 'status-badge badge-delivered' : 'status-badge badge-pending';
            var icon = (status === 'PAID') ? 'fa-check-circle' : 'fa-clock';
            badge.innerHTML = '<i class="fas ' + icon + '"></i> ' + label;
        }
    });
}

// Update order status via AJAX
async function updateOrderStatus(event) {
    event.preventDefault();
    
    var orderId = document.getElementById('orderId').value;
    var status = document.getElementById('status').value;
    var btn = document.getElementById('statusBtn');
    var originalText = btn.innerHTML;
    
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang lưu...';
    btn.classList.add('btn-loading');
    btn.disabled = true;
    
    try {
        var response = await fetch('/api/admin/order/' + orderId + '/status', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': csrfToken
            },
            body: JSON.stringify({ status: status })
        });
        
        var data = await response.json();
        
        if (data.success) {
            showToast(data.message, 'success');
            updateStatusBadge(data.newStatus, data.statusLabel);
        } else {
            showToast(data.message || 'Có lỗi xảy ra!', 'error');
        }
    } catch (error) {
        console.error('Error:', error);
        showToast('Lỗi kết nối server!', 'error');
    } finally {
        btn.innerHTML = originalText;
        btn.classList.remove('btn-loading');
        btn.disabled = false;
    }
    
    return false;
}

// Update payment status via AJAX
async function updatePaymentStatus(event) {
    event.preventDefault();
    
    var orderId = document.getElementById('orderId').value;
    var paymentStatus = document.getElementById('paymentStatus').value;
    var btn = document.getElementById('paymentBtn');
    var originalText = btn.innerHTML;
    
    btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang lưu...';
    btn.classList.add('btn-loading');
    btn.disabled = true;
    
    try {
        var response = await fetch('/api/admin/order/' + orderId + '/payment-status', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': csrfToken
            },
            body: JSON.stringify({ paymentStatus: paymentStatus })
        });
        
        var data = await response.json();
        
        if (data.success) {
            showToast(data.message, 'success');
            updatePaymentBadge(data.newPaymentStatus, data.paymentStatusLabel);
        } else {
            showToast(data.message || 'Có lỗi xảy ra!', 'error');
        }
    } catch (error) {
        console.error('Error:', error);
        showToast('Lỗi kết nối server!', 'error');
    } finally {
        btn.innerHTML = originalText;
        btn.classList.remove('btn-loading');
        btn.disabled = false;
    }
    
    return false;
}
