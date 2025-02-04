import 'package:flutter/material.dart';
import 'dart:ui'; // Для FontFeature

enum HeightUnit { cm, ftin }

class HeightPicker extends StatefulWidget {
  final int initialHeight;
  final Function(int) onHeightChanged;
  final HeightUnit heightUnit; // Принимаем выбранную единицу извне

  const HeightPicker({
    Key? key,
    this.initialHeight = 185,
    required this.onHeightChanged,
    required this.heightUnit,
  })  : assert(initialHeight >= 170 && initialHeight <= 200,
            'Initial height must be between 170 and 200'),
        super(key: key);

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  late int _currentHeight;
  final ScrollController _scrollController = ScrollController();

  final double _itemWidth = 8.0;
  double get _sidePadding => (286 - _itemWidth) / 2;
  final double _tickContainerHeight = 70.0;

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.initialHeight;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo((widget.initialHeight - 170) * _itemWidth);
    });
  }

  void _onScroll() {
    int index = (_scrollController.offset / _itemWidth).round();
    index = index.clamp(0, 30);
    final newHeight = 170 + index;
    if (newHeight != _currentHeight) {
      setState(() {
        _currentHeight = newHeight;
      });
      widget.onHeightChanged(_currentHeight);
    }
  }

  /// Форматирует значение роста в зависимости от выбранных единиц.
  /// Если выбраны сантиметры – возвращается строка с числом.
  /// Если ft/in – производится конвертация, и возвращается строка вида "5'9"".
  String formatHeight(int heightInCm) {
    if (widget.heightUnit == HeightUnit.cm) {
      return '$heightInCm';
    } else {
      final totalInches = (heightInCm * 0.393701).round();
      final feet = totalInches ~/ 12;
      final inches = totalInches % 12;
      return "$feet'$inches\"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186,
      width: 328,
      decoration: BoxDecoration(
        color: const Color(0xFFC7C1C1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1EDED),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Линейка с тиками и метками
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: _tickContainerHeight,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        _onScroll();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.none,
                      itemCount: 31,
                      itemBuilder: (context, index) {
                        final value = 170 + index;
                        final isMajorTick = index % 5 == 0;
                        final isSelected = (value == _currentHeight);

                        double tickHeight =
                            isSelected ? 62 : (isMajorTick ? 34 : 18);
                        final tickTop = (_tickContainerHeight - tickHeight) / 2;

                        // Не отображаем метку, если тик является центральным
                        // или находится на расстоянии 1 от центрального.
                        final bool shouldShowLabel = isMajorTick &&
                            (value != _currentHeight) &&
                            ((value - _currentHeight).abs() != 1);

                        return Container(
                          width: _itemWidth,
                          height: _tickContainerHeight,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: tickTop,
                                child: Container(
                                  width: 2,
                                  height: tickHeight,
                                  color: Colors.black,
                                ),
                              ),
                              if (shouldShowLabel)
                                Positioned(
                                  top: -5,
                                  left: -16,
                                  child: SizedBox(
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        formatHeight(value),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFeatures: [
                                            FontFeature.tabularFigures()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Иконка стрелки (указатель текущего значения)
              const Positioned(
                bottom: 0,
                child: Icon(
                  Icons.arrow_drop_up,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              // Центральное отображение текущего значения
              Positioned(
                top: 13,
                child: Text(
                  formatHeight(_currentHeight),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
