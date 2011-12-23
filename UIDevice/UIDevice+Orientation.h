//
//  UIDevice+Orientation.h
//  Additions
//
//  Created by Erica Sadun, http://ericasadun.com
//  iPhone Developer's Cookbook, 5.0 Edition
//  BSD License, Use at your own risk
//  Thanks jweinberg, Emanuele Vulcano, rincewind42, Jonah Williams

#import <UIKit/UIKit.h>


@interface UIDevice (Orientation) <UIAccelerometerDelegate>
- (BOOL) isLandscape;
- (BOOL) isPortrait;
- (NSString *) orientationString;
- (float) orientationAngleRelativeToOrientation:(UIDeviceOrientation) someOrientation;
@property (nonatomic, readonly) BOOL isLandscape;
@property (nonatomic, readonly) BOOL isPortrait;
@property (nonatomic, readonly) NSString *orientationString;
@property (nonatomic, readonly) float orientationAngle;
@end
