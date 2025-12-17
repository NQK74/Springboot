function selectPayment(element, method) {
    // Remove selected class from all
    document.querySelectorAll('.payment-method').forEach(el => { el.classList.remove('selected'); });
    // Add selected class to clicked element
    element.classList.add('selected');
    // Check the radio button
    const input = element.querySelector('input[type="radio"]');
    if (input) input.checked = true;
    
    // Thay đổi form action dựa trên phương thức thanh toán
    const form = document.getElementById('checkoutForm');
    if (method === 'VNPAY') {
        form.action = '/vnpay/create-payment';
    } else {
        form.action = '/place-order';
    }
}