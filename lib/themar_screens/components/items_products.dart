part of 'products_section.dart';


class _Item extends StatefulWidget {
  final ProductsModels model;

  const _Item({super.key, required this.model});

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
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.25),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0),
          ]),
      child: Column(
        children: [
          AppImages(
            widget.model.mainImage,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 7),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.model.title,
                  style: TextStyle(
                      fontSize: 18,
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
          SizedBox(height: 5),
          Text(
            widget.model.description,
            maxLines: 3,
            style: TextStyle(fontSize: 10, color: Colors.green),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Text(
                  "${widget.model.price}\$",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(width: 2.5),
                Text(
                  "${widget.model.priceBeforeDiscount}\$",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}