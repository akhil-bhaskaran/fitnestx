import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/model/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  final CollectionReference userProfileCollection = FirebaseFirestore.instance
      .collection('user_profiles');

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Create or update user profile
  Future<void> saveUserProfile(UserProfile profile) async {
    if (currentUserId != null) {
      return await userProfileCollection
          .doc(currentUserId)
          .set(profile.toMap());
    }
  }

  //Fetching user data
  Future<UserProfile?> getUserProfile() async {
    if (currentUserId != null) {
      DocumentSnapshot doc =
          await userProfileCollection.doc(currentUserId).get();

      if (doc.exists) {
        return UserProfile.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Stream<UserProfile?> streamUserProfile() {
    if (currentUserId != null) {
      return userProfileCollection.doc(currentUserId).snapshots().map((doc) {
        if (doc.exists) {
          return UserProfile.fromMap(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
        }
        return null;
      });
    }
    return Stream.value(null);
  }
}
