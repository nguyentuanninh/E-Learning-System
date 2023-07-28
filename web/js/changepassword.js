/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function viewpassword() {
    var view = document.getElementById('password');
    var view1 = document.getElementById('repassword');
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
    let password = document.querySelector('#pnum');
    let repassword = document.querySelector('#repassword');

    let checkvalidate = true;

    let username_err = document.querySelector('#username_err');
    let pword_err = document.querySelector('#pword_err');
    let repword_err = document.querySelector('#repword_err');

    username_err.innerHTML = "";
    pword_err.innerHTML = "";
    repword_err.innerHTML = "";

    let username_regex = /^[a-zA-Z]{1,1}([a-zA-Z0-9_]{1,9})$/;
    let pword_regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!])[0-9a-zA-Z@#$%!]{6,20}$/;
    if (username.value.trim().length === 0) {
        username_err.innerHTML = 'Please enter username';
        checkvalidate = false;
    } else if (!username_regex.test(username.value.trim())) {
        username_err.innerHTML = 'Incorrect format!';
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

function resetPassword() {

    let password = document.querySelector('#password');
    let repassword = document.querySelector('#repassword');

    let checkvalidate = true;
    let pword_err = document.querySelector('#pword_err');
    let repword_err = document.querySelector('#repword_err');
    pword_err.innerHTML = "";
    repword_err.innerHTML = "";

    let pword_regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!])[0-9a-zA-Z@#$%!]{6,20}$/;

    
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
