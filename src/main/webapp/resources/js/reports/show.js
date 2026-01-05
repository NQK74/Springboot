
        // Read report data from DOM and initialize charts
const reportDataEl = document.getElementById('report-data');
const getInt = (v) => parseInt(v || '0', 10);

// Order Status Pie Chart
(function initOrderStatusChart() {
    const canvas = document.getElementById('orderStatusChart');
    if (!canvas) return;
    const pending   = getInt(reportDataEl?.dataset.pending);
    const confirmed = getInt(reportDataEl?.dataset.confirmed);
    const shipping  = getInt(reportDataEl?.dataset.shipping);
    const delivered = getInt(reportDataEl?.dataset.delivered);
    const cancelled = getInt(reportDataEl?.dataset.cancelled);

    const ctx = canvas.getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Chờ xác nhận', 'Đã xác nhận', 'Đang giao', 'Đã giao', 'Đã hủy'],
            datasets: [{
                data: [pending, confirmed, shipping, delivered, cancelled],
                backgroundColor: ['#f59e0b', '#3b82f6', '#8b5cf6', '#22c55e', '#ef4444'],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 20,
                        usePointStyle: true
                    }
                }
            }
        }
    });
})();

// Safe fetch helper
async function fetchJson(url) {
    try {
        const res = await fetch(url, { credentials: 'same-origin' });
        if (!res.ok) {
            console.error(`Fetch ${url} failed: ${res.status} ${res.statusText}`);
            return null;
        }
        const ct = res.headers.get('content-type') || '';
        if (!ct.includes('application/json')) {
            const txt = await res.text();
            console.error(`Expected JSON from ${url} but got:`, txt);
            return null;
        }
        return await res.json();
    } catch (err) {
        console.error(`Network error fetching ${url}:`, err);
        return null;
    }
}
        
        // Revenue Chart
        async function loadRevenueChart() {
            try {
                const data = await fetchJson('/admin/api/revenue/daily?days=7');
                if (!data) return;

                const labels = data.map(item => item.label);
                const revenues = data.map(item => item.revenue);

                const revenueCtxEl = document.getElementById('revenueChart');
                if (!revenueCtxEl) return;
                const revenueCtx = revenueCtxEl.getContext('2d');
                new Chart(revenueCtx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Doanh thu (VNĐ)',
                            data: revenues,
                            backgroundColor: 'rgba(99, 102, 241, 0.8)',
                            borderColor: '#6366f1',
                            borderWidth: 1,
                            borderRadius: 8
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return new Intl.NumberFormat('vi-VN').format(value) + ' đ';
                                    }
                                }
                            }
                        }
                    }
                });
            } catch (error) {
                console.error('Error loading revenue chart:', error);
            }
        }
        
        loadRevenueChart();
        
        // Monthly Revenue Chart (12 months)
        async function loadMonthlyRevenueChart() {
            try {
                const data = await fetchJson('/admin/api/revenue/monthly?months=12');
                if (!data) return;

                const labels = data.map(item => item.label);
                const revenues = data.map(item => item.revenue);
                const orders = data.map(item => item.orderCount);

                const monthlyCanvas = document.getElementById('monthlyRevenueChart');
                if (!monthlyCanvas) return;
                const monthlyCtx = monthlyCanvas.getContext('2d');
                new Chart(monthlyCtx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Doanh Thu (VNĐ)',
                            data: revenues,
                            backgroundColor: 'rgba(99, 102, 241, 0.2)',
                            borderColor: '#6366f1',
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4,
                            pointRadius: 6,
                            pointBackgroundColor: '#6366f1',
                            pointBorderColor: '#fff',
                            pointBorderWidth: 2,
                            yAxisID: 'y'
                        }, {
                            label: 'Số Đơn Hàng',
                            data: orders,
                            backgroundColor: 'rgba(16, 185, 129, 0.2)',
                            borderColor: '#10b981',
                            borderWidth: 3,
                            fill: false,
                            tension: 0.4,
                            pointRadius: 5,
                            pointBackgroundColor: '#10b981',
                            pointBorderColor: '#fff',
                            pointBorderWidth: 2,
                            yAxisID: 'y1'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        interaction: {
                            mode: 'index',
                            intersect: false,
                        },
                        plugins: {
                            legend: {
                                position: 'top',
                                labels: {
                                    usePointStyle: true,
                                    padding: 20,
                                    font: { size: 13, weight: '500' }
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                padding: 12,
                                callbacks: {
                                    label: function(context) {
                                        if (context.datasetIndex === 0) {
                                            return 'Doanh Thu: ' + new Intl.NumberFormat('vi-VN').format(context.raw) + ' đ';
                                        }
                                        return 'Số Đơn: ' + context.raw + ' đơn';
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                type: 'linear',
                                display: true,
                                position: 'left',
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return new Intl.NumberFormat('vi-VN').format(value) + ' đ';
                                    }
                                },
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.05)'
                                }
                            },
                            y1: {
                                type: 'linear',
                                display: true,
                                position: 'right',
                                beginAtZero: true,
                                grid: {
                                    drawOnChartArea: false
                                },
                                ticks: {
                                    stepSize: 1
                                }
                            },
                            x: {
                                grid: {
                                    display: false
                                }
                            }
                        }
                    }
                });
            } catch (error) {
                console.error('Error loading monthly revenue chart:', error);
            }
        }
        
        loadMonthlyRevenueChart();