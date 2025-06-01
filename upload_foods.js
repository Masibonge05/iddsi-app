const admin = require("firebase-admin");
const fs = require("fs");

// Load your service account key JSON
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// Load food data
const foodData = JSON.parse(fs.readFileSync("foods.json"));

async function uploadFoods() {
  const batch = db.batch();
  const foodCollection = db.collection("foods");
  const notifCollection = db.collection("notifications");

  foodData.forEach((food) => {
    const docRef = foodCollection.doc(); // Auto-generate ID
    batch.set(docRef, food);

    const notifRef = notifCollection.doc();
    batch.set(notifRef, {
      foodId: docRef.id,
      foodName: food.name,
      changeType: "added",
      message: `${food.name} was added`,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  await batch.commit();
  console.log("✅ All foods and notifications uploaded successfully!");
}

uploadFoods().catch((err) => console.error("❌ Upload failed:", err));

