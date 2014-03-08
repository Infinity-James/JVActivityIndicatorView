## JVActivityIndicatorView

The view should be used like any other view, and function very similarly to the standard UIActivityIndicatorView.

To import:

```objc
#import "JVActivityIndicatorView.h"
```

To use:

```objc
JVActivityIndicatorView *activityIndicatorView = [[JVActivityIndicatorView alloc] init];
activityIndicatorView.center = self.view.center;
[self.view addSubview:activityIndicatorView];

//	start animating the activity indicator
[activityIndicatorView startAnimating];

//	stop animating and hide the activity indicator
[activityIndicatorView stopAnimating];
```

## Requirements

`JVActivityIndicatorView` requires iOS 6.x or greater.

## License

Usage is provided under the [MIT License](http://opensource.org/licenses/mit-license.php). See LICENSE for full details.
