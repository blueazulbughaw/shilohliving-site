// The Shiloh Living app moved to hub.shilohliving.app.
// This replaces the old app service worker on shilohliving.app and removes it.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (e) => {
  e.waitUntil((async () => {
    for (const k of await caches.keys()) await caches.delete(k);
    await self.registration.unregister();
    for (const c of await self.clients.matchAll()) c.navigate(c.url);
  })());
});
