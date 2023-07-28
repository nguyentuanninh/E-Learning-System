const images = document.querySelectorAll(' .image img');
const slide = document.getElementById("imgNews");
const button = document.getElementById("closeSlide");
const containerSlide = document.getElementById("carouselExampleControls");
images.forEach(e => {
    e.style.cursor = "pointer";
});

images.forEach((e, index) => {
    e.addEventListener("click", () => {
        const element = document.getElementById(`slide${index}`);
        removeActive();

        element.classList.add("active");
        containerSlide.classList.toggle("d-flex");
    });
});
button.addEventListener("click", () => {
    containerSlide.classList.toggle("d-flex");
});

images.forEach((e, index) => {
    const element = document.createElement("div");
    element.classList.add("carousel-item");
    element.setAttribute("id", `slide${index}`);
    element.innerHTML = `
                      <img style="margin:0 auto" class="d-block w-75" src="${e.src}" alt="First slide">
                `;
    slide.appendChild(element);
});

function removeActive() {
    const a = document.getElementById("imgNews").children;
    for (let i of a) {
        i.classList.remove("active");
    }
}


window.onscroll = function () {
    myFunction();
};

function myFunction() {
    let winScroll = document.body.scrollTop || document.documentElement.scrollTop;
    const height = document.getElementById("content").offsetHeight;
    let scrolled = (winScroll / height) * 100;
    document.getElementById("myBar").style.width = scrolled + "%";
    if (winScroll > 120) {
        document.getElementById("progess-news").style.display = "block";
    } else {
        document.getElementById("progess-news").style.display = "none";
    }
}