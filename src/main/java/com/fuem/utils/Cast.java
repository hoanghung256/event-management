/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuem.utils;

import com.fuem.enums.Gender;
import com.fuem.enums.Role;
import java.lang.reflect.AnnotatedArrayType;
import java.lang.reflect.AnnotatedType;
import java.lang.reflect.AnnotatedTypeVariable;
import java.lang.reflect.AnnotatedWildcardType;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class Cast {

    private static final String MODEL_MODULE = "model.";

    public static Object cast(String value) {
        String className = MODEL_MODULE + value.split("\\{")[0];
        Object o = null;

        try {
            Class<?> clazz = Class.forName(className);
            Field[] fields = clazz.getDeclaredFields();
            Object[] fieldsValue = getFieldsValue(fields, value);
            Class<?>[] parameterTypes = getParameterTypes(fields);

            System.out.println(Arrays.toString(parameterTypes));

            o = clazz.getConstructor(parameterTypes).newInstance(fieldsValue);
        } catch (ClassNotFoundException | NoSuchMethodException | InstantiationException | InvocationTargetException | IllegalAccessException | IllegalArgumentException e) {
            Logger.getLogger(Cast.class.getName()).log(Level.SEVERE, null, e);
        }

        return o;
    }

    private static Class<?>[] getParameterTypes(Field[] fields) {
        Class<?>[] parameterTypes = new Class<?>[fields.length];

        for (int i = 0; i < fields.length; i++) {
            parameterTypes[i] = Cast.castAnnotatedTypeToClass(fields[i].getAnnotatedType());
        }

        return parameterTypes;
    }

    private static Object[] getFieldsValue(Field[] fields, String input) {
        Object[] fieldsValue = new Object[fields.length];
        String trimmedInput = input.substring(input.indexOf("{") + 1, input.indexOf("}"));
        String[] keyValuePairs = trimmedInput.split(", ");

        for (int i = 0; i < fields.length; i++) {
            String value = keyValuePairs[i].split("=")[1];
            fieldsValue[i] = castValue(fields[i], value);
        }

        return fieldsValue;
    }

 private static Class<?> castAnnotatedTypeToClass(AnnotatedType annotatedType) {
    Type type = annotatedType.getType();

    if (type instanceof Class<?>) {
        return (Class<?>) type;
    } else if (type instanceof ParameterizedType) {
        return (Class<?>) ((ParameterizedType) type).getRawType();
    } else if (type instanceof AnnotatedArrayType) {
        return (Class<?>) ((AnnotatedArrayType) annotatedType).getAnnotatedGenericComponentType().getType();
    } else if (type instanceof AnnotatedTypeVariable) {
        return Object.class;
    } else if (type instanceof AnnotatedWildcardType) {
        return Object.class;
    } else {
        throw new IllegalArgumentException("Unsupported AnnotatedType: " + annotatedType);
    }
}


    private static Object castValue(Field field, String valueStr) {
        Class<?> fieldType = castAnnotatedTypeToClass(field.getAnnotatedType());

        if (fieldType == int.class || fieldType == Integer.class) {
            return Integer.valueOf(valueStr);
        } else if (fieldType == long.class || fieldType == Long.class) {
            return Long.valueOf(valueStr);
        } else if (fieldType == float.class || fieldType == Float.class) {
            return Float.valueOf(valueStr);
        } else if (fieldType == double.class || fieldType == Double.class) {
            return Double.valueOf(valueStr);
        } else if (fieldType == boolean.class || fieldType == Boolean.class) {
            return Boolean.valueOf(valueStr);
        } else if (fieldType == LocalDate.class) {
            return DateTimeConverter.stringToLocalDate(valueStr);
        } else if (fieldType == Gender.class) {
            return Gender.valueOf(valueStr);
        } else if (fieldType == Role.class) {
            return Role.valueOf(valueStr);
        } else {
            return valueStr;
        }
    }
}
