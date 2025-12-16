package com.example.laptopshop.domain.dto;

public class RevenueDTO {
    private String label;      // Nhãn (ngày, tháng, năm)
    private double revenue;    // Doanh thu
    private long orderCount;   // Số đơn hàng

    public RevenueDTO() {
    }

    public RevenueDTO(String label, double revenue, long orderCount) {
        this.label = label;
        this.revenue = revenue;
        this.orderCount = orderCount;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    public long getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(long orderCount) {
        this.orderCount = orderCount;
    }
}
