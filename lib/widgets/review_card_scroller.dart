import 'dart:async';
import 'package:abmfbnigeria/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewCardScroller extends StatefulWidget {
  const ReviewCardScroller({super.key});

  @override
  State<ReviewCardScroller> createState() => _ReviewCardScroller();
}

class _ReviewCardScroller extends State<ReviewCardScroller>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _pageViewController = PageController();
    _tabController = TabController(length: 2, vsync: this);
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_tabController.index < 1) {
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
          child: PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: const <Widget>[
              Row(
                children: [
                  ReviewCard(
                    nameAndRole: 'ADESANMI A. / Vendor',
                    whatTheySaid:
                        'AB has been very helpful in my business. The staff are very kind and go the extra length to even give me financial advice about my business. AB should keep up the good work.',
                  ),
                  ReviewCard(
                    nameAndRole: 'Titilayo O. / Sales Woman',
                    whatTheySaid:
                        'I took my first loan with AB in Dec. 2020. I didn’t believe the process could be so fast. I got my loan in 3 days and I was very happy with that. I was able to get a bigger mixer for my business and this increased the volume of my production. I was also able to fix one of my delivery bikes that were bad. My business has improved and I look forward to doing more business with AB.',
                  ),
                  ReviewCard(
                    nameAndRole: 'BALIKIS A. / Web designer',
                    whatTheySaid:
                        'AB has been of great help to my business. That I have a success story today in my business is AB ooooo. I have never regretted knowing AB',
                  )
                ],
              ),
              Row(
                children: [
                  ReviewCard(
                    nameAndRole: 'STELLA E. / Business Woman',
                    whatTheySaid:
                        'I am a good customer with AB. The bank has been very supportive especially in my business. I also appreciate the bank because they are very considerate and understanding. The bank has really helped my business and I am very happy.',
                  ),
                  ReviewCard(
                    nameAndRole: 'MATTHEW N. / Business Owner',
                    whatTheySaid:
                        'I have been taking loans from AB Microfinance bank for a long time, and I am very happy with the bank. The bank has been helping my business. Whenever I have financial challenges in my business AB is the bank I go to and I always get the financial help I need. ',
                  ),
                  ReviewCard(
                    nameAndRole: 'CHIGOZIE N. / Marketing',
                    whatTheySaid:
                        'I have been a customer of AB for over 10 years now. I started with a loan of N270,000 but now my business has grown so much I take more than 2 million in loan from AB. I am grateful to AB because they are the story behind the success of my business today',
                  )
                ],
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
        for (int i = 0; i < 3; i++)
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
