/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos.helpers;

/**
 *
 * @author hoang hung
 */
public class PagingCriteria {
    
    private Integer pageNumber;
    private Integer offset;
    private Integer pageSize;
    
    public PagingCriteria(Integer pageNumber, Integer pageSize) {
        this.pageNumber = pageNumber;
        this.offset = pageNumber * pageSize;
        this.pageSize = pageSize;
    }

    public PagingCriteria() {
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Integer getFetchNext() {
        return pageSize;
    }

    public void setFetchNext(Integer pageSize) {
        this.pageSize = pageSize;
    }
    
    public boolean isEmpty() {
        return (pageNumber == null && pageSize == null && offset == null);
    }

    @Override
    public String toString() {
        return "PagingCriteria{" +
                "pageNumber=" + pageNumber +
                ", pageSize=" + pageSize +
                '}';
    }
}