//
//  UIView+Helpers.m
//  Additions
//
//  Imported from three20 Sumeru Chatterjee on 12/19/11.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+Helpers.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface UIView (Private)
-(void) resetAndRemoveFromSuperView;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIView 	(Helpers)

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) removeAllSubviews {
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) removeAllSubviewsExceptSubview:(UIView*)subview {
    
    for(UIView* view in [self subviews]) {
        if(view!=subview) {
            [view removeFromSuperview];
        }    
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)flipFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration
{
    [UIView flipFromView:fromView toView:toView withType:UIViewFlipAnimationTypeFlipFromLeft duration:duration];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)flipFromView:(UIView *)fromView toView:(UIView *)toView withType:(UIViewFlipAnimationType)animationType duration:(NSTimeInterval)duration
{

    CABasicAnimation *moveFront;
	moveFront=[CABasicAnimation animationWithKeyPath:@"shadowOffset"];
	moveFront.delegate = self;
	moveFront.duration = duration/2;
	moveFront.repeatCount = 0;
	moveFront.removedOnCompletion = FALSE;
	moveFront.fillMode = kCAFillModeForwards;
	moveFront.autoreverses = NO;
	moveFront.fromValue = [NSValue valueWithCGSize:CGSizeMake(3,3)];
 	moveFront.toValue = [NSValue valueWithCGSize:CGSizeMake(50,50)];
	moveFront.beginTime = 0.0;
	
	CABasicAnimation *rotateFirstHalf;
	rotateFirstHalf=[CABasicAnimation animationWithKeyPath:@"transform"];
	rotateFirstHalf.delegate = self;
	rotateFirstHalf.duration = duration/2;
	rotateFirstHalf.repeatCount = 0;
	rotateFirstHalf.removedOnCompletion = FALSE;
	rotateFirstHalf.fillMode = kCAFillModeForwards;
	rotateFirstHalf.autoreverses = NO;
	rotateFirstHalf.beginTime = 0.0;
    
    if (animationType==UIViewFlipAnimationTypeFlipFromRight) {
        rotateFirstHalf.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(1.0f * M_PI/2, 0, 1, 0)];
    } else {
        rotateFirstHalf.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-1.0f * M_PI/2, 0, 1, 0)];
    }
	
	CABasicAnimation *moveBack;
	moveBack=[CABasicAnimation animationWithKeyPath:@"shadowOffset"];
	moveBack.delegate = self;
	moveBack.duration = duration/2;
	moveBack.repeatCount = 0;
	moveBack.removedOnCompletion = FALSE;
	moveBack.fillMode = kCAFillModeForwards;
	moveBack.autoreverses = NO;
	moveBack.fromValue = [NSValue valueWithCGSize:CGSizeMake(50,50)];
 	moveBack.toValue = [NSValue valueWithCGSize:CGSizeMake(3,3)];
	moveBack.beginTime = duration/2;
    
    CABasicAnimation *rotateSecondHalf;
	rotateSecondHalf=[CABasicAnimation animationWithKeyPath:@"transform"];
	rotateSecondHalf.delegate = self;
	rotateSecondHalf.duration = duration/2;
	rotateSecondHalf.repeatCount = 0;
	rotateSecondHalf.removedOnCompletion = FALSE;
	rotateSecondHalf.fillMode = kCAFillModeForwards;
	rotateSecondHalf.autoreverses = NO;
	rotateSecondHalf.beginTime = duration/2;
	
    if (animationType==UIViewFlipAnimationTypeFlipFromLeft) {
        rotateSecondHalf.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-1.0f * M_PI/2, 0, 1, 0)];
        rotateSecondHalf.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, M_PI, 1, 0)];
    } else {
        rotateSecondHalf.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(1.0f * M_PI/2, 0, 1, 0)];
        rotateSecondHalf.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, M_PI, 1, 0)];
    }
    
	CAAnimationGroup *firstGroup = [CAAnimationGroup animation];
	[firstGroup setAnimations:[NSArray arrayWithObjects:moveFront,rotateFirstHalf,nil]];
	[firstGroup setDuration:duration];
	[firstGroup setRemovedOnCompletion:NO];
	[firstGroup setFillMode:kCAFillModeForwards];
    
    CAAnimationGroup *secondGroup = [CAAnimationGroup animation];
	[secondGroup setAnimations:[NSArray arrayWithObjects:moveBack,rotateSecondHalf,nil]];
	[secondGroup setDuration:duration];
	[secondGroup setRemovedOnCompletion:NO];
	[secondGroup setFillMode:kCAFillModeForwards];
	
    toView.frame=fromView.frame;
    toView.layer.transform = CATransform3DMakeRotation(-M_PI/2,0,1,0);
    toView.layer.shadowOffset = CGSizeMake(50,50);
    [[fromView superview] addSubview:toView];
    
    [fromView.layer addAnimation:firstGroup forKey:@"flip_animation"];
    [toView.layer addAnimation:secondGroup forKey:@"flip_animation"];
    
    //Schedule a callback to reset and remove superview after animation finishes
    NSMethodSignature * mySignature = [UIView instanceMethodSignatureForSelector:@selector(resetAndRemoveFromSuperView)];
    NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature:mySignature];
    [myInvocation setTarget:fromView];
    [myInvocation setSelector:@selector(resetAndRemoveFromSuperView)];
    NSTimer *timer = [NSTimer timerWithTimeInterval:duration invocation:myInvocation repeats:NO];
    if(timer) {
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}

#pragma mark -
#pragma mark FrameHelpers

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    
    if(y!=self.top) {
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
    }    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)boundWidth {
    return self.bounds.size.width;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBoundWidth:(CGFloat)width {
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)boundHeight {
    return self.bounds.size.height;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBoundHeight:(CGFloat)height {
    CGRect bounds = self.frame;
    bounds.size.height = height;
    self.bounds = bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


#pragma mark -
#pragma mark Private

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) resetAndRemoveFromSuperView 
{
    self.layer.shadowOffset = CGSizeMake(3,3);
    self.layer.transform = CATransform3DMakeRotation(0,0,1,0);
    [self removeFromSuperview];
}    

@end
