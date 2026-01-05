    // Update current time
    function updateTime() {
        const now = new Date();
        const options = { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        };
        document.getElementById('currentTime').textContent = now.toLocaleDateString('vi-VN', options);
    }
    
    updateTime();
    setInterval(updateTime, 60000);
    
    // Chart variables
    let dailyChart = null;
    let monthlyChart = null;
    
    // Format number to VND
    function formatVND(number) {
        return new Intl.NumberFormat('vi-VN').format(number) + ' đ';
    }
    
    // Switch between charts
    function showChart(chartType) {
        document.querySelectorAll('.chart-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelector(`[data-chart="${chartType}"]`).classList.add('active');
        
        if (chartType === 'daily') {
            document.getElementById('dailyChartWrapper').style.display = 'block';
            document.getElementById('monthlyChartWrapper').style.display = 'none';
        } else {
            document.getElementById('dailyChartWrapper').style.display = 'none';
            document.getElementById('monthlyChartWrapper').style.display = 'block';
        }
    }
    
    // Load daily revenue data
    async function loadDailyRevenue() {
        try {
            const response = await fetch('/admin/api/revenue/daily?days=7');
            const data = await response.json();
            
            const labels = data.map(item => item.label);
            const revenues = data.map(item => item.revenue);
            const orders = data.map(item => item.orderCount);
            
            const ctx = document.getElementById('dailyRevenueChart').getContext('2d');
            
            if (dailyChart) dailyChart.destroy();
            
            dailyChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh Thu (đ)',
                        data: revenues,
                        backgroundColor: 'rgba(102, 126, 234, 0.8)',
                        borderColor: 'rgba(102, 126, 234, 1)',
                        borderWidth: 2,
                        borderRadius: 8,
                        yAxisID: 'y'
                    }, {
                        label: 'Số Đơn Hàng',
                        data: orders,
                        type: 'line',
                        backgroundColor: 'rgba(16, 185, 129, 0.2)',
                        borderColor: 'rgba(16, 185, 129, 1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
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
                            titleFont: { size: 14 },
                            bodyFont: { size: 13 },
                            callbacks: {
                                label: function(context) {
                                    if (context.datasetIndex === 0) {
                                        return 'Doanh Thu: ' + formatVND(context.raw);
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
                                    return formatVND(value);
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
            console.error('Error loading daily revenue:', error);
        }
    }
    
    // Load monthly revenue data
    async function loadMonthlyRevenue() {
        try {
            const response = await fetch('/admin/api/revenue/monthly?months=12');
            const data = await response.json();
            
            const labels = data.map(item => item.label);
            const revenues = data.map(item => item.revenue);
            const orders = data.map(item => item.orderCount);
            
            const ctx = document.getElementById('monthlyRevenueChart').getContext('2d');
            
            if (monthlyChart) monthlyChart.destroy();
            
            monthlyChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh Thu (đ)',
                        data: revenues,
                        backgroundColor: 'rgba(118, 75, 162, 0.2)',
                        borderColor: 'rgba(118, 75, 162, 1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        pointRadius: 6,
                        pointBackgroundColor: 'rgba(118, 75, 162, 1)',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        yAxisID: 'y'
                    }, {
                        label: 'Số Đơn Hàng',
                        data: orders,
                        backgroundColor: 'rgba(245, 158, 11, 0.2)',
                        borderColor: 'rgba(245, 158, 11, 1)',
                        borderWidth: 3,
                        fill: false,
                        tension: 0.4,
                        pointRadius: 5,
                        pointBackgroundColor: 'rgba(245, 158, 11, 1)',
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
                                        return 'Doanh Thu: ' + formatVND(context.raw);
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
                                    return formatVND(value);
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
            console.error('Error loading monthly revenue:', error);
        }
    }
    
    // Load charts on page load
    document.addEventListener('DOMContentLoaded', function() {
        loadDailyRevenue();
        loadMonthlyRevenue();
    });
