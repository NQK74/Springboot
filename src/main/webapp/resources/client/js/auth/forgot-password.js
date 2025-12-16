// OTP Input handling
document.addEventListener('DOMContentLoaded', function() {
    const otpInputs = document.querySelectorAll('.otp-digit');
    const otpForm = document.getElementById('otpForm');
    const otpValue = document.getElementById('otpValue');

    if (otpInputs.length > 0) {
        otpInputs.forEach((input, index) => {
            // Auto focus next input
            input.addEventListener('input', function(e) {
                const value = e.target.value;
                if (value.length === 1 && index < otpInputs.length - 1) {
                    otpInputs[index + 1].focus();
                }
                // Only allow numbers
                e.target.value = value.replace(/[^0-9]/g, '');
            });

            // Handle backspace
            input.addEventListener('keydown', function(e) {
                if (e.key === 'Backspace' && !e.target.value && index > 0) {
                    otpInputs[index - 1].focus();
                }
            });

            // Handle paste
            input.addEventListener('paste', function(e) {
                e.preventDefault();
                const paste = (e.clipboardData || window.clipboardData).getData('text');
                const digits = paste.replace(/[^0-9]/g, '').split('');
                digits.forEach((digit, i) => {
                    if (otpInputs[index + i]) {
                        otpInputs[index + i].value = digit;
                    }
                });
                // Focus on last filled or next empty input
                const nextIndex = Math.min(index + digits.length, otpInputs.length - 1);
                otpInputs[nextIndex].focus();
            });
        });

        // Combine OTP on form submit
        if (otpForm) {
            otpForm.addEventListener('submit', function(e) {
                let otp = '';
                otpInputs.forEach(input => {
                    otp += input.value;
                });
                if (otp.length !== 6) {
                    e.preventDefault();
                    alert('Vui lòng nhập đủ 6 số!');
                    return;
                }
                otpValue.value = otp;
            });
        }

        // Auto focus first input
        otpInputs[0].focus();
    }
});