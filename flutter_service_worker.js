'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "24aa7a5b8c7b7b17774d3b45f95cf9be",
"manifest.json": "5d2848b42b3f021fafed5efd64d5359c",
"version.json": "b932c38f0be5c1703ef958976839cbeb",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"index.html": "03037a9880268f0f5f45fdf7730a8b94",
"/": "03037a9880268f0f5f45fdf7730a8b94",
"icons/icon-512.png": "8c5c2f4351675ade888191ae3005ba4b",
"icons/Icon-maskable-192.png": "38cc19e91003c77f736ab3573555acb9",
"icons/icon-192.png": "7fee33040cd10e15c40a290cbeee4516",
"icons/Icon-maskable-512.png": "e8c2710044479919db2c4d4959c39a51",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"assets/AssetManifest.json": "5151a26bc7620b657e19f47723a56d45",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/imgs/icon_setting.svg": "00dde8e9aae45b13f3d0a6fe750b48cb",
"assets/assets/imgs/temp_logo_main.png": "aa23897ae9b57d50d5ff411b60265c27",
"assets/assets/imgs/main_my_outlined_icon.svg": "3fc326b38be11d3788dc367c9e527f29",
"assets/assets/imgs/main_home_outlined_icon.svg": "c6ed10d896f84d0dac5455ea61abd512",
"assets/assets/imgs/main_search_outlined_icon.svg": "f2d6c4e727f2681d1b6e53ad128d21d3",
"assets/assets/imgs/icon_search.svg": "72d99d24fbb3f5a309229eebdd120235",
"assets/assets/imgs/main_upload_outlined_icon.svg": "e582ba88198f5c34302424e82c1efc18",
"assets/assets/imgs/temp_main_1.svg": "807e1c08b3d41e07bb9420dd71c0da1e",
"assets/assets/imgs/icon_arrow_left.svg": "682fc5e5dbde6f509e61a2a5aee4d8d6",
"assets/assets/imgs/icon_base_ranking.svg": "9081f4240bf936187a4ee8a6dcbd0e41",
"assets/assets/imgs/icon_my_heart.svg": "3f04b057ef70e7a7250cc37d3fd91df1",
"assets/assets/imgs/temp_main_2.svg": "6fc77502fc925c9bd8c18c705333ec2f",
"assets/assets/imgs/home_line_top_right.svg": "139e5bdef74597d7739b2add43c0a2ea",
"assets/assets/imgs/temp_logo_sub.svg": "954ce81558bd193ee10d7f45169aa5ed",
"assets/assets/imgs/gallery_background/gallery_stillLife.svg": "79e952ac2cbaa45c70e849121ae5c996",
"assets/assets/imgs/gallery_background/gallery_drawing.svg": "492afc6404ed9dc75e43f63bd497736c",
"assets/assets/imgs/gallery_background/gallery_landscape.svg": "b293265a5709b1458ec2d0fb28a66a24",
"assets/assets/imgs/gallery_background/gallery_illustration.svg": "4df1c999fcc1797426575bd0168bd2d9",
"assets/assets/imgs/gallery_background/gallery_portrait.svg": "71c38bc91141e3cd57d6451912bc5ab0",
"assets/assets/imgs/temp_upload_icon.svg": "b9dc7badef57c7c929c4bc918ee5a693",
"assets/assets/imgs/icon_like.svg": "76323bc61273efdd1c4b2bec9cb044d3",
"assets/assets/imgs/icon_arrow_right.svg": "e3ed0b66c3915985718bd15bed193be6",
"assets/assets/imgs/main_favorite_filled_icon.svg": "b765bcc679985874eb0b6e7e0423e204",
"assets/assets/imgs/main_my_filled_icon.svg": "9f57442f168b9cfa4564e501e78d8ad9",
"assets/assets/imgs/no_profile.svg": "257b742ae6c67327f992a9cf6fe7d2d4",
"assets/assets/imgs/icon_my_message.svg": "de9f205ea5667ed364de8be65508237d",
"assets/assets/imgs/main_favorite_outlined_icon.svg": "c94bac6892e95081e90395d321eeaa0d",
"assets/assets/imgs/icon_clear.svg": "b2d68b155292ac48ab19830d6738a4ca",
"assets/assets/imgs/main_btn_resource/text_stillLife.svg": "7c8889f19500887567bc11c2d8912643",
"assets/assets/imgs/main_btn_resource/right_line_drawing.svg": "4b4702a300c302f672a9127ae072722a",
"assets/assets/imgs/main_btn_resource/text_drawing.svg": "25cd663626b739ade551d980c0411cd2",
"assets/assets/imgs/main_btn_resource/text_portrait.svg": "0088979db3014f9a9b754542b8ea2008",
"assets/assets/imgs/main_btn_resource/left_line_portrait.svg": "d45eb589279fc89d67fa6e02a17d828f",
"assets/assets/imgs/main_btn_resource/right_line_illustration.svg": "f243d7d00407063c04ab0b2fbc5b7a21",
"assets/assets/imgs/main_btn_resource/left_line_illustration.svg": "c13e2e033b8b9c7802267e4dfd8ef43f",
"assets/assets/imgs/main_btn_resource/left_line_landscape.svg": "5f1ade97e2fb216b363942413942d97b",
"assets/assets/imgs/main_btn_resource/left_line_drawing.svg": "3d62da03a275105e14ee2a8b3e97f9e8",
"assets/assets/imgs/main_btn_resource/text_illustration.svg": "01a731a63aeea89bacb923ca9d7d31e5",
"assets/assets/imgs/main_btn_resource/text_landscape.svg": "2f8d87d76d475d84d028dcfc8bb21ae3",
"assets/assets/imgs/main_btn_resource/left_line_stillLife.svg": "07f9335029c89a84761fa0be6de526ac",
"assets/assets/imgs/main_search_filled_icon.svg": "27966f19336552d4fc1a8abff4bd0e37",
"assets/assets/imgs/icon_unlike.svg": "d9a9ae2353880d28d73c54840ac478aa",
"assets/assets/imgs/profile_none.svg": "257b742ae6c67327f992a9cf6fe7d2d4",
"assets/assets/imgs/home_line_bottom_right.svg": "b650b16c618d7eb4c3810b8dc4a4863b",
"assets/assets/imgs/main_home_filled_icon.svg": "b0dcc9d157124406854f807879691226",
"assets/assets/fonts/SpoqaHanSansNeo-Thin.ttf": "adf58f1a8984702afc3f42a694e1bd76",
"assets/assets/fonts/SpoqaHanSansNeo-Bold.ttf": "44915dd2aa382dd0825979edb58f9bce",
"assets/assets/fonts/SpoqaHanSansNeo-Medium.ttf": "1dfa0cf43aa2bb4bccfcb1205d7d8aca",
"assets/assets/fonts/SpoqaHanSansNeo-Light.ttf": "9bc693a211b5d25df7cdd1dc6400ec14",
"assets/assets/fonts/SpoqaHanSansNeo-Regular.ttf": "8c97bfe4fcf47c1060fae39c0a081056",
"assets/NOTICES": "77cfa26ec4332e5b11cc603a34130750",
"assets/FontManifest.json": "758b866736788e5b5ceceb4643aa150d",
"splash/style.css": "cd30508a4441bc532f86a25fe31dc55e",
"splash/img/light-4x.png": "016a08c95f775d24ccafd23fe41f2a03",
"splash/img/dark-3x.png": "b0168b182e3ecd415310513ba2280ef9",
"splash/img/dark-1x.png": "df2c8947c03732d2713b110f380734e0",
"splash/img/dark-2x.png": "1c1a1099dd8ccfd5fb2f2c8debe63363",
"splash/img/dark-4x.png": "016a08c95f775d24ccafd23fe41f2a03",
"splash/img/light-3x.png": "b0168b182e3ecd415310513ba2280ef9",
"splash/img/light-1x.png": "df2c8947c03732d2713b110f380734e0",
"splash/img/light-2x.png": "1c1a1099dd8ccfd5fb2f2c8debe63363",
"splash/splash.js": "c6a271349a0cd249bdb6d3c4d12f5dcf",
"favicon.png": "d3f03ef8bf14067c72b5a97efcbf1479"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
