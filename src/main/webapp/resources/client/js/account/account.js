// Auto-hide success message after 5 seconds
document.addEventListener('DOMContentLoaded', function() {
    const alertElement = document.querySelector('.alert-success');
    if (alertElement) {
        setTimeout(function() {
            const alert = new bootstrap.Alert(alertElement);
            alert.close();
        }, 5000);
    }

    // File upload handling
    const uploadArea = document.getElementById('uploadArea');
    const fileInput = document.getElementById('avatarFile');

    if (uploadArea) {
        // Click to upload
        uploadArea.addEventListener('click', () => fileInput.click());

        // Drag and drop
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });

        uploadArea.addEventListener('dragleave', () => {
            uploadArea.classList.remove('dragover');
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                fileInput.files = files;
                handleFileSelect(files[0]);
            }
        });
    }

    // File input change handler
    if (fileInput) {
        fileInput.addEventListener('change', (e) => {
            if (e.target.files.length > 0) {
                handleFileSelect(e.target.files[0]);
            }
        });
    }
});

function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        handleFileSelect(file);
    }
}

function handleFileSelect(file) {
    const previewContainer = document.getElementById('previewContainer');
    const previewImg = document.getElementById('previewImg');
    const uploadArea = document.getElementById('uploadArea');

    // Validate file
    const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
    const maxSize = 5 * 1024 * 1024; // 5MB

    if (!allowedTypes.includes(file.type)) {
        alert('Vui lòng chọn file ảnh (JPG, PNG, GIF, WebP)');
        return;
    }

    if (file.size > maxSize) {
        alert('Kích thước ảnh không được vượt quá 5MB');
        return;
    }

    // Show preview
    const reader = new FileReader();
    reader.onload = (e) => {
        previewImg.src = e.target.result;
        previewContainer.style.display = 'block';
        uploadArea.style.opacity = '0.5';
    };
    reader.readAsDataURL(file);
}