import 'package:flutter/material.dart';
import 'dart:ui'; // Для FontFeature

enum WeightUnit { kg, lbs }

class WeightPicker extends StatefulWidget {
  final int initialWeight;
  final Function(int) onWeightChanged;
  final WeightUnit weightUnit; // Единица измерения передаётся извне

  const WeightPicker({
    Key? key,
    this.initialWeight = 70,
    required this.onWeightChanged,
    required this.weightUnit,
  })  : assert(initialWeight >= 40 && initialWeight <= 150,
            'Initial weight must be between 40 and 150'),
        super(key: key);

  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  late int _currentWeight;
  final ScrollController _scrollController = ScrollController();

  final double _itemWidth = 8.0;
  // Если ширина контейнера не меняется, то отступ можно оставить таким же
  double get _sidePadding => (286 - _itemWidth) / 2;
  final double _tickContainerHeight = 70.0;

  final int _minWeight = 40;
  final int _maxWeight = 150;

  @override
  void initState() {
    super.initState();
    _currentWeight = widget.initialWeight;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo((_currentWeight - _minWeight) * _itemWidth);
    });
  }

  void _onScroll() {
    int index = (_scrollController.offset / _itemWidth).round();
    index = index.clamp(0, _maxWeight - _minWeight);
    final newWeight = _minWeight + index;
    if (newWeight != _currentWeight) {
      setState(() {
        _currentWeight = newWeight;
      });
      widget.onWeightChanged(_currentWeight);
    }
  }

  /// Форматирует значение веса в зависимости от выбранной единицы.
  /// Если выбраны килограммы – возвращается строка с числом,
  /// если фунты – производится конвертация (1 кг ≈ 2.20462 фунтов).
  String formatWeight(int weightInKg) {
    if (widget.weightUnit == WeightUnit.kg) {
      return '$weightInKg';
    } else {
      final lbs = (weightInKg * 2.20462).round();
      return '$lbs';
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
                      itemCount: _maxWeight - _minWeight + 1,
                      itemBuilder: (context, index) {
                        final value = _minWeight + index;
                        final isMajorTick = index % 5 == 0;
                        final isSelected = (value == _currentWeight);

                        double tickHeight =
                            isSelected ? 62 : (isMajorTick ? 34 : 18);
                        final tickTop = (_tickContainerHeight - tickHeight) / 2;

                        // Не отображаем метку, если тик является центральным
                        // или находится на расстоянии 1 от центрального.
                        final bool shouldShowLabel = isMajorTick &&
                            (value != _currentWeight) &&
                            ((value - _currentWeight).abs() != 1);

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
                                        formatWeight(value),
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
              // Иконка стрелки (указатель текущего выбранного значения)
              const Positioned(
                bottom: 0,
                child: Icon(
                  Icons.arrow_drop_up,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              // Центральное отображение текущего выбранного значения
              Positioned(
                top: 13,
                child: Text(
                  formatWeight(_currentWeight),
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
