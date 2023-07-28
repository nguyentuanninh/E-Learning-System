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
public class Enrollment {
    private int user_id;
    private int course_id;
    private Date enrolled_at;
    private float price;
    public Enrollment() {
    }

    public Enrollment(int user_id, int course_id, Date enrolled_at, float price) {
        this.user_id = user_id;
        this.course_id = course_id;
        this.enrolled_at = enrolled_at;
        this.price = price;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getCourse_id() {
        return course_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }

    public Date getEnrolled_at() {
        return enrolled_at;
    }

    public void setEnrolled_at(Date enrolled_at) {
        this.enrolled_at = enrolled_at;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
    
    
}
