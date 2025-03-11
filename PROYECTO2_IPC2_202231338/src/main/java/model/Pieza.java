/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author andy
 */
public class Pieza {
    private Integer ID;
    private String Nombre;
    private Double Costo;
    private Integer CantidadDisponible;

    public Pieza(Integer ID, String Nombre, Double Costo, Integer CantidadDisponible) {
        this.ID = ID;
        this.Nombre = Nombre;
        this.Costo = Costo;
        this.CantidadDisponible = CantidadDisponible;
    }

    public Pieza(String Nombre, Double Costo, Integer CantidadDisponible) {
        this.Nombre = Nombre;
        this.Costo = Costo;
        this.CantidadDisponible = CantidadDisponible;
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

    public Double getCosto() {
        return Costo;
    }

    public void setCosto(Double Costo) {
        this.Costo = Costo;
    }

    public Integer getCantidadDisponible() {
        return CantidadDisponible;
    }

    public void setCantidadDisponible(Integer CantidadDisponible) {
        this.CantidadDisponible = CantidadDisponible;
    }
    
    
}
