'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "abb2b7ccfd1b7b93585a2dd8c8b35860",
"assets/AssetManifest.bin.json": "93b122f43bf900e5950059876bc71020",
"assets/AssetManifest.json": "338981dd7edd406868492a552293c2a4",
"assets/FontManifest.json": "74b848912171c4193da77618eccac63d",
"assets/fonts/MaterialIcons-Regular.otf": "02fcb53bb4a62e6ebf1df26263ae52bb",
"assets/NOTICES": "830ef353bc6618f418fd9b03d00a0a45",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/im_stepper/assets/me.jpg": "487511e754834bdf2e6771376d59707e",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "3759b2f7a51e83c64a58cfe07b96a8ee",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/src/fonts/BebasNeue/BebasNeue-Regular.ttf": "b2b293064f557c41411aac04d6f6710d",
"assets/src/fonts/Montserrat/Montserrat-Italic.ttf": "5b315bd5a3b7fa34eef7dfd5786b90b0",
"assets/src/fonts/Montserrat/Montserrat.ttf": "52a37115b1d8d5d6ae0b0e373e692c9d",
"assets/src/fonts/PassionOne/PassionOne-Black.ttf": "ad702d5d1d2f7495c5d1b60aec91c68b",
"assets/src/fonts/PassionOne/PassionOne-Bold.ttf": "20df97aa8f4d50499916be38d63fe540",
"assets/src/fonts/PassionOne/PassionOne-Regular.ttf": "072e0d0fe8689a237ed00cfe5c9f39bc",
"assets/src/fonts/Righteous/Righteous-Regular.ttf": "77fa00996ecb4104c7880b8749c7c4e0",
"assets/src/images/abnt_codigo.png": "2b9ba8b9958a331317acaa7eb3bdf638",
"assets/src/images/btn_nova_turma.PNG": "61999beaa700f5115227e996cb054bfc",
"assets/src/images/cefet.png": "ec02b1d9b2b7148195e64a1137ad7022",
"assets/src/images/cnpq.png": "221f864bc7df62beb59b1e32c2909a41",
"assets/src/images/coruja.png": "73449faecfdda7d64ad5abf9f759f04e",
"assets/src/images/coruja_cartola.png": "230099932d26449b5f5d4e5988e24c50",
"assets/src/images/coruja_login.png": "00304b95b76ddb41bca95c94382a08b1",
"assets/src/images/coruja_mago.png": "dc4457ad91c0aa11cdfbcd3c9f3ae542",
"assets/src/images/coruja_mago_falando.png": "dbd1f0b7630d0b5015bf3ed771e0dd74",
"assets/src/images/coruja_prof.png": "ee447a1752a803dcdc913420fbe2cd60",
"assets/src/images/criando_turma.PNG": "4e70f5a2f297a46709dca279fa54e7b4",
"assets/src/images/estrelas.png": "8673c869f4574d4bacb873847bad7a83",
"assets/src/images/fapemig.png": "6743befa6a0b0f4f67a94a4593ff4d77",
"assets/src/images/folha.png": "2026d4eb334f2b175cd9e8937c4537af",
"assets/src/images/folhaFinal.png": "77a9a77bb2640f8965960b060ed27562",
"assets/src/images/img-default.jpg": "ea0d26c409605c6e3acf0a15a8b812d7",
"assets/src/images/livro.png": "4736860ddaf7c2a0d4e76e7ba69a63ce",
"assets/src/images/mesa.png": "c5f92f95aae59f1e84e768d9951f2c09",
"assets/src/images/profept.png": "b296bc9762a985e543c1c97f02df81ff",
"assets/src/images/quadro.png": "f18708a65b0af7c11aebec223fc3e5a9",
"assets/src/images/ranking_alunos.PNG": "0d693406b0a354dffab755e15f95f576",
"assets/src/images/tela_criar_nova_turma.png": "ddc04c3dd51eaaa05cc803664bb9513c",
"assets/src/images/tela_inicial.png": "93f2ab21d26688ad18ecb8405d080133",
"assets/src/images/ver_turma.PNG": "d29c2da472adc379ab27ef166fe96cd7",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.ico": "6328807800f07c39924aeda39edba5f0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "2ce652a7014b278ff44be426da668ce8",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "fb8bf1096d66e8996794aef064595214",
"/": "fb8bf1096d66e8996794aef064595214",
"main.dart.js": "155d40d1efe81405fa1178f5d9724d9f",
"manifest.json": "36a321dbaa39836d7842d471ac143b58",
"version.json": "9e30e72484bdf47f31a9a3f14ff6a627"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
