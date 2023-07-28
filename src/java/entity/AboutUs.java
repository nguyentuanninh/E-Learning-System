/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Nguyen Minh
 */
public class AboutUs {

    private int id;
    private String title;
    private String title_vn;
    private String content;
    private String content_vn;
    private Date createdDate;
    private Date modifiedDate;
    private int aboutType;

    public AboutUs() {
    }

    public AboutUs(int id, String title, String title_vn, String content, String content_vn, Date createdDate, Date modifiedDate, int aboutType) {
        this.id = id;
        this.title = title;
        this.title_vn = title_vn;
        this.content = content;
        this.content_vn = content_vn;
        this.createdDate = createdDate;
        this.modifiedDate = modifiedDate;
        this.aboutType = aboutType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle_vn() {
        return title_vn;
    }

    public void setTitle_vn(String title_vn) {
        this.title_vn = title_vn;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent_vn() {
        return content_vn;
    }

    public void setContent_vn(String content_vn) {
        this.content_vn = content_vn;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public int getAboutType() {
        return aboutType;
    }

    public void setAboutType(int aboutType) {
        this.aboutType = aboutType;
    }
}