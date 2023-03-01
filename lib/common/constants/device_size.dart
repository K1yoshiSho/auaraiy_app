import 'dart:ui';

Size get deviceSize => _size;
Size _size = window.physicalSize / window.devicePixelRatio;
