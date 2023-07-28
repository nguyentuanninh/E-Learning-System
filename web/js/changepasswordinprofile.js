/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function checkValidate() {
    let password = document.querySelector('#pword');
    let newpassword = document.querySelector('#newpword');
    let repassword = document.querySelector('#repword');

    let checkvalidate = true;

//    let pword_err = document.querySelector('#pword_err');
    let newpword_err = document.querySelector('#newpword_err');
    let repword_err = document.querySelector('#repword_err');

    newpword_err.innerHTML = "";
    repword_err.innerHTML = "";
    
    let pword_regex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!])[0-9a-zA-Z@#$%!]{6,20}$/;

    if (newpassword.value.trim().length === 0) {
        newpword_err.innerHTML = 'Please enter your new password';
        checkvalidate = false;
    } else if (!pword_regex.test(newpassword.value)) {
        newpword_err.innerHTML = 'Password is invalid!';
        checkvalidate = false;
    } else if (password.value === newpassword.value) {
        newpword_err.innerHTML = 'The new password is the same as the current password!';
        checkvalidate = false;
    }

    if (repassword.value.trim().length === 0) {
        repword_err.innerHTML = 'Please confirm password again!';
        checkvalidate = false;
    } else if (newpassword.value !== repassword.value) {
        repword_err.innerHTML = 'Passwords do not match!';
        checkvalidate = false;
    }
    return checkvalidate;
}

function viewpassword(num) {
    var view = document.getElementById('pword');
    var view1 = document.getElementById('newpword');
    var view2 = document.getElementById('repword');
    if (num === 1) {
        if (view.type === 'text')
        {
            view.type = 'password';
        } else
        {
            view.type = 'text';
        }
    }
    else if(num === 2){
        if (view1.type === 'text')
        {
            view1.type = 'password';
        } else
        {
            view1.type = 'text';
        }
    }
    else if(num === 3){
        if (view2.type === 'text')
        {
            view2.type = 'password';
        } else
        {
            view2.type = 'text';
        }
    }

}


