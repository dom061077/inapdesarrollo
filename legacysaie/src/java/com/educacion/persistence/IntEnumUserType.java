package com.educacion.persistence;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.educacion.enums.alumno.TipoDocumentoEnumType;
import org.hibernate.*;
import org.hibernate.util.ReflectHelper;
import org.hibernate.usertype.EnhancedUserType;
import org.hibernate.usertype.ParameterizedType;

/**
 * Created by IntelliJ IDEA.
 * User: danielmedina
 * Date: 30/05/13
 * Time: 11:57
 * To change this template use File | Settings | File Templates.
 */
public class IntEnumUserType implements EnhancedUserType, ParameterizedType {
    private Class<Enum> enumClass;

    public void setParameterValues(Properties parameters) {
        String enumClassName = parameters.getProperty("enumClassname");
        try {
            enumClass = ReflectHelper.classForName(enumClassName);
        }
        catch (ClassNotFoundException cnfe) {
            throw new HibernateException("Enum class not found", cnfe);
        }
    }

    public Class returnedClass() {
        return enumClass;
    }

    public int[] sqlTypes() {
        return new int[] { Hibernate.SHORT.sqlType() };
    }

    public boolean isMutable() {
        return false;
    }

    public Object deepCopy(Object value) {
        return value;
    }

    public Serializable disassemble(Object value) {
        return (Enum) value;
    }

    public Object replace(Object original, Object target, Object owner) {
        return original;
    }

    public Object assemble(Serializable cached, Object owner) {
        return cached;
    }

    public boolean equals(Object x, Object y) {
        return x==y;
    }

    public int hashCode(Object x) {
        return x.hashCode();
    }

    public Object fromXMLString(String xmlValue) {
        return Enum.valueOf(enumClass, xmlValue);
    }

    public String objectToSQLString(Object value) {
        return '\'' + ( (Enum) value ).name() + '\'';
    }

    public String toXMLString(Object value) {
        return ( (Enum) value ).name();
    }

    public Object nullSafeGet(ResultSet rs, String[] names, Object owner)
            throws SQLException {
        Integer ordinal = rs.getInt( names[0] );
        TipoDocumentoEnumType.values()
        for
        return rs.wasNull() ? null : Enum.get valueOf(enumClass, name);
    }

    public void nullSafeSet(PreparedStatement st, Object value, int index)
            throws SQLException {
        if (value==null) {
            st.setNull(index, Hibernate.STRING.sqlType());
        }
        else {
            st.setString( index, ( (Enum) value ).name() );
        }
    }

}