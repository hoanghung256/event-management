/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.repositories.helpers;

import java.time.LocalDate;

/**
 *
 * @author hoang hung
 */
public class SearchEventCriteria {
    
    private String name;
    private Integer categoryId;
    private Integer organizerId;
    private LocalDate from;
    private LocalDate to;
    private EventOrderBy orderBy;
    
    public SearchEventCriteria() {}

    public SearchEventCriteria(String name, Integer categoryId, Integer organizerId, LocalDate from, LocalDate to, EventOrderBy orderBy) {
        this.name = name;
        this.categoryId = categoryId;
        this.organizerId = organizerId;
        this.from = from;
        this.to = to;
        this.orderBy = orderBy;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getOrganizerId() {
        return organizerId;
    }

    public void setOrganizerId(Integer organizerId) {
        this.organizerId = organizerId;
    }

    public LocalDate getFrom() {
        return from;
    }

    public void setFrom(LocalDate from) {
        this.from = from;
    }

    public LocalDate getTo() {
        return to;
    }

    public void setTo(LocalDate to) {
        this.to = to;
    }

    public EventOrderBy getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(EventOrderBy orderBy) {
        this.orderBy = orderBy;
    }
    
    public boolean isEmpty() {
        return (name == null && categoryId == null && organizerId == null && from == null && to == null && orderBy == null);
    }

    @Override
    public String toString() {
        return "SearchEventCriteria{" + "name=" + name + ", categoryId=" + categoryId + ", organizerId=" + organizerId + ", from=" + from + ", to=" + to + ", orderBy=" + orderBy + '}';
    }
}