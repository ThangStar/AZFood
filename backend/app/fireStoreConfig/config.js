
//   const { initializeApp } = require('firebase/app');
// const { getStorage } = require('firebase/storage');

// let app;
// let storage;

// module.exports = {
//   initializeFirebase: function () {
//     if (!app) {
//       const firebaseConfig = {
//         apiKey: "AIzaSyBlfUfevkYrx60ifbY8yaaMGSOM2vCEKpg",
//             authDomain: "titanium-gantry-364905.firebaseapp.com",
//             projectId: "titanium-gantry-364905",
//             storageBucket: "titanium-gantry-364905.appspot.com",
//             messagingSenderId: "1085817696361",
//             appId: "1:1085817696361:web:2b5089fe4373071175f2f8",
//             measurementId: "G-Y387T4J8J9"
//       };

//       app = initializeApp(firebaseConfig);
//       storage = getStorage(app);
//     }
//   },

//   getStorageInstance: function () {
//     return storage;
//   }
// };
const firebaseConfig = {
    apiKey: "AIzaSyBkpRwCES_8ia0pbht1Aa9QWjtqUgrQDmg",
  authDomain: "restaurant-manager-b9f86.firebaseapp.com",
  projectId: "restaurant-manager-b9f86",
  storageBucket: "restaurant-manager-b9f86.appspot.com",
  messagingSenderId: "42701105506",
  appId: "1:42701105506:web:87ea04c3e37ff723d3a43b",
  measurementId: "G-CYX1PMPKYH"
  };
  
module.exports = {
    firebaseConfig
  };