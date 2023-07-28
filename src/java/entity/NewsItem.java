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
public class NewsItem {    
    private int id;
    private String name;
    private String name_vn;
    private String href;
    private String slug;
    private String content;
    private String content_vn;
    private String Description;
    private Date created_date;
    private Date modified_date;
    private Date approve_date;
    private String image;
    private int parent_id;
    private int created_by;
    private int modified_by;
    private int newsgroup;

    public NewsItem() {
    }

    public NewsItem(int id, String name, String name_vn, String href, String slug, String content, String content_vn, String Description, Date created_date, Date modified_date, Date approve_date, String image, int parent_id, int created_by, int modified_by, int newsgroup) {
        this.id = id;
        this.name = name;
        this.name_vn = name_vn;
        this.href = href;
        this.slug = slug;
        this.content = content;
        this.content_vn = content_vn;
        this.Description = Description;
        this.created_date = created_date;
        this.modified_date = modified_date;
        this.approve_date = approve_date;
        this.image = image;
        this.parent_id = parent_id;
        this.created_by = created_by;
        this.modified_by = modified_by;
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

    public String getName_vn() {
        return name_vn;
    }

    public void setName_vn(String name_vn) {
        this.name_vn = name_vn;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
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

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public Date getCreated_date() {
        return created_date;
    }

    public void setCreated_date(Date created_date) {
        this.created_date = created_date;
    }

    public Date getModified_date() {
        return modified_date;
    }

    public void setModified_date(Date modified_date) {
        this.modified_date = modified_date;
    }

    public Date getApprove_date() {
        return approve_date;
    }

    public void setApprove_date(Date approve_date) {
        this.approve_date = approve_date;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getParent_id() {
        return parent_id;
    }

    public void setParent_id(int parent_id) {
        this.parent_id = parent_id;
    }

    public int getCreated_by() {
        return created_by;
    }

    public void setCreated_by(int created_by) {
        this.created_by = created_by;
    }

    public int getModified_by() {
        return modified_by;
    }

    public void setModified_by(int modified_by) {
        this.modified_by = modified_by;
    }

    public int getNewsGroup() {
        return newsgroup;
    }

    public void setNewsGroup(int newsgroup) {
        this.newsgroup = newsgroup;
    }
    
}
