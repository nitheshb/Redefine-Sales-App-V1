// Copyright 2023 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [FxShadow] - provides custom shadow to the widget

import 'package:flutter/material.dart';

enum FxShadowPosition {
  topLeft("Top Left"),
  top("Top"),
  topRight("Top Right"),
  centerLeft("Center Left"),
  center("Center"),
  centerRight("Center Right"),
  bottomLeft("Bottom Left"),
  bottom("Bottom"),
  bottomRight("Bottom Right");

  final String humanReadable;

  const FxShadowPosition(this.humanReadable);
}

class FxShadow {
  late int alpha;
  late double elevation, spreadRadius, blurRadius;
  Offset? offset;
  FxShadowPosition? position;
  Color? color;
  bool? darkShadow;

  FxShadow(
      {double elevation = 3, double? spreadRadius, double? blurRadius, Offset? offset, FxShadowPosition position = FxShadowPosition
          .bottom, int? alpha, Color? color, bool darkShadow = false}) {
    this.spreadRadius = spreadRadius ?? elevation * 0.125;
    this.blurRadius = blurRadius ?? elevation * 2;
    this.alpha = alpha != null ? alpha : (darkShadow ? 80 : 25);
    this.elevation = elevation;
    this.offset = offset;
    this.position = position;
    this.color = color;
    this.darkShadow = darkShadow;

    if (offset == null) {
      switch (position) {
        case FxShadowPosition.topLeft:
          this.offset = Offset(-elevation, -elevation);
          break;
        case FxShadowPosition.top:
          this.offset = Offset(0, -elevation);
          break;
        case FxShadowPosition.topRight:
          this.offset = Offset(elevation, -elevation);
          break;
      //TODO: Shadow problem
        case FxShadowPosition.centerLeft:
          this.offset = Offset(-elevation, elevation * 0.25);
          break;
        case FxShadowPosition.center:
          this.offset = Offset(0, 0);
          break;
      //TODO: Shadow problem
        case FxShadowPosition.centerRight:
          this.offset = Offset(elevation, elevation * 0.25);
          break;
        case FxShadowPosition.bottomLeft:
          this.offset = Offset(-elevation, elevation);
          break;
        case FxShadowPosition.bottom:
          this.offset = Offset(0, elevation);
          break;
        case FxShadowPosition.bottomRight:
          this.offset = Offset(elevation, elevation);
          break;
      }
    }
  }

  FxShadow.none(
      {double elevation = 0, double? spreadRadius, double? blurRadius, Offset? offset, FxShadowPosition position = FxShadowPosition
          .bottom, int? alpha, Color? color, bool darkShadow = false}) {
    this.spreadRadius = spreadRadius ?? elevation * 0.125;
    this.blurRadius = blurRadius ?? elevation * 2;
    this.alpha = alpha != null ? alpha : (darkShadow ? 100 : 36);
    this.elevation = elevation;
    this.offset = offset;
    this.position = position;
    this.color = color;
    this.darkShadow = darkShadow;

    if (offset == null) {
      switch (position) {
        case FxShadowPosition.topLeft:
          this.offset = Offset(-elevation, -elevation);
          break;
        case FxShadowPosition.top:
          this.offset = Offset(0, -elevation);
          break;
        case FxShadowPosition.topRight:
          this.offset = Offset(elevation, -elevation);
          break;
      //TODO: Shadow problem
        case FxShadowPosition.centerLeft:
          this.offset = Offset(-elevation, elevation * 0.25);
          break;
        case FxShadowPosition.center:
          this.offset = Offset(0, 0);
          break;
      //TODO: Shadow problem
        case FxShadowPosition.centerRight:
          this.offset = Offset(elevation, elevation * 0.25);
          break;
        case FxShadowPosition.bottomLeft:
          this.offset = Offset(-elevation, elevation);
          break;
        case FxShadowPosition.bottom:
          this.offset = Offset(0, elevation);
          break;
        case FxShadowPosition.bottomRight:
          this.offset = Offset(elevation, elevation);
          break;
      }
    }
  }

  @override
  String toString() {
    return 'FxShadow{alpha: $alpha, elevation: $elevation, spreadRadius: $spreadRadius, blurRadius: $blurRadius, offset: $offset, position: $position, color: $color, darkShadow: $darkShadow}';
  }
}
