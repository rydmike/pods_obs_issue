# pods_obs_issue

### Issue A)
A Flutter project to demo an issue with ProviderObserver with Riverpod 1.0.0-dev.6, where ProviderObserver was not being updated when using StateProviders.

This issue was reported [here #623](https://github.com/rrousselGit/river_pod/issues/623)
and resolved [here](https://github.com/rrousselGit/river_pod/commit/ba49b128246d376a349d0033ba72c3b6db846158).

---


## This repo was repurposed to show two other issues with Riverpod v1

### Issue B1)

When using Riverpod 1.0.0-dev.7 changing a `StateProvider`'s state now triggers the `ProviderObserver.didUpdateProvider` correctly (it did not in previous versions). However, the `newValue` and `previousValue` are always equal, the `previousValue` never contains the previous state or value.



### Issue B2)

When using Riverpod 1.0.0-dev.7 setting the value of a `StateProvider` the `ProviderObserver.didUpdateProvider` is called for a `StateProvider` also when the value has not been changed. Docs say:

```dart
/// An object that listens to the changes of a [ProviderContainer].
///
/// This can be used for logging or making devtools.
abstract class ProviderObserver { ... }
```

This implies that if there is **no** change the observer should not be called since it has not changed. This needs a fix imo, or documentation improvement. Personally I think it would be more logical and useful for the intended purpose of a `ProviderObserver` if it was not called at all in this case.

