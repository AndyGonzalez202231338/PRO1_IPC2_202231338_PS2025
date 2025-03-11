/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package persistence;

import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author andy
 */
public abstract class CrudDAO<T>{
    public abstract T insert(T entity) throws SQLException;
    public abstract T findById(String id) throws SQLException;//string en id
    public abstract List<T> findAll() throws SQLException;
    public abstract void update(T entity) throws SQLException;
    public abstract void delete(String id) throws SQLException;//string en id
    
}
