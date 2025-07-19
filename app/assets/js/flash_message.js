function dismissFlash(button) {
  const flashMessage = button.closest(".flash-message")
  if (flashMessage) {
    flashMessage.classList.add("opacity-0", "translate-y-4")
    setTimeout(function () {
      if (flashMessage.parentNode) {
        flashMessage.remove()
      }
    }, 300)
  }
}

document.addEventListener("DOMContentLoaded", function () {
  const flashMessages = document.querySelectorAll(".flash-message")

  document.addEventListener("click", function (e) {
    if (e.target.closest(".flash-dismiss")) {
      dismissFlash(e.target.closest(".flash-dismiss"))
    }
  })

  flashMessages.forEach(function (message, index) {
    setTimeout(function () {
      message.classList.remove("opacity-0", "translate-y-4")
      message.classList.add("opacity-100", "translate-y-0")
    }, index * 100)

    setTimeout(
      function () {
        if (message.parentNode) {
          dismissFlash(message.querySelector(".flash-dismiss"))
        }
      },
      15000 + index * 100,
    )
  })
})
