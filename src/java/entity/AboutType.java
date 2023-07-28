/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Nguyen Minh
 */
public class AboutType {
    private int id;
    private String type;
    private String type_vn;

    public AboutType() {
    }

    public AboutType(int id, String type, String type_vn) {
        this.id = id;
        this.type = type;
        this.type_vn = type_vn;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType_vn() {
        return type_vn;
    }

    public void setType_vn(String type_vn) {
        this.type_vn = type_vn;
    }
    
    
}
