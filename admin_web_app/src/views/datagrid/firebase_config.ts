import { initializeApp } from 'firebase/app';
import { getFirestore, Firestore } from '@firebase/firestore';

const firebaseConfig = {
  apiKey: "AIzaSyA1PkhQRGJqDprBYIIg0enyQyvc1CVS4BU",
  authDomain: "testing-a8c04.firebaseapp.com",
  projectId: "testing-a8c04",
  storageBucket: "testing-a8c04.appspot.com",
  messagingSenderId: "594261716400",
  appId: "1:594261716400:web:ad38c4bf20da07c5abfa75"
};

const app = initializeApp(firebaseConfig);
export const db: Firestore = getFirestore(app);