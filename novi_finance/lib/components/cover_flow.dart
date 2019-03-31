import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef void OnDismissedCallback(
    int dismissedItem, DismissDirection direction);

typedef void OnCurrentItemChangedCallback(int currentItem);

class CoverFlow extends StatefulWidget {

  final IndexedWidgetBuilder itemBuilder;

  final OnDismissedCallback dismissedCallback;

  final double viewportFraction;

  final int height;

  final int width;

  final bool dismissibleItems;

  final int itemCount;

  final int startIndex;

  final OnCurrentItemChangedCallback currentItemChangedCallback;
  final ValueNotifier<PageController> controllerValueNotifier;
  final ValueNotifier<int> goToPageNumber;


  const CoverFlow({Key key,this.goToPageNumber, @required this.itemBuilder, this.dismissibleItems: true,
    this.dismissedCallback, this.viewportFraction: .85, this.height: 525,
    this.width: 700, this.itemCount, this.startIndex, this.currentItemChangedCallback, this.controllerValueNotifier})
      : assert(itemBuilder != null), super(key: key);

  @override
  _CoverFlowState createState() => new _CoverFlowState();
}

class _CoverFlowState extends State<CoverFlow> {
  PageController controller;
  double currentPage;
  bool _pageHasChanged = false;

  @override
  initState() {
    super.initState();
    currentPage =  0;
    controller = new PageController(
      viewportFraction: 0.85,
      initialPage: widget.startIndex,
    );
    if(widget.goToPageNumber != null){
      widget.goToPageNumber.addListener((){
        controller.animateToPage(widget.goToPageNumber.value,
         duration: Duration(milliseconds: 200),
         curve: Curves.linear
        );
      });
    }
    if (widget.controllerValueNotifier != null) {
      widget.controllerValueNotifier.value = controller;
    }
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _pageHasChanged = true;
            currentPage = value.toDouble();
            if (widget.currentItemChangedCallback != null) {
              widget.currentItemChangedCallback(value);
            }
          });
        },
        controller: controller,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) => builder(index));
  }

  Widget builder(int index) {
    return new AnimatedBuilder(
        animation: controller,
        builder: (context, Widget child) {
          double result = _pageHasChanged ? controller.page : currentPage * 1.0;
          double value = result - index;

          value = (1 - (value.abs() * .2)).clamp(0.0, 1.0);
          double transformValue = (_pageHasChanged ? controller.page:0.0) - currentPage;
          if(transformValue> 0){
            transformValue = - transformValue ;
          }
          //print('$transformValue,$currentPage, $index, $_pageHasChanged');
          var actualWidget = new Center(
            child: Transform(
              child: child,
              transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateY(transformValue),
            ),
            // child:  SizedBox(
            //   height: Curves.easeOut.transform(value) * widget.height,
            //   width: Curves.easeOut.transform(value) * widget.width,
            //   child: child,
            // ),
          );
          if (!widget.dismissibleItems) return actualWidget;

          return new Dismissible(
            key: ObjectKey(child),
            direction: DismissDirection.vertical,
            child: actualWidget,
            onDismissed: (direction) {
              setState(() {
                widget.dismissedCallback(index, direction);
                controller.animateToPage(currentPage.toInt(),
                    duration: new Duration(seconds: 2), curve: Curves.easeOut);
              });
            },
          );
        },
        child: widget.itemBuilder(context, index));
  }
}