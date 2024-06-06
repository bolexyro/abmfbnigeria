import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ImageScroller extends StatefulWidget {
  const ImageScroller({super.key});

  @override
  State<ImageScroller> createState() => _ImageScrollerState();
}

class _ImageScrollerState extends State<ImageScroller>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _pageViewController = PageController();
    _tabController = TabController(length: 4, vsync: this);
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_tabController.index < 3) {
        _tabController.animateTo(_tabController.index + 1);
      } else {
        _tabController.animateTo(0);
      }
      _pageViewController.animateToPage(
        _tabController.index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 570,
          child: PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: <Widget>[
              Image.asset(
                'assets/images/whistle.jpg',
                fit: BoxFit.fill,
              ),
              Image.asset(
                'assets/images/image1.jpg',
                fit: BoxFit.fill,
              ),
              Image.asset(
                'assets/images/image2.jpg',
                fit: BoxFit.fill,
              ),
              Image.asset(
                'assets/images/image3.jpg',
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageIndex(
                  key: ValueKey(_currentPageIndex),
                  currentIndex: _currentPageIndex,
                  tabController: _tabController,
                  pageViewController: _pageViewController,
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
        // PageIndica
      ],
    );
  }
}

class PageIndex extends StatefulWidget {
  const PageIndex({
    super.key,
    required this.tabController,
    required this.pageViewController,
    required this.currentIndex,
  });

  final TabController tabController;
  final int currentIndex;
  final PageController pageViewController;

  @override
  State<PageIndex> createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex> {
  void _updateCurrentPageIndex(int index) {
    widget.tabController.index = index;
    widget.pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  late int _coloredIndex;
  @override
  void initState() {
    _coloredIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 4; i++)
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _updateCurrentPageIndex(i);
                    setState(() {
                      _coloredIndex = i;
                    });
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.grey),
                      color: _coloredIndex == i
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              const Gap(10),
            ],
          )
      ],
    );
  }
}
