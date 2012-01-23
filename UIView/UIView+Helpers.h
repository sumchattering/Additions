//
//  UIView+Helpers.h
//  Additions
//
//  Imported from three20 by Sumeru Chatterjee on 12/19/11.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIViewFlipAnimationTypeFlipFromLeft,
    UIViewFlipAnimationTypeFlipFromRight,
} UIViewFlipAnimationType;

@interface UIView (Helpers)

/*
 * Method to remove all subviews
 */
-(void) removeAllSubviews;
-(void) removeAllSubviewsExceptSubview:(UIView*)subview;

- (UIView*)descendantOrSelfWithClass:(Class)cls;

////CUSTOM ANIMATIONS////////////////////
/**
 * Shortcut methods for flipping a UIView into another UIView
 */
+ (void)flipFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration;
+ (void)flipFromView:(UIView *)fromView toView:(UIView *)toView withType:(UIViewFlipAnimationType)animationType duration:(NSTimeInterval)duration;

/////FRAME SHORTCUTS//////////////////////
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for bounds.size.width
 *
 * Sets bounds.size.width = width
 */
@property (nonatomic) CGFloat boundWidth;

/**
 * Shortcut for bounds.size.height
 *
 * Sets bounds.size.height = height
 */
@property (nonatomic) CGFloat boundHeight;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@end
