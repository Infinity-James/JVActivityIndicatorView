//
//  JVActivityIndicator.h
//
//
//  Created by James Valaitis on 13/02/2014.
//  Copyright (c) 2014 EVO. All rights reserved.
//

#pragma mark - JV Activity Indicator View Public Interface

@interface JVActivityIndicatorView : UIView

#pragma mark - Public Methods

/**
 *	Starts the animation of the progress indicator.
 */
- (void)startAnimating;
/**
 *	Stops the animation of the progress indicator.
 */
- (void)stopAnimating;

@end