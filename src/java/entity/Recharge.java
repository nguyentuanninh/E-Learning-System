/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author MSII
 */
public class Recharge {

    private int id;
    private int userId;
    private String status;
    private Timestamp rechargeDate;
    private int amout;
    private String bankAccount;
    private String description;

    public Recharge() {
    }

    public Recharge(int id, int userId, String status, Timestamp rechargeDate, int amout, String bankAccount, String description) {
        this.id = id;
        this.userId = userId;
        this.status = status;
        this.rechargeDate = rechargeDate;
        this.amout = amout;
        this.bankAccount = bankAccount;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getRechargeDate() {
        return rechargeDate;
    }

    public void setRechargeDate(Timestamp rechargeDate) {
        this.rechargeDate = rechargeDate;
    }

    public int getAmout() {
        return amout;
    }

    public void setAmout(int amout) {
        this.amout = amout;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
