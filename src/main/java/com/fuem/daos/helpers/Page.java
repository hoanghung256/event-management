/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.daos.helpers;

import java.util.ArrayList;

/**
 *
 * @author hoang hung
 */
public class Page<T> {
    
    private ArrayList<T> datas;
    private Integer currentPage;
    private Integer totalPage;
    
    public Page() {
    }
    
    public Page(ArrayList<T> datas, Integer currentPage, Integer totalPage) {
        this.datas = datas;
        this.currentPage = currentPage;
        this.totalPage = totalPage;
    }
    
    public ArrayList<T> getDatas() {
        return datas;
    }

    public void setDatas(ArrayList<T> datas) {
        this.datas = datas;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    @Override
    public String toString() {
        return "Page{" + "datas=" + datas + ", currentPage=" + currentPage + ", totalPage=" + totalPage + '}';
    }
}