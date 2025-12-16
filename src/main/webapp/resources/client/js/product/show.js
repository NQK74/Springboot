// Add to cart with AJAX
function addToCart(event, productId) {
    event.preventDefault();
    var token = document.querySelector('input[name="_csrf"]') ? document.querySelector('input[name="_csrf"]').value : 
                document.querySelector('meta[name="_csrf"]') ? document.querySelector('meta[name="_csrf"]').getAttribute('content') : '';
    var tokenHeader = document.querySelector('meta[name="_csrf_header"]') ? document.querySelector('meta[name="_csrf_header"]').getAttribute('content') : 'X-CSRF-TOKEN';
    if (!token) {
        var formElements = document.querySelectorAll('form');
        for (var i = 0; i < formElements.length; i++) {
            var csrfInput = formElements[i].querySelector('input[name="_csrf"]');
            if (csrfInput) { token = csrfInput.value; break; }
        }
    }
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/add-product-to-cart/' + productId, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    if (tokenHeader && token) { xhr.setRequestHeader(tokenHeader, token); }
    xhr.onload = function() {
        if (xhr.status === 200 || xhr.status === 0) {
            showToast('Đã thêm sản phẩm vào giỏ hàng!', 'success');
            var badgeElement = document.querySelector('.badge-circle');
            if (badgeElement) { var currentCount = parseInt(badgeElement.textContent) || 0; badgeElement.textContent = currentCount + 1; }
        } else { showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'danger'); }
    };
    xhr.onerror = function() { showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'danger'); };
    xhr.send('_csrf=' + encodeURIComponent(token));
}

// Pagination with filters
function goToPage(pageNo) {
    var form = document.getElementById('filterForm');
    var formData = new FormData(form);
    var params = new URLSearchParams();
    params.append('pageNo', pageNo);
    var keyword = document.querySelector('input[name="keyword"]');
    if (keyword && keyword.value) { params.append('keyword', keyword.value); }
    document.querySelectorAll('input[name="factory"]:checked').forEach(function(cb) { params.append('factory', cb.value); });
    document.querySelectorAll('input[name="target"]:checked').forEach(function(cb) { params.append('target', cb.value); });
    var minPrice = document.getElementById('minPriceInput').value;
    var maxPrice = document.getElementById('maxPriceInput').value;
    if (minPrice) params.append('minPrice', minPrice);
    if (maxPrice) params.append('maxPrice', maxPrice);
    var sortRadio = document.querySelector('input[name="sort"]:checked');
    if (sortRadio && sortRadio.value) { params.append('sort', sortRadio.value); }
    window.location.href = '/product/show?' + params.toString();
}