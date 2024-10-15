/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.enums;

/**
 *
 * @author hoang hung
 */
public enum FileType {
    IMAGE("/assets/upload/images"),
    DOCUMENT("/assets/upload/documents");
    
    private final String fileLocation;
    
    FileType(String fileLocation) {
        this.fileLocation = fileLocation;
    }
    
    public String getFileLocation() {
        return this.fileLocation;
    }
}
