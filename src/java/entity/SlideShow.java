/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author MSII
 */
public class SlideShow {

    private int id;
    private String name;
    private String nameVn;
    private String image;
    private Date createdDate;
    private Date approveDate;
    private int createdBy;
    private int newsgroup;

    public SlideShow() {
    }

    public SlideShow(int id, String name, String nameVn, String image, Date createdDate, Date approveDate, int createdBy, int newsgroup) {
        this.id = id;
        this.name = name;
        this.nameVn = nameVn;
        this.image = image;
        this.createdDate = createdDate;
        this.approveDate = approveDate;
        this.createdBy = createdBy;
        this.newsgroup = newsgroup;
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

    public String getNameVn() {
        return nameVn;
    }

    public void setNameVn(String nameVn) {
        this.nameVn = nameVn;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Date approveDate) {
        this.approveDate = approveDate;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public int getNewsgroup() {
        return newsgroup;
    }

    public void setNewsgroup(int newsgroup) {
        this.newsgroup = newsgroup;
    }

}
