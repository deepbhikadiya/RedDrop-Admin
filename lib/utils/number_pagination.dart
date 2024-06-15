library number_pagination;

import 'package:flutter/material.dart';
import 'package:web_redrop/package/config_packages.dart';
import 'package:web_redrop/res/color_schema.dart';
import 'package:web_redrop/utils/responsive.dart';

class NumberPagination extends StatefulWidget {
  /// Creates a NumberPagination widget.
  const NumberPagination({
    required this.onPageChanged,
    required this.pageTotal,
    this.threshold = 10,
    this.pageInit = 1,
    this.colorPrimary = Colors.black,
    this.colorSub = Colors.white,
    this.controlButton,
    this.iconToFirst,
    this.iconPrevious,
    this.iconNext,
    this.iconToLast,
    this.fontSize = 15,
    this.fontFamily,
  });

  ///Trigger when page changed
  final Function(int) onPageChanged;

  ///End of numbers.
  final int pageTotal;

  ///Page number to be displayed first
  final int pageInit;

  ///Numbers to show at once.
  final int threshold;

  ///Color of numbers.
  final Color colorPrimary;

  ///Color of background.
  final Color colorSub;

  ///to First, to Previous, to next, to Last Button UI.
  final Widget? controlButton;

  ///The icon of button to first.
  final Widget? iconToFirst;

  ///The icon of button to previous.
  final Widget? iconPrevious;

  ///The icon of button to next.
  final Widget? iconNext;

  ///The icon of button to last.
  final Widget? iconToLast;

  ///The size of numbers.
  final double fontSize;

  ///The fontFamily of numbers.
  final String? fontFamily;

  @override
  _NumberPaginationState createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  late int rangeStart;
  late int rangeEnd;
  late int currentPage;
  late final Widget iconToFirst;
  late final Widget iconPrevious;
  late final Widget iconNext;
  late final Widget iconToLast;

  @override
  void initState() {
    this.currentPage = widget.pageInit;
    this.iconToFirst = widget.iconToFirst ?? Icon(Icons.first_page);
    this.iconPrevious = widget.iconPrevious ?? Icon(Icons.keyboard_arrow_left);
    this.iconNext = widget.iconNext ?? Icon(Icons.keyboard_arrow_right);
    this.iconToLast = widget.iconToLast ?? Icon(Icons.last_page);

    _rangeSet();

    super.initState();
  }

  Widget _defaultControlButton(Widget icon) {
    return AbsorbPointer(
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(5.0),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size(48, 48)),
          foregroundColor: MaterialStateProperty.all(widget.colorPrimary),
          backgroundColor: MaterialStateProperty.all(widget.colorSub),
        ),
        onPressed: () {},
        child: icon,
      ),
    );
  }

  void _changePage(int page) {
    if (page <= 0) page = 1;

    if (page > widget.pageTotal) page = widget.pageTotal;

    setState(() {
      currentPage = page;
      _rangeSet();
      widget.onPageChanged(currentPage);
    });
  }

  void _rangeSet() {
    rangeStart = currentPage % widget.threshold == 0
        ? currentPage - widget.threshold
        : (currentPage ~/ widget.threshold) * widget.threshold;

    rangeEnd = rangeStart + widget.threshold;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // InkWell(
        //   onTap: () => _changePage(0),
        //   child: Stack(
        //     children: [
        //       if (widget.controlButton != null) ...[
        //         widget.controlButton!,
        //         iconToFirst
        //       ] else
        //         _defaultControlButton(iconToFirst),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   width: 4,
        // ),
    // 4    GestureDetector(
    //       onTap: () => _changePage(--currentPage),
    //       child: Stack(
    //         children: [
    //           if (widget.controlButton != null) ...[
    //             widget.controlButton!,
    //             iconPrevious
    //           ] else
    //             _defaultControlButton(iconPrevious),
    //         ],
    //       ),
    //     ),
        GestureDetector(
          onTap: (){
            _changePage(--currentPage);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined,color: AppColor.primaryBlue,size: 18,),
        ),
        Gap(Responsive.isMobile(context)? 10:30),

        ...List.generate(
          rangeEnd <= widget.pageTotal
              ? widget.threshold
              : widget.pageTotal % widget.threshold,
          (index) => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _changePage(index + 1 + rangeStart),
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: (currentPage - 1) % widget.threshold == index
                    ? widget.colorPrimary
                    : widget.colorSub,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Center(
                child: Text(
                  '${index + 1 + rangeStart}',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: widget.fontFamily,
                    color: (currentPage - 1) % widget.threshold == index
                        ? widget.colorSub
                        : AppColor.paginationGray,
                  ),
                ),
              ),
            ),
          ),
        ),
        Gap(Responsive.isMobile(context)? 10:30),
        GestureDetector(
          onTap: (){
            _changePage(++currentPage);          },
          child: Icon(Icons.arrow_forward_ios_rounded,color: AppColor.primaryBlue,size: 18,),


        ),
        // SizedBox(
        //   width: 4,
        // ),
        // InkWell(
        //   onTap: () => _changePage(widget.pageTotal),
        //   child: Stack(
        //     children: [
        //       if (widget.controlButton != null) ...[
        //         widget.controlButton!,
        //         iconToLast
        //       ] else
        //         _defaultControlButton(iconToLast),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
