/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package com.fuem.enums;

/**
 *
 * @author hoang hung
 */
public enum Role {
    ADMIN {
        @Override
        public String toString() {
            return "Admin";
        }
    },
    CLUB {
        @Override
        public String toString() {
            return "Club";
        }
    },
    STUDENT {
        @Override
        public String toString() {
            return "Student";
        }
    },
}
