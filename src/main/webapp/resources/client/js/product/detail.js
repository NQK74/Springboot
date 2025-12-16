$(document).ready(function() {
    const maxQuantity = productData.maxQuantity;
    const productId = productData.productId;
    const csrfToken = $('meta[name="_csrf"]').attr('content');
    const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    
    // Handle Add to Cart Form Submission
    $('form[action^="/add-product-to-cart/"]').on('submit', function(e) {
        e.preventDefault();
        const form = this;
        const quantity = $('#cartQuantity').val();
        $.ajax({
            url: '/add-product-to-cart/' + productId,
            type: 'POST',
            data: { quantity: quantity, _csrf: csrfToken },
            headers: csrfHeader ? { [csrfHeader]: csrfToken } : {},
            success: function(response) {
                showToast('Đã thêm sản phẩm vào giỏ hàng!', 'success');
                var badgeElement = document.querySelector('.badge-circle');
                if (badgeElement) {
                    var currentCount = parseInt(badgeElement.textContent) || 0;
                    badgeElement.textContent = currentCount + parseInt(quantity);
                }
            },
            error: function() { showToast('Có lỗi xảy ra. Vui lòng thử lại!', 'danger'); }
        });
    });
    
    // Quantity Controls
    $('#btnPlus').on('click', function() {
        let input = $('#quantityInput');
        let currentVal = parseInt(input.val());
        if (currentVal < maxQuantity) {
            input.val(currentVal + 1);
            $('#cartQuantity').val(currentVal + 1);
        }
    });

    $('#btnMinus').on('click', function() {
        let input = $('#quantityInput');
        let currentVal = parseInt(input.val());
        if (currentVal > 1) {
            input.val(currentVal - 1);
            $('#cartQuantity').val(currentVal - 1);
        }
    });

    $('#quantityInput').on('change', function() {
        let val = parseInt($(this).val());
        if (val < 1) val = 1;
        if (val > maxQuantity) val = maxQuantity;
        $(this).val(val);
        $('#cartQuantity').val(val);
    });

    // Wishlist Toggle
    $('#btnWishlist').on('click', function() {
        $(this).find('i').toggleClass('far fas');
        $(this).toggleClass('active');
    });

    // Thumbnail Gallery
    $('.thumbnail-item').on('click', function() {
        $('.thumbnail-item').removeClass('active');
        $(this).addClass('active');
        const newImage = $(this).find('img').attr('src');
        $('#mainImage').attr('src', newImage);
    });

    // Star Rating Input
    $('.star-input').on('click', function() {
        const rating = $(this).data('rating');
        $('#ratingInput').val(rating);
        $('.star-input').each(function(index) {
            if (index < rating) {
                $(this).removeClass('far').addClass('fas').css('color', '#ffc107');
            } else {
                $(this).removeClass('fas').addClass('far').css('color', '#e2e8f0');
            }
        });
    });

    $('.star-input').on('mouseenter', function() {
        const rating = $(this).data('rating');
        $('.star-input').each(function(index) {
            if (index < rating) {
                $(this).css('color', '#ffdb4d');
            }
        });
    });

    $('.star-input').on('mouseleave', function() {
        const currentRating = $('#ratingInput').val();
        $('.star-input').each(function(index) {
            if (index < currentRating) {
                $(this).css('color', '#ffc107');
            } else {
                $(this).css('color', '#e2e8f0');
            }
        });
    });

    // Submit Review
    $('#submitReviewBtn').on('click', function() {
        const rating = $('#ratingInput').val();
        const title = $('#reviewTitle').val().trim();
        const content = $('#reviewContent').val().trim();

        if (!title || !content) {
            alert('Vui lòng nhập đầy đủ tiêu đề và nội dung đánh giá!');
            return;
        }

        $.ajax({
            url: '/api/reviews/submit',
            type: 'POST',
            beforeSend: function(xhr) { xhr.setRequestHeader(csrfHeader, csrfToken); },
            data: { productId: productId, rating: rating, title: title, content: content },
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    location.reload();
                } else {
                    alert(response.message);
                }
            },
            error: function() { alert('Có lỗi xảy ra. Vui lòng thử lại!'); }
        });
    });

    // Helpful Button
    $(document).on('click', '.helpful-btn', function() {
        const btn = $(this);
        const reviewId = btn.data('review-id');
        $.ajax({
            url: '/api/reviews/helpful/' + reviewId,
            type: 'POST',
            beforeSend: function(xhr) { xhr.setRequestHeader(csrfHeader, csrfToken); },
            success: function(response) {
                if (response.success) {
                    btn.find('.helpful-count').text(response.helpfulCount);
                    btn.addClass('active');
                }
            }
        });
    });

    // Edit Review & Delete handlers
    $(document).on('click', '.edit-review-btn', function() {
        const reviewId = $(this).data('review-id');
        const rating = $(this).data('rating');
        const title = $(this).data('title');
        const content = $(this).data('content');
        
        $('#editReviewId').val(reviewId);
        $('#editRatingInput').val(rating);
        $('#editReviewTitle').val(title);
        $('#editReviewContent').val(content);
        
        $('.edit-star-input').each(function(index) {
            if (index < rating) {
                $(this).removeClass('far').addClass('fas').css('color', '#ffc107');
            } else {
                $(this).removeClass('fas').addClass('far').css('color', '#e2e8f0');
            }
        });
        
        $('#editReviewModal').modal('show');
    });

    $('.edit-star-input').on('click', function() {
        const rating = $(this).data('rating');
        $('#editRatingInput').val(rating);
        $('.edit-star-input').each(function(index) {
            if (index < rating) {
                $(this).removeClass('far').addClass('fas').css('color', '#ffc107');
            } else {
                $(this).removeClass('fas').addClass('far').css('color', '#e2e8f0');
            }
        });
    });

    $('#saveEditReviewBtn').on('click', function() {
        const reviewId = $('#editReviewId').val();
        const rating = $('#editRatingInput').val();
        const title = $('#editReviewTitle').val().trim();
        const content = $('#editReviewContent').val().trim();
        
        if (!title || !content) { alert('Vui lòng nhập đầy đủ tiêu đề và nội dung!'); return; }
        
        $.ajax({
            url: '/api/reviews/update/' + reviewId,
            type: 'POST',
            beforeSend: function(xhr) { xhr.setRequestHeader(csrfHeader, csrfToken); },
            data: { rating: rating, title: title, content: content },
            success: function(response) {
                if (response.success) {
                    alert(response.message);
                    $('#editReviewModal').modal('hide');
                    location.reload();
                } else { alert(response.message); }
            },
            error: function() { alert('Có lỗi xảy ra. Vui lòng thử lại!'); }
        });
    });

    $(document).on('click', '.delete-review-btn', function() {
        const reviewId = $(this).data('review-id');
        if (!confirm('Bạn có chắc chắn muốn xóa đánh giá này?')) return;
        $.ajax({ url: '/api/reviews/delete/' + reviewId, type: 'POST', beforeSend: function(xhr) { xhr.setRequestHeader(csrfHeader, csrfToken); }, success: function(response) { if (response.success) { alert(response.message); location.reload(); } else { alert(response.message); } }, error: function() { alert('Có lỗi xảy ra. Vui lòng thử lại!'); } });
    });

    // Pagination
    $(document).on('click', '.pagination-btn', function() { const page = $(this).data('page'); loadReviews(page); });

    function loadReviews(page) {
        $.ajax({ url: '/api/reviews/' + productId + '?page=' + page, type: 'GET', success: function(response) { renderReviews(response.reviews); renderPagination(response.currentPage, response.totalPages); } });
    }

    function renderReviews(reviews) {
        let html = '';
        if (reviews.length === 0) {
            html = '<div class="reviews-empty"><i class="far fa-comment-dots"></i><h4>Chưa có đánh giá nào</h4><p>Hãy là người đầu tiên đánh giá sản phẩm này!</p></div>';
        } else {
            reviews.forEach(function(review) {
                const stars = Array(5).fill(0).map((_, i) => i < review.rating ? '<i class="fas fa-star"></i>' : '<i class="far fa-star"></i>').join('');
                const initial = review.userName ? review.userName.charAt(0).toUpperCase() : 'U';
                const avatar = review.userAvatar ? '<img src="/images/avatar/' + review.userAvatar + '" style="width:100%;height:100%;border-radius:50%;object-fit:cover;">' : initial;
                const date = new Date(review.createdAt).toLocaleDateString('vi-VN');
                html += '<div class="review-item" data-review-id="' + review.id + '">' +
                    '<div class="review-header">' +
                    '<div class="reviewer-info">' +
                    '<div class="reviewer-avatar">' + avatar + '</div>' +
                    '<div class="reviewer-details">' +
                    '<h5>' + review.userName + '</h5>' +
                    '<div class="reviewer-meta"><span class="verified-badge"><i class="fas fa-check-circle"></i> Đã mua hàng</span></div>' +
                    '</div></div>' +
                    '<div class="review-rating-date">' +
                    '<div class="review-stars">' + stars + '</div>' +
                    '<div class="review-date">' + date + '</div>' +
                    '</div></div>' +
                    '<div class="review-content"><strong>' + review.title + '</strong><br>' + review.content + '</div>' +
                    '<div class="review-actions">' +
                    '<button class="review-action-btn helpful-btn" data-review-id="' + review.id + '">' +
                    '<i class="far fa-thumbs-up"></i><span>Hữu ích (<span class="helpful-count">' + review.helpfulCount + '</span>)</span>' +
                    '</button></div></div>';
            });
        }
        $('#reviewsList').html(html);
    }

    function renderPagination(currentPage, totalPages) {
        if (totalPages <= 1) { $('#reviewsPagination').hide(); return; }
        let html = '';
        for (let i = 0; i < totalPages; i++) {
            html += '<button class="pagination-btn ' + (i === currentPage ? 'active' : '') + '" data-page="' + i + '">' + (i + 1) + '</button>';
        }
        $('#reviewsPagination').html(html).show();
    }
});