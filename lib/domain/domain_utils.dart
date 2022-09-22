class CircularBuffer<T> {
  final List<T> _elements = [];
  int _currentIndex = -1;
  final int totalElementsCount;
  int get loadedElementsCount => _elements.length;

  CircularBuffer(this.totalElementsCount);

  setTotalElementsCount(int totalCount) {
    totalCount = totalCount;
  }

  bool isEmpty() {
    return _elements == [];
  }

  bool isFull() {
    return totalElementsCount == loadedElementsCount;
  }

  List<T> get elements => _elements;
  int get currentIndex => _currentIndex;

  addElements(List<T> newElements) {
    _elements.addAll(newElements);
  }

  bool canGetNextElements({required int count}) {
    if (isFull()) {
      return true;
    } else {
      if (count > 0) {
        return _currentIndex + count < loadedElementsCount;
      } else {
        return _currentIndex + count >= 0;
      }
    }
  }

  updateCurrentIndex({required int count}) {
    if (count < 0) {
      _currentIndex = (_currentIndex + count) < 0
          ? _currentIndex + count + totalElementsCount
          : _currentIndex + count;
    } else {
      _currentIndex = (_currentIndex + count) >= totalElementsCount
          ? _currentIndex + count - totalElementsCount
          : _currentIndex + count;
    }
  }

  List<T> getNextElements({required int count}) {
    int index = _currentIndex;
    List<T> nextElements = [];
    // if (count < 0) {
    //   index = (index + count) < 0
    //       ? index + count + totalElementsCount
    //       : index + count;
    // }
    index = _currentIndex;
    for (int i = 0; i < count.abs(); i++) {
      if (index < (totalElementsCount - 1)) {
        index += 1;
      } else {
        index = 0;
      }
      nextElements.add(_elements[index]);
    }
    return nextElements;
  }
}
