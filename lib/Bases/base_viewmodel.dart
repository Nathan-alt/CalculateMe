import 'package:flutter/material.dart';

/// A mixin that provides a [BuildContext] instance for use within
/// classes that implement it. This mixin allows classes to have access
/// to the [BuildContext] which can be useful for showing dialogs,
/// snackbars, and accessing other contextual information.
///
/// This mixin should be used with caution to ensure that the [context]
/// is properly set before accessing it, as accessing a null context
/// can lead to runtime errors.
mixin ContextHolderMixin {
  late final BuildContext? context;
}
