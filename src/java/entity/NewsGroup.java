/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class NewsGroup {
    private int id;
    private String name;
    private List<NewsItem> children = new ArrayList<>();
    public NewsGroup() {
    }

    public NewsGroup(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<NewsItem> getChildren() {
        return children;
    }

    public void setChildren(List<NewsItem> children) {
        this.children = children;
    }
    
}
