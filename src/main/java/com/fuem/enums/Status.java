/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.enums;

/**
 *
 * @author hoang hung
 */
public enum Status {
    PENDING {
        @Override
        public String toString() {
            return "Pending";
        }
    },
    APPROVED {
        @Override
        public String toString() {
            return "Approved";
        }
    },
    REJECTED {
        @Override
        public String toString() {
            return "Rejected";
        }
    },
    ON_GOING {
        @Override
        public String toString() {
            return "On going";
        }
    },
}
