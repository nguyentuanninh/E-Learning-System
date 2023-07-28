/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function viewpassword() {
    var view = document.getElementById('pword');
    var view1 = document.getElementById('pword2');
    if (view.type === 'text')
    {
        view.type = 'password';
        view1.type = 'password';
    } else
    {
        view.type = 'text';
        view1.type = 'text';
    }
}

function checkValidate() {
    let username = document.querySelector('#username');
    let phonenumber = document.querySelector('#phonenumber');
    let name = document.querySelector('#name');
    let password = document.querySelector('#pword');
    let repassword = document.querySelector('#pword2');
    
    let checkvalidate = true;
    
    let username_err = document.querySelector('#username_err');
    let phonenumber_err = document.querySelector('#phone_err');
    let name_err = document.querySelector('#name_err');
    let pword_err = document.querySelector('#pword_err');
    let repword_err = document.querySelector('#repword_err');
    
    username_err.innerHTML="";
    phonenumber_err.innerHTML="";
    name_err.innerHTML="";
    pword_err.innerHTML="";
    repword_err.innerHTML="";
    let username_regex = /^[a-zA-Z]{1,1}([a-zA-Z0-9_]{0,9})$/;
    let phone_regex = /^[0-9]{8,11}$/;
    let pword_regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!])[0-9a-zA-Z@#$%!]{6,20}$/;
    if (username.value.trim().length === 0) {
        username_err.innerHTML = 'Please enter username';
        checkvalidate = false;
    } else if (!username_regex.test(username.value.trim())) {
        username_err.innerHTML = 'Incorrect format!';
        checkvalidate = false;
    }
    if (phonenumber.value.trim().length === 0) {
        phonenumber_err.innerHTML = 'Please enter phone number';
        checkvalidate = false;
    } else if (!phone_regex.test(phonenumber.value.trim())) {
        phonenumber_err.innerHTML = 'Phone number is invalid!';
        checkvalidate = false;
    }
    
    if (name.value.trim().length === 0) {
        name_err.innerHTML = 'Please enter your name';
        checkvalidate = false;
    } else if (name.value.trim().length > 20) {
        name_err.innerHTML = 'Name is so long!';
        checkvalidate = false;
    }
    if (password.value.trim().length === 0) {
        pword_err.innerHTML = 'Please enter your Password';
        checkvalidate = false;
    } else if (!pword_regex.test(password.value)) {
        pword_err.innerHTML = 'Password is invalid!';
        checkvalidate = false;
    }
//    
    if (repassword.value.trim().length === 0) {
        repword_err.innerHTML = 'Please confirm password again!';
        checkvalidate = false;
    } else if (password.value !== repassword.value) {
        repword_err.innerHTML = 'Passwords do not match!';
        checkvalidate = false;
    }
    
    
    return checkvalidate;
}

function checkValidateProfile() {
    let username = document.querySelector('#username');
    let phonenumber = document.querySelector('#pnum');
    let name = document.querySelector('#name');
    
    
    let checkvalidate = true;
    
    let username_err = document.querySelector('#username_err');
    let phonenumber_err = document.querySelector('#pnum_err');
    let name_err = document.querySelector('#name_err');
    
    username_err.innerHTML="";
    phonenumber_err.innerHTML="";
    name_err.innerHTML="";
    
    let username_regex = /^[a-zA-Z]{1,1}([a-zA-Z0-9_]{1,9})$/;
    let phone_regex = /^[0-9]{8,11}$/;
    let pword_regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!])[0-9a-zA-Z@#$%!]{6,20}$/;
    if (username.value.trim().length === 0) {
        username_err.innerHTML = 'Please enter username';
        checkvalidate = false;
    } else if (!username_regex.test(username.value.trim())) {
        username_err.innerHTML = 'Incorrect format!';
        checkvalidate = false;
    }
    if (phonenumber.value.trim().length === 0) {
        phonenumber_err.innerHTML = 'Please enter phone number';
        checkvalidate = false;
    } else if (!phone_regex.test(phonenumber.value.trim())) {
        phonenumber_err.innerHTML = 'Phone number is invalid!';
        checkvalidate = false;
    }
    
    if (name.value.trim().length === 0) {
        name_err.innerHTML = 'Please enter your name';
        checkvalidate = false;
    } else if (name.value.trim().length > 20) {
        name_err.innerHTML = 'Name is so long!';
        checkvalidate = false;
    }
    
    
    return checkvalidate;
}

