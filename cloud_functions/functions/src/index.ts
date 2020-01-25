import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const db = admin.firestore();
export const newPostTrigger = functions.firestore
  .document(`posts/{postId}/comments/{commentId}`)
  .onCreate(async (snap, context) => {
    const batch = db.batch();

    let newCommentCount = 1;
    // const data = snap.data();

    const postData = await db.doc(`posts/${context.params.postId}`).get();
    console.log(postData);

    if (postData.exists) {
      const data = postData.data();
      //   console.log(data);

      if (data != null && data.commentCount != null) {
        newCommentCount = data.commentCount + 1;
      }
    }

    batch.update(db.doc(`posts/${context.params.postId}`), {
      commentCount: newCommentCount
    });

    // if (data != null && data.posterId != null) {
    //   batch.update(db.doc(`posts/${context.params.postId}`), {
    //     followers: admin.firestore.FieldValue.arrayUnion([data.posterId])
    //   });
    // }

    return batch.commit();
  });
