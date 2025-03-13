/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author andy
 */
public class Usuario {
    private int id;
    private String nombre;
    private String password;
    private Integer roleId;

    public Usuario(int id, String nombre, String password, Integer roleId) {
        this.id = id;
        this.nombre = nombre;
        this.password = password;
        this.roleId = roleId;
    }

    public Usuario(String nombre, String password, Integer roleId) {
        this.nombre = nombre;
        this.password = password;
        this.roleId = roleId;

    }

    public Usuario() {
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

     public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "Usuario{" + "id=" + id + ", nombre=" + nombre + ", password=" + password + ", roleId=" + roleId + '}';
    }
   
    
}
