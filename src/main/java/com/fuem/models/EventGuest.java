package com.fuem.models;


import java.sql.Date;
import java.time.LocalDate;

public class EventGuest {
    private int guestId;
    private int eventId;
    private String guestName; // Thêm trường guestName
    private String eventName; // Thêm trường eventName
    private LocalDate dateOfEvent; // Thêm trường eventDate
    private boolean isRegistered;
    private boolean isAttended;
    private boolean isCancelRegister;
    private String studentId;
    

 
   

    public EventGuest(String studentId, String guestName, int eventId, String eventName, LocalDate dateOfEvent) {
        this.studentId = studentId;
       this.guestName = guestName;
       this.eventName = eventName;
         this.eventId = eventId;
          this.dateOfEvent = dateOfEvent;
       
    }

   

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
   

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public LocalDate getDateOfEvent() {
        return dateOfEvent;
    }

    public void setDateOfEvent(LocalDate dateOfEvent) {
        this.dateOfEvent = dateOfEvent;
    }


   

    public int getGuestId() {
        return guestId;
    }

    public void setGuestId(int guestId) {
        this.guestId = guestId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public boolean isRegistered() {
        return isRegistered;
    }

    public void setIsRegistered(boolean isRegistered) {
        this.isRegistered = isRegistered;
    }

    public boolean isAttended() {
        return isAttended;
    }

    public void setIsAttended(boolean isAttended) {
        this.isAttended = isAttended;
    }

    public boolean isCancelRegister() {
        return isCancelRegister;
    }

    public void setIsCancelRegister(boolean isCancelRegister) {
        this.isCancelRegister = isCancelRegister;
    }

    @Override
    public String toString() {
        return "EventGuest{" + "guestId=" + guestId + ", eventId=" + eventId + ", guestName=" + guestName + ", eventName=" + eventName + ", dateOfEvent=" + dateOfEvent + ", isRegistered=" + isRegistered + ", isAttended=" + isAttended + ", isCancelRegister=" + isCancelRegister + '}';
    }

   


}
