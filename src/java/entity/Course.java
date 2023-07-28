/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class Course {

    private int id;
    private String name;
    private String slug;
    private String image;
    private String description;
    private float price;
    private int category;
    private Integer numberEnrolled;
    private int levelId;
    private String objectives;
    private Date createdAt;
    private Date modifiedAt;
    private int modified_by;
    private Date approve_at;
    private boolean disabled;

    public Course() {
    }

    public Course(int id, String name, String slug, String image, String description, float price, int category, Integer numberEnrolled, int levelId, String objectives, Date createdAt, Date modifiedAt, int modified_by, Date approve_at, boolean disabled) {
        this.id = id;
        this.name = name;
        this.slug = slug;
        this.slug = slug;
        this.image = image;
        this.description = description;
        this.price = price;
        this.category = category;
        this.numberEnrolled = numberEnrolled;
        this.levelId = levelId;
        this.objectives = objectives;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.modified_by = modified_by;
        this.approve_at = approve_at;
        this.disabled = disabled;
        this.disabled = disabled;
    }

    public Course(int courseId, String name, String string, String description, float price, int catogory, int i, int i0, int level, String objective, Date date, Date date0, boolean b, int i1, Object object) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public Integer getNumberEnrolled() {
        return numberEnrolled;
    }

    public void setNumberEnrolled(Integer numberEnrolled) {
        this.numberEnrolled = numberEnrolled;
    }

    public int getLevelId() {
        return levelId;
    }

    public void setLevelId(int levelId) {
        this.levelId = levelId;
    }

    public String getObjectives() {
        return objectives;
    }

    public void setObjectives(String objectives) {
        this.objectives = objectives;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getModifiedAt() {
        return modifiedAt;
    }

    public void setModifiedAt(Date modifiedAt) {
        this.modifiedAt = modifiedAt;
    }

    public int getModified_by() {
        return modified_by;
    }

    public void setModified_by(int modified_by) {
        this.modified_by = modified_by;
    }

    public Date getApprove_at() {
        return approve_at;
    }

    public void setApprove_at(Date approve_at) {
        this.approve_at = approve_at;
    }

    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

}
