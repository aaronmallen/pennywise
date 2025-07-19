document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.getElementById("sidebar")

  if (!sidebar) return

  const toggleButton = document.getElementById("sidebar-toggle")
  const mobileToggle = document.getElementById("mobile-menu-toggle")
  const mobileClose = document.getElementById("mobile-close")
  const mobileOverlay = document.getElementById("mobile-overlay")
  const toggleIcon = toggleButton?.querySelector("i")
  const sidebarTexts = document.querySelectorAll(".sidebar-text")

  const isDesktop = toggleButton !== null

  if (isDesktop) {
    const savedState = localStorage.getItem("sidebarCollapsed")
    let isCollapsed = savedState === "true"

    if (isCollapsed) {
      sidebar.classList.add("sidebar-collapsed")
      toggleIcon?.classList.add("rotate-180")
      sidebarTexts.forEach(text => (text.style.display = "none"))
    }

    toggleButton.addEventListener("click", function () {
      if (isCollapsed) {
        sidebar.classList.remove("sidebar-collapsed")
        toggleIcon?.classList.remove("rotate-180")

        setTimeout(() => {
          sidebarTexts.forEach(text => (text.style.display = "block"))
        }, 100)

        isCollapsed = false
        localStorage.setItem("sidebarCollapsed", "false")
      } else {
        sidebarTexts.forEach(text => (text.style.display = "none"))

        setTimeout(() => {
          sidebar.classList.add("sidebar-collapsed")
          toggleIcon?.classList.add("rotate-180")
        }, 100)

        isCollapsed = true
        localStorage.setItem("sidebarCollapsed", "true")
      }
    })
  }

  function openMobileMenu() {
    if (!sidebar || !mobileOverlay) return
    sidebar.classList.remove("-translate-x-full")
    sidebar.classList.add("translate-x-0")
    mobileOverlay.classList.remove("hidden")
    mobileToggle.classList.add("hidden")
  }

  function closeMobileMenu() {
    if (!sidebar || !mobileOverlay) return
    sidebar.classList.remove("translate-x-0")
    sidebar.classList.add("-translate-x-full")
    mobileOverlay.classList.add("hidden")
    mobileToggle.classList.remove("hidden")
  }

  mobileToggle?.addEventListener("click", openMobileMenu)
  mobileClose?.addEventListener("click", closeMobileMenu)
  mobileOverlay?.addEventListener("click", closeMobileMenu)

  sidebar.addEventListener("click", function (e) {
    if (window.innerWidth < 1024 && e.target.closest("a")) {
      closeMobileMenu()
    }
  })
})
