function selectPayment(element, method) {
    // Remove selected class from all
    document.querySelectorAll('.payment-method').forEach(el => { el.classList.remove('selected'); });
    // Add selected class to clicked element
    element.classList.add('selected');
    // Check the radio button
    const input = element.querySelector('input[type="radio"]');
    if (input) input.checked = true;
}