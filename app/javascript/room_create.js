window.addEventListener('load', function(){
  const roomInput = document.getElementById("room_input")
  const roomNameCreate = document.getElementById("room-name-create")
  roomInput.addEventListener('click', function() {
    if (roomNameCreate.getAttribute("style") == "display:block;") {
      roomNameCreate.removeAttribute("style")
    } else {
      roomNameCreate.setAttribute("style", "display:block;")
    }
  })
})