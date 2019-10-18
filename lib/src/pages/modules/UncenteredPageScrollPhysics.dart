// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/foundation.dart' show precisionErrorTolerance;

class _PagePosition extends ScrollPositionWithSingleContext implements PageMetrics {
  _PagePosition({
    ScrollPhysics physics,
    ScrollContext context,
    this.initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    ScrollPosition oldPosition,
  }) : assert(initialPage != null),
       assert(keepPage != null),
       assert(viewportFraction != null),
       assert(viewportFraction > 0.0),
       _viewportFraction = viewportFraction,
       _pageToUseOnStartup = initialPage.toDouble(),
       super(
         physics: physics,
         context: context,
         initialPixels: null,
         keepScrollOffset: keepPage,
         oldPosition: oldPosition,
       );

  final int initialPage;
  double _pageToUseOnStartup;

  /// If [pixels] isn't set by [applyViewportDimension] before [dispose] is
  /// called, this could throw an assert as [pixels] will be set to null.
  ///
  /// With [Tab]s, this happens when there are nested [TabBarView]s and there
  /// is an attempt to warp over the nested tab to a tab adjacent to it.
  ///
  /// This flag will be set to true once the dimensions have been established
  /// and [pixels] is set.
  bool isInitialPixelsValueSet = false;

  @override
  void dispose() {
    // TODO(shihaohong): remove workaround once these issues have been
    // resolved, https://github.com/flutter/flutter/issues/32054,
    // https://github.com/flutter/flutter/issues/32056
    // Sets `pixels` to a non-null value before `ScrollPosition.dispose` is
    // invoked if it was never set by `applyViewportDimension`.
    if (pixels == null && !isInitialPixelsValueSet) {
      correctPixels(0);
    }
    super.dispose();
  }

  @override
  double get viewportFraction => _viewportFraction;
  double _viewportFraction;
  set viewportFraction(double value) {
    if (_viewportFraction == value)
      return;
    final double oldPage = page;
    _viewportFraction = value;
    if (oldPage != null)
      forcePixels(getPixelsFromPage(oldPage));
  }

  double getPageFromPixels(double pixels, double viewportDimension) {
    final double actual = math.max(0.0, pixels) / math.max(1.0, viewportDimension * viewportFraction);
    final double round = actual.roundToDouble();
    if ((actual - round).abs() < precisionErrorTolerance) {
      return round;
    }
    return actual;
  }

  double getPixelsFromPage(double page) {
    return page * viewportDimension * viewportFraction;
  }

  @override
  double get page {
    assert(
      pixels == null || (minScrollExtent != null && maxScrollExtent != null),
      'Page value is only available after content dimensions are established.',
    );
    return pixels == null ? null : getPageFromPixels(pixels.clamp(minScrollExtent, maxScrollExtent), viewportDimension);
  }

  @override
  void saveScrollOffset() {
    PageStorage.of(context.storageContext)?.writeState(context.storageContext, getPageFromPixels(pixels, viewportDimension));
  }

  @override
  void restoreScrollOffset() {
    if (pixels == null) {
      final double value = PageStorage.of(context.storageContext)?.readState(context.storageContext);
      if (value != null)
        _pageToUseOnStartup = value;
    }
  }

  @override
  bool applyViewportDimension(double viewportDimension) {
    final double oldViewportDimensions = this.viewportDimension;
    final bool result = super.applyViewportDimension(viewportDimension);
    final double oldPixels = pixels;
    final double page = (oldPixels == null || oldViewportDimensions == 0.0) ? _pageToUseOnStartup : getPageFromPixels(oldPixels, oldViewportDimensions);
    final double newPixels = getPixelsFromPage(page);

    if (newPixels != oldPixels) {
      correctPixels(newPixels);
      isInitialPixelsValueSet = true;
      return false;
    }
    return result;
  }

  @override
  PageMetrics copyWith({
    double minScrollExtent,
    double maxScrollExtent,
    double pixels,
    double viewportDimension,
    AxisDirection axisDirection,
    double viewportFraction,
  }) {
    return PageMetrics(
      minScrollExtent: minScrollExtent ?? this.minScrollExtent,
      maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
      pixels: pixels ?? this.pixels,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      axisDirection: axisDirection ?? this.axisDirection,
      viewportFraction: viewportFraction ?? this.viewportFraction,
    );
  }
}

/// Scroll physics used by a [PageView].
///
/// These physics cause the page view to snap to page boundaries.
///
/// See also:
///
///  * [ScrollPhysics], the base class which defines the API for scrolling
///    physics.
///  * [PageView.physics], which can override the physics used by a page view.
class UncenteredPageScrollPhysics extends ScrollPhysics {
  /// Creates physics for a [PageView].
  const UncenteredPageScrollPhysics({ ScrollPhysics parent , @required this.itemExtent}) : super(parent: parent);
  final double itemExtent;

  @override
  UncenteredPageScrollPhysics applyTo(ScrollPhysics ancestor) {
    return UncenteredPageScrollPhysics(itemExtent: itemExtent,parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    if (position is _PagePosition)
      return position.page;
    return position.pixels / itemExtent;
  }

  double _getPixels(ScrollPosition position, double page) {
    if (position is _PagePosition)
      return position.getPixelsFromPage(page);
    return (page * itemExtent).clamp(position.minScrollExtent,position.maxScrollExtent);
  }

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity)
      page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
