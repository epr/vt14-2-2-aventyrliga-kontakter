var c = document.getElementById("CloseMessage"),
    b = document.getElementById("MessageBox");
if (c) {
    c.addEventListener("click", function (e) {
        e.preventDefault();
        b.parentElement.removeChild(b);
    });
}