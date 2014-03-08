//
//  JVActivityIndicator.m
// 
//
//  Created by James Valaitis on 13/02/2014.
//  Copyright (c) 2014 EVO. All rights reserved.
//

#import "JVActivityIndicatorView.h"

#pragma mark - Constants & Static Variables

/**	The time interal between render refreshes.	*/
static NSTimeInterval const JVActivityIndicatorRenderTimeInterval = 0.02f;
/**	The amount the activity indicator should be rotated on each refresh (in radians).	*/
static CGFloat const JVActivityIndicatorRotationAngleDelta = 0.13f;

#pragma mark - JV Activity Indicator View Private Class Extension

@interface JVActivityIndicatorView ()

#pragma mark - Private Properties

/**	The view holding the image which we will animate.	*/
@property (nonatomic, strong) UIImageView *activityIndicatorView;
/**	Whether or not this activity indicator is currently animating.	*/
@property (nonatomic, assign) BOOL animating;
/**	The current angle of the rotation of the activity indicator (in radians).	*/
@property (nonatomic, assign) CGFloat currentAngleOfRotation;

@end

#pragma mark - JV Activity Indicator View Implementation

@implementation JVActivityIndicatorView {}

#pragma mark - Animation Management

/**
 *	Fires when it is time to animate the activity indicator.
 *
 *	@param	animationTimer				The timer that fired.
 */
- (void)animationTimerTriggered:(NSTimer *)animationTimer {
	
	if (self.animating) {
		self.currentAngleOfRotation += JVActivityIndicatorRotationAngleDelta;
	}
	
	if (self.currentAngleOfRotation > (M_PI * 2.0f)) {
		self.currentAngleOfRotation = 0.0f;
	}
	
	CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(self.currentAngleOfRotation);
	self.activityIndicatorView.transform = rotationTransform;
}

/**
 *	Starts the animation of the progress indicator.
 */
- (void)startAnimating {
	
	self.animating = YES;
	self.hidden = NO;
}

/**
 *	Stops the animation of the progress indicator.
 */
- (void)stopAnimating {
	
	self.animating = NO;
	self.hidden = YES;
}

#pragma mark - Initialisation

/**
 *	The basic and fundamental initialisation required for this class.
 */
- (void)basicInitialisation
{
	self.currentAngleOfRotation = 0.0f;
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.activityIndicatorView];
	
	//	start the timer which will control the animation
	NSTimer *animationTimer = [NSTimer timerWithTimeInterval:JVActivityIndicatorRenderTimeInterval
													  target:self
													selector:@selector(animationTimerTriggered:)
													userInfo:nil
													 repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:animationTimer forMode:NSRunLoopCommonModes];
	
	self.transform = CGAffineTransformMakeRotation(self.currentAngleOfRotation);
}

/**
 *	Implemented by subclasses to initialize a new object (the receiver) immediately after memory for it has been allocated.
 *
 *	@return	An initialized object.
 */
- (instancetype)init
{
	return [self initWithFrame:CGRectZero];
}

/**
 *	Returns an object initialized from data in a given unarchiver.
 *
 *	@param	aDecoder					An unarchiver object.
 *
 *	@return	self, initialized using the data in decoder.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self basicInitialisation];
	}
	
	return self;
}

/**
 *	Initializes and returns a newly allocated view object with the specified frame rectangle.
 *
 *	@param	frame						The frame rectangle for the view, measured in points.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithFrame:(CGRect)frame
{
	CGRect correctFrame = frame;
	if (CGRectGetWidth(correctFrame) < 27.0f || CGRectGetHeight(correctFrame) < 27.0f) {
		correctFrame.size = CGSizeMake(27.0f, 27.0f);
	}
	
    if (self = [super initWithFrame:correctFrame])
	{
		[self basicInitialisation];
    }
	
    return self;
}

#pragma mark - Property Accessor Methods - Getters

/**
 *	The view holding the image which we will animate.
 *
 *	@return	The view holding the image which we will animate.
 */
- (UIImageView *)activityIndicatorView {
	
	if (!_activityIndicatorView) {
		
		UIImage *activityIndicatorImage = [UIImage imageNamed:@"activityIndicator"];
		_activityIndicatorView = [[UIImageView alloc] initWithImage:activityIndicatorImage];
		_activityIndicatorView.contentMode = UIViewContentModeCenter;
		
		//	calculate positioning of indicator
		CGSize imageSize = activityIndicatorImage.size;
		CGSize viewSize = self.bounds.size;
		CGFloat offsetWidth = viewSize.width - imageSize.width;
		CGFloat offsetHeight = viewSize.height - imageSize.height;
		CGPoint activityIndicatorOrigin = CGPointMake(offsetWidth / 2.0f, offsetHeight / 2.0f);
		CGRect activityIndicatorFrame = CGRectMake(activityIndicatorOrigin.x, activityIndicatorOrigin.y, imageSize.width, imageSize.height);
		
		_activityIndicatorView.frame = activityIndicatorFrame;
	}
	
	return _activityIndicatorView;
}

@end