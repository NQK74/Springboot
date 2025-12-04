// Product Quantity
$(document).ready(function() {
    $('.quantity-btn').on('click', function () {
        var button = $(this);
        // Tìm div.quantity-display (là sibling của button)
        var quantityDisplay = button.siblings('.quantity-display');
        var oldValue = parseInt(quantityDisplay.text()) || 1;
        var newVal;
        var change = 0;
        
        if (button.hasClass('btn-plus')) {
            newVal = oldValue + 1;
            change = 1;
        } else {
            // Don't allow decrementing below 1
            if (oldValue > 1) {
                newVal = oldValue - 1;
                change = -1;
            } else {
                newVal = 1;
                change = 0;
            }
        }

        // Cập nhật giá trị hiển thị số lượng
        quantityDisplay.text(newVal);

        // Lấy thông tin từ button
        const price = parseFloat(button.attr('data-cart-detail-price'));
        const cartDetailId = button.attr('data-cart-detail-id');

        // Cập nhật thành tiền của sản phẩm
        const priceElement = $('p[data-cart-detail-id="' + cartDetailId + '"]');
        if (priceElement && priceElement.length) {
            const newPrice = price * newVal;
            priceElement.text(formatCurrency(newPrice) + ' đ');
        }
        
        // Cập nhật tổng tiền
        if (change !== 0) {
            const totalPriceElements = $('.total-price');
            if (totalPriceElements && totalPriceElements.length) {
                // Lấy tổng tiền hiện tại từ data attribute
                let currentTotal = parseFloat(totalPriceElements.first().attr('data-cart-total')) || 0;
                
                // Tính tổng mới
                const newTotal = currentTotal + (change * price);
                
                // Cập nhật tất cả phần tử tổng tiền
                totalPriceElements.each(function() {
                    $(this).text(formatCurrency(newTotal) + ' đ');
                    $(this).attr('data-cart-total', newTotal);
                });
            }
        }
    });
});

function formatCurrency(value) {
    const formatter = new Intl.NumberFormat('vi-VN', {
        style: 'decimal',
        minimumFractionDigits: 0,
    });
    let formattedValue = formatter.format(value);
    formattedValue = formattedValue.replace(/,/g, '.');
    return formattedValue;
}