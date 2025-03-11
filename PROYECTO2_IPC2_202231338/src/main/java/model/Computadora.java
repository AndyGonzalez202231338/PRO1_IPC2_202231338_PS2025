/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author andy
 */
public class Computadora {
    private Integer ID;
    private String Nombre;
    private Double PrecioVenta;

    public Computadora(Integer ID, String Nombre, Double PrecioVenta) {
        this.ID = ID;
        this.Nombre = Nombre;
        this.PrecioVenta = PrecioVenta;
    }

    public Computadora(String Nombre, Double PrecioVenta) {
        this.Nombre = Nombre;
        this.PrecioVenta = PrecioVenta;
    }

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public Double getPrecioVenta() {
        return PrecioVenta;
    }

    public void setPrecioVenta(Double PrecioVenta) {
        this.PrecioVenta = PrecioVenta;
    }
    
    
    
}
