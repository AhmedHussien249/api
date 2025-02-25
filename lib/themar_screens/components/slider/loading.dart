part of 'view.dart';

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 232.h,
        margin:  EdgeInsets.symmetric(horizontal: 16.h).copyWith(top: 16.w),
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey,
                ),
              ),
            ),
             SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsetsDirectional.only(end: index != 4.w ? 8.w : 0),
                  child: CircleAvatar(radius: 6, backgroundColor: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
