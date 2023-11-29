importScripts('https://www.gstatic.com/firebasejs/9.9.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.9.0/firebase-messaging-compat.js');

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
    apiKey: "AIzaSyAIesgtDcwW11FnCq8p1xgpldvAKztOK7s",
    authDomain: "asd-ml.firebaseapp.com",
    databaseURL: "https://asd-ml-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "asd-ml",
    storageBucket: "asd-ml.appspot.com",
    messagingSenderId: "155290127830",
    appId: "1:155290127830:web:6583da14e3fa9105ab2877",
    measurementId: "G-SS4BNXP7NX"
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});