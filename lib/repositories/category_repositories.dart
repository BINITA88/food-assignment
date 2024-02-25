import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository{
  CollectionReference<CategoryModel> categoryRef = FirebaseService.db.collection("category")
      .withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) {
      return CategoryModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
    Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if(!hasData){
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>>  getCategory(String categoryId) async {
      try{
        print(categoryId);
        final response = await categoryRef.doc(categoryId).get();
        return response;
      }catch(e){
        rethrow;
      }
  }

  List<CategoryModel> makeCategory(){
      return [
        CategoryModel(categoryName: "Pasta", status: "active", imageUrl: "https://img.freepik.com/free-photo/pasta-with-zucchini-sweet-peppers-with-basil-garlic-dressing_2829-17952.jpg?w=996&t=st=1708190635~exp=1708191235~hmac=07ab649cbd63bfa1159f0bd1c0a349c29d776c148d807abff00a35269fe80fd6"),
        CategoryModel(categoryName: "Momo", status: "active", imageUrl: "https://images.pexels.com/photos/955137/pexels-photo-955137.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        CategoryModel(categoryName: "Pizza", status: "active", imageUrl: "https://images.pexels.com/photos/845811/pexels-photo-845811.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        CategoryModel(categoryName: "Burger", status: "active", imageUrl: "https://images.pexels.com/photos/918581/pexels-photo-918581.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        CategoryModel(categoryName: "Sweet", status: "active", imageUrl: "https://images.pexels.com/photos/808941/pexels-photo-808941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1ssss"),
      ];
  }



}