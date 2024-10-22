/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.models;

import com.fuem.enums.FileStatus;
import java.time.LocalDateTime;

/**
 *
 * @author HungHV
 */
public class Document {

    private int id;
    private int submitterId;
    private String displayName;
    private String type;
    private String path;
    private String processNote;
    private LocalDateTime processTime;
    private FileStatus status;
    private LocalDateTime sendTime;

    public Document(int submitterId, String displayName, String type, String path, FileStatus status) {
        this.submitterId = submitterId;
        this.displayName = displayName;
        this.type = type;
        this.path = path;
        this.status = status;
    }

    public Document(int id, int submitterId, String displayName, String type, String path, LocalDateTime sendTime, String processNote, LocalDateTime processTime, FileStatus status) {
        this.id = id;
        this.submitterId = submitterId;
        this.displayName = displayName;
        this.type = type;
        this.path = path;
        this.sendTime = sendTime;
        this.processNote = processNote;
        this.processTime = processTime;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProcessNote() {
        return processNote;
    }

    public void setProcessNote(String processNote) {
        this.processNote = processNote;
    }

    public LocalDateTime getProcessTime() {
        return processTime;
    }

    public void setProcessTime(LocalDateTime processTime) {
        this.processTime = processTime;
    }

    public int getSubmitterId() {
        return submitterId;
    }

    public void setSubmitterId(int submitterId) {
        this.submitterId = submitterId;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public FileStatus getStatus() {
        return status;
    }

    public void setStatus(FileStatus status) {
        this.status = status;
    }

    public LocalDateTime getSendTime() {
        return sendTime;
    }

    public void setSendTime(LocalDateTime sendTime) {
        this.sendTime = sendTime;
    }

    @Override
    public String toString() {
        return "Document{" + "id=" + id + ", submitterId=" + submitterId + ", displayName=" + displayName + ", path=" + path + ", status=" + status + ", sendTime=" + sendTime + '}';
    }
}
