import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwell_store/features/cats/data/data.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailView extends StatefulWidget {
  static const String id = '/ProductPage';
  const DetailView({
    Key? key,
    required this.task,
  }) : super(key: key);
  final TaskModel task;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.name),
        actions: [
          16.widthBox,
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.grey.shade200],
        )),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MainProductPageProductCard(
                product: widget.task,
              ).px(24),
              16.heightBox,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     'Description'.text.semiBold.lg.make(),
              //     // const RatingWidget(rating: 4)
              //   ],
              // ).px(24),
              // widget.task.name.text.lg.make().py(12).px(24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 35,
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  if (_quantity > 1) _quantity -= 1;
                                });
                              },
                              icon: const Icon(
                                CupertinoIcons.minus_circle,
                                size: 22,
                              )),
                        ),
                        _quantity.text.xl.semiBold.make(),
                        SizedBox(
                          width: 35,
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  _quantity += 1;
                                });
                              },
                              icon: const Icon(
                                CupertinoIcons.plus_circle,
                                size: 22,
                              )),
                        ),
                        const Spacer(),
                        // 'Total: '.text.xl.make(),
                        // '\$$_quantity'.text.semiBold.xl.make(),
                      ],
                    ).px(8),
                    24.heightBox,
                    ElevatedButton(
                      child: 'Add to cart'.text.xl2.white.makeCentered().py(16),
                      onPressed: () {},
                      // borderRadius: 16,
                      // color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainProductPageProductCard extends StatefulWidget {
  const MainProductPageProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  final TaskModel product;

  @override
  State<MainProductPageProductCard> createState() =>
      _MainProductPageProductCardState();
}

class _MainProductPageProductCardState
    extends State<MainProductPageProductCard> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 0.75,
          child: Container(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.22),
                        offset: const Offset(0, 16),
                        spreadRadius: 1.5,
                        blurRadius: 32),
                  ]),
              child: Container(
                width: double.infinity,
              )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  // color: widget.product.productColors[_selectedColor],
                  borderRadius: BorderRadius.circular(24)),
              // margin: const EdgeInsets.only(
              //     left: 25, right: 25, top: 24, bottom: 32),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 340,
                    child: PageView.builder(
                      itemCount: widget.product.imageUrl.length,
                      onPageChanged: (newIndex) => setState(() {
                        _selectedImageIndex = newIndex;
                      }),
                      itemBuilder: (context, index) => AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          widget.product.imageUrl[_selectedImageIndex],
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   right: 12,
                  //   top: 12,
                  //   child: SizedBox(
                  //     height: 35,
                  //     width: 35,
                  //     child: FavouriteButton(
                  //       iconSize: 24,
                  //       onPressed: () {},
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                      bottom: 10,
                      child: DotsIndicator(
                        dotsCount: widget.product.imageUrl.length,
                        // position: _selectedImageIndex.toDouble(),
                        decorator: DotsDecorator(
                          color: Colors.black12,
                          spacing: const EdgeInsets.all(5),
                          size: const Size.square(8.0),
                          activeColor: Colors.black45,
                          activeSize: const Size.square(8),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ))
                ],
              ),
            ).p(24),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: widget.product.name.text
                          .size(24)
                          .semiBold
                          .maxLines(2)
                          .softWrap(true)
                          .make(),
                    ),
                    // SizedBox(
                    //   height: 40,
                    //   width: 90,
                    //   child: PrimaryShadowedButton(
                    //     onPressed: () {},
                    //     child: '\$${widget.product.price}'
                    //         .text
                    //         .white
                    //         .makeCentered(),
                    //     borderRadius: 12,
                    //     color: Colors.black,
                    //   ),
                    // )
                  ],
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     ColorSelector(
                //       colors: widget.product.productColors,
                //       selectedIndex: _selectedColor,
                //       updateContainerColor: _updateColor,
                //     ),
                //     'Size:'.text.gray500.make(),
                //     8.widthBox,
                //     SizedBox(
                //       height: 32,
                //       width: 32,
                //       child: PrimaryShadowedButton(
                //         child: '9'.text.white.semiBold.makeCentered(),
                //         borderRadius: 500,
                //         color: CustomColors.darkBlue,
                //         onPressed: () {},
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ).px(24).pOnly(bottom: 24)
          ],
        ),
      ],
    );
  }
}
