/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author andy
 */
public class Ensamblaje_Computadora {
    private Integer ID;
    private Integer ID_Computadora;
    private String NombreUsuario;
    private Date FechaEnsamblaje;
    private Double CostoTotal;
    private String Estado;

    public Ensamblaje_Computadora(Integer ID_Computadora, String NombreUsuario, Date FechaEnsamblaje, Double CostoTotal, String Estado) {
        this.ID_Computadora = ID_Computadora;
        this.NombreUsuario = NombreUsuario;
        this.FechaEnsamblaje = FechaEnsamblaje;
        this.CostoTotal = CostoTotal;
        this.Estado = Estado;
    }

    public Ensamblaje_Computadora(Integer ID, Integer ID_Computadora, String NombreUsuario, Date FechaEnsamblaje, Double CostoTotal, String Estado) {
        this.ID = ID;
        this.ID_Computadora = ID_Computadora;
        this.NombreUsuario = NombreUsuario;
        this.FechaEnsamblaje = FechaEnsamblaje;
        this.CostoTotal = CostoTotal;
        this.Estado = Estado;
    }

    public Ensamblaje_Computadora() {
    }
    
    
    
    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public Integer getID_Computadora() {
        return ID_Computadora;
    }

    public void setID_Computadora(Integer ID_Computadora) {
        this.ID_Computadora = ID_Computadora;
    }

    public String getNombreUsuario() {
        return NombreUsuario;
    }

    public void setNombreUsuario(String NombreUsuario) {
        this.NombreUsuario = NombreUsuario;
    }

    public Date getFechaEnsamblaje() {
        return FechaEnsamblaje;
    }

    public void setFechaEnsamblaje(Date FechaEnsamblaje) {
        this.FechaEnsamblaje = FechaEnsamblaje;
    }

    public Double getCostoTotal() {
        return CostoTotal;
    }

    public void setCostoTotal(Double CostoTotal) {
        this.CostoTotal = CostoTotal;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }
    
    
    
    
}
