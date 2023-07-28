/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */

//CREATE TABLE instructor_detail
//(
//    id     INT IDENTITY PRIMARY KEY,
//    email  nvarchar(50),
//    img    nvarchar(255),
//    [name] nvarchar(255),
//    bio    NVARCHAR(255),
//    [job]  NVARCHAR(255),
//)
public class Instructor {
    private int id;
    private String email;
    private String slug;
    private String img;
    private String name;
    private String bio;
    private String job;

    public Instructor() {
    }

    public Instructor(int id, String email, String slug, String img, String name, String bio, String job) {
        this.id = id;
        this.email = email;
        this.slug = slug;
        this.img = img;
        this.name = name;
        this.bio = bio;
        this.job = job;
    }
    

    // Getters and setters for all properties

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }
    
}
