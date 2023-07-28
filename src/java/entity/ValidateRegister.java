/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class ValidateRegister {
    public String checkUserName(String username){
        if(username.equals("")) return "Please enter username!";
        String regex = "^[a-zA-Z]{1,1}([a-zA-Z0-9_]{0,9})$";
        if (!username.matches(regex)){
            return "Username is not in the correct format";
        }
        return "correct";
    }
    
    public String checkPassword(String password){
        if(password.equals("")) return "Please enter password!";
        String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!])[0-9a-zA-Z@#$%!]{6,20}$";
        if (!password.matches(regex)){
            return "Password is not in the correct format";
        }
        return "correct";
    }
    public String checkPhoneNumber(String phonenumber){
        if(phonenumber.equals("")) return "Please enter phone number!";
        String regex = "^[0-9]{8,11}$";
        if (!phonenumber.matches(regex)){
            return "Phone number is invalid!";
        }
        return "correct";
    }
}
