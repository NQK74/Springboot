// Format currency
function formatCurrency(value) {
    const formatter = new Intl.NumberFormat('vi-VN', {
        style: 'decimal',
        minimumFractionDigits: 0,
    });
    let formattedValue = formatter.format(value);
    formattedValue = formattedValue.replace(/,/g, '.');
    return formattedValue;
}

// Hàm tính tổng tiền các sản phẩm được chọn
function calculateTotal() {
    let total = 0;
    let selectedCount = 0;
    
    $('.product-checkbox:checked').each(function() {
        const cartDetailId = $(this).data('cart-detail-id');
        const row = $(this).closest('tr');
        const quantityDisplay = row.find('.quantity-display');
        const quantity = parseInt(quantityDisplay.text()) || 1;
        const priceElement = row.find('.item-total[data-cart-detail-id="' + cartDetailId + '"]');
        
        // Lấy giá từ data attribute hoặc parse từ text
        let itemTotal = 0;
        if (priceElement.attr('data-price')) {
            itemTotal = parseFloat(priceElement.attr('data-price'));
        } else {
            const priceText = priceElement.text().replace(/\./g, '').replace(' đ', '');
            itemTotal = parseFloat(priceText) || 0;
        }
        
        total += itemTotal;
        selectedCount++;
    });
    
    $('#subtotal').text(formatCurrency(total) + ' đ');
    $('#totalPrice').text(formatCurrency(total) + ' đ');
    $('#selectedItemsCount').text(selectedCount);
    $('#selectedCount').text('(' + selectedCount + ' sản phẩm)');
    
    // Cập nhật trạng thái nút checkout
    if (selectedCount === 0) {
        $('#checkoutBtn').prop('disabled', true).css('opacity', '0.5');
    } else {
        $('#checkoutBtn').prop('disabled', false).css('opacity', '1');
    }
}

// Product Quantity với AJAX để lưu vào DB
$(document).ready(function() {
    // Lấy CSRF token
    var csrfToken = $('meta[name="_csrf"]').attr('content');
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    
    if (!csrfToken) {
        csrfToken = $('input[name="_csrf"]').val();
    }

    // Xử lý tăng giảm số lượng
    $('.quantity-btn').on('click', function () {
        var button = $(this);
        var quantityDisplay = button.siblings('.quantity-display');
        var oldValue = parseInt(quantityDisplay.text()) || 1;
        var newVal;
        
        if (button.hasClass('btn-plus')) {
            newVal = oldValue + 1;
        } else {
            // Don't allow decrementing below 1
            if (oldValue > 1) {
                newVal = oldValue - 1;
            } else {
                return; // Không làm gì nếu đã là 1
            }
        }

        // Cập nhật giá trị hiển thị số lượng
        quantityDisplay.text(newVal);
        
        // Lấy thông tin từ button
        const price = parseFloat(button.attr('data-cart-detail-price'));
        const cartDetailId = button.attr('data-cart-detail-id');

        // Cập nhật thành tiền của sản phẩm
        const newItemTotal = price * newVal;
        const priceElement = $('.item-total[data-cart-detail-id="' + cartDetailId + '"]');
        if (priceElement && priceElement.length) {
            priceElement.text(formatCurrency(newItemTotal) + ' đ');
            priceElement.attr('data-price', newItemTotal);
        }
        
        // Cập nhật data-price của checkbox để tính tổng đúng
        const checkbox = $('.product-checkbox[data-cart-detail-id="' + cartDetailId + '"]');
        if (checkbox && checkbox.length) {
            checkbox.attr('data-price', newItemTotal);
        }
        
        // Tính lại tổng tiền ngay lập tức
        calculateTotal();

        // Gửi AJAX request để cập nhật vào database
        $.ajax({
            url: '/update-cart-quantity/' + cartDetailId,
            type: 'POST',
            data: {
                quantity: newVal,
                _csrf: csrfToken
            },
            success: function(response) {
                console.log('Đã cập nhật số lượng vào database');
            },
            error: function(xhr, status, error) {
                console.error('Lỗi khi cập nhật:', error);
                // Hiển thị thông báo lỗi thay vì reload
                alert('Có lỗi xảy ra khi cập nhật số lượng. Vui lòng thử lại!');
                // Reload lại trang nếu cần
                location.reload();
            }
        });
    });

    // Xử lý checkbox sản phẩm
    $('.product-checkbox').on('change', function() {
        const cartDetailId = $(this).data('cart-detail-id');
        const isChecked = $(this).is(':checked');
        const row = $(this).closest('tr');
        
        // Toggle class unselected
        if (isChecked) {
            row.removeClass('unselected');
        } else {
            row.addClass('unselected');
        }
        
        // Cập nhật trạng thái checkbox "Chọn tất cả"
        const allChecked = $('.product-checkbox').length === $('.product-checkbox:checked').length;
        $('#selectAll').prop('checked', allChecked);
        
        // Gửi AJAX để cập nhật trạng thái selected trong database
        $.ajax({
            url: '/api/cart/toggle-select/' + cartDetailId,
            method: 'POST',
            headers: {
                'X-CSRF-TOKEN': csrfToken
            },
            data: { selected: isChecked },
            success: function() {
                calculateTotal();
            },
            error: function(xhr, status, error) {
                console.error('Lỗi khi cập nhật trạng thái:', error);
            }
        });
    });

    // Xử lý checkbox "Chọn tất cả"
    $('#selectAll').on('change', function() {
        const isChecked = $(this).is(':checked');
        
        $('.product-checkbox').prop('checked', isChecked).each(function() {
            const row = $(this).closest('tr');
            if (isChecked) {
                row.removeClass('unselected');
            } else {
                row.addClass('unselected');
            }
        });
        
        // Gửi AJAX để cập nhật tất cả
        const cartDetailIds = [];
        $('.product-checkbox').each(function() {
            cartDetailIds.push($(this).data('cart-detail-id'));
        });
        
        $.ajax({
            url: '/api/cart/toggle-select-all',
            method: 'POST',
            headers: {
                'X-CSRF-TOKEN': csrfToken
            },
            data: { 
                selected: isChecked,
                cartDetailIds: cartDetailIds.join(',')
            },
            success: function() {
                calculateTotal();
            },
            error: function(xhr, status, error) {
                console.error('Lỗi khi cập nhật tất cả:', error);
            }
        });
    });

    // Xử lý submit form checkout
    $('#checkoutForm').on('submit', function(e) {
        const selectedIds = [];
        $('.product-checkbox:checked').each(function() {
            selectedIds.push($(this).data('cart-detail-id'));
        });
        
        if (selectedIds.length === 0) {
            e.preventDefault();
            alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
            return false;
        }
        
        $('#selectedItemsInput').val(selectedIds.join(','));
    });

    // Tính tổng ban đầu khi load trang
    calculateTotal();
});