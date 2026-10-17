document.getElementById("year").textContent = new Date().getFullYear();

// Returning visitors may still have the old app's service worker from when the
// app lived here; registering sw.js replaces it, and it then removes itself.
if ("serviceWorker" in navigator) {
  navigator.serviceWorker.getRegistrations().then((regs) => {
    if (regs.length) navigator.serviceWorker.register("/sw.js");
  });
}
