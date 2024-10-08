/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package com.fuem.enums;

/**
 *
 * @author hoang hung
 */
public enum Gender {
    MALE {
        @Override
        public String toString() {
            return "Male";
        }
    },
    FEMALE {
        @Override
        public String toString() {
            return "Female";
        }
    },
    OTHER {
        @Override
        public String toString() {
            return "Other";
        }
    };
}
