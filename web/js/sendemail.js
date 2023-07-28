/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
const isSendEmail = () => {
    const swi = document.querySelector("#switch");
    const swiclass = document.getElementsByClassName("changevalue");
    if (swi.checked === true) {
        for (let i = 0; i < swiclass.length; i++) {
            swiclass[i].value = 1;
        }
    } 
    if(swi.checked === false){
        for (let i = 0; i < swiclass.length; i++) {
            swiclass[i].value = 0;
        }
    }
    for (let i = 0; i < swiclass.length; i++) {
        console.log(swiclass[i].value)
    }
};
