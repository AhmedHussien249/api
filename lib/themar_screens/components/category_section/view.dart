import 'package:api/core/logic/dio_helper.dart';
import 'package:api/themar_screens/components/category_section/cubit.dart';
import 'package:api/themar_screens/components/category_section/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/designs/app_images.dart';
import 'models.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  //
  // void initState() {
  //   getData();
  //   super.initState();
  // }
  //


  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (context) => CategoriesCubit()..getData(),
     child: Builder(builder: (context) {
       CategoriesCubit cubit = BlocProvider.of(context);
       return BlocBuilder(
         bloc: cubit,
         builder: (context, state) {
         if (state is CategoriesLoadingState) {
           return SizedBox(height: 128,
             child: Center(
               child: CircularProgressIndicator(),
             ),
           );
         } else if (state is CategoriesErrorState) {
           return SizedBox(height: 128,
             child: Column(
               children: [
                 Center(
                   child: Text(
                     "${cubit.response.message ?? "failed try again"}",
                     style: TextStyle(color: Colors.red),
                   ),
                 ),
                 FilledButton(
                   onPressed: () => cubit.getData(),
                   child: Text("اعادة المحاولة"),
                 )
               ],
             ),
           );
         } else if (cubit.model.list.isEmpty) {
           return SizedBox.shrink();
         }
         return SizedBox(
           height: 128,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 16),
                 child: Text(
                   "الاقسام",
                   style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                       color: Colors.black),
                 ),
               ),
               SizedBox(
                 height: 12,
               ),
               Expanded(
                 child: ListView.separated(
                   padding: EdgeInsets.symmetric(horizontal: 16),
                   scrollDirection: Axis.horizontal,
                   separatorBuilder: (context, index) => SizedBox(
                     width: 45,
                   ),
                   itemCount: cubit.model.list.length,
                   itemBuilder: (context, index) => Column(
                     children: [
                       Expanded(
                         child: AppImages(
                           cubit.model.list[index].image,
                           height: 70,
                           width: 70,
                           fit: BoxFit.cover,
                         ),
                       ),
                       Text(
                         "${cubit.model.list[index].name}",
                         style: TextStyle(
                             fontSize: 12,
                             fontWeight: FontWeight.bold,
                             color: Colors.black),
                       ),
                     ],
                   ),
                 ),
               ),
             ],
           ),
         );
       },);

     },
     ),
   );
  }
}
