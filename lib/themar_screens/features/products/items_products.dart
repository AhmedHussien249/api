part of 'products_view.dart';

class _Item extends StatefulWidget {
  final ProductsModels model;

  const _Item({required this.model});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.25),
                blurRadius: 4,
                offset:  const Offset(0, 4),
                spreadRadius: 0),
          ]),
      child: Column(
        children: [
          AppImages(
            widget.model.mainImage,
            height: 140.h,
            width: double.infinity.w,
            fit: BoxFit.cover,
          ),
           SizedBox(height: 7.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.model.title,
                  style:  TextStyle(
                      fontSize: 18.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    widget.model.toggleFavorite();
                    setState(() {});
                  },
                  child: Icon(
                    widget.model.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: widget.model.isFavorite ? Colors.green : null,
                  ),
                )
              ],
            ),
          ),
           SizedBox(height: 5.h),
          Text(
            widget.model.description,
            maxLines: 3,
            style:  TextStyle(fontSize: 10.sp, color: Colors.green),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 6.h),
            child: Row(
              children: [
                Text(
                  "${widget.model.price}\$",
                  style:  TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                 SizedBox(width: 2.5.w),
                Text(
                  "${widget.model.priceBeforeDiscount}\$",
                  style:  TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
           SizedBox(height: 5.h),
           Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
