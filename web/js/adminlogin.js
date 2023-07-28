/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function viewpassword() {
    var view = document.getElementById('pword');
    if (view.type === 'text')
        view.type = 'password';
    else
        view.type = 'text';
}
function checkvalidate() {
    let username = document.querySelector('#username');
    let pword = document.querySelector('#pword');
    let username_err = document.querySelector('#username_err');
    username_err.innerHTML = "";
    let password_err = document.querySelector('#password_err');
    password_err.innerHTML = "";
    console.log(username.value.trim().length);
    let checkvalidate = true;
    if (username.value.trim().length === 0) {
        username_err.innerHTML = 'Please enter username';
        checkvalidate = false;
    }
    if (pword.value.trim().length === 0) {
        password_err.innerHTML = 'Please enter password';
        checkvalidate = false;
    }
    return checkvalidate;
}
