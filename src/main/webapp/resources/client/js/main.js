// Shared utility functions

function showToast(message, type) {
    var toastId = 'toast_' + Date.now();
    var toastHTML = '<div id="' + toastId + '" class="toast-notification toast-' + type + '">' +
                   '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + ' me-2"></i>' +
                   message + '</div>';
    var container = document.getElementById('toast-container');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toast-container';
        container.style.position = 'fixed';
        container.style.top = '80px';
        container.style.right = '20px';
        container.style.zIndex = '9999';
        document.body.appendChild(container);
    }
    container.insertAdjacentHTML('beforeend', toastHTML);
    var toastElement = document.getElementById(toastId);
    // Auto remove after 3 seconds
    setTimeout(function() {
        toastElement.classList.add('fade-out');
        setTimeout(function() { toastElement.remove(); }, 300);
    }, 3000);
}
