#import <UIKit/UIKit.h>

@interface UISwitch (tagged)
+ (UISwitch *) switchWithLeftText: (NSString *) tag1 andRight: (NSString *) tag2;
@property (nonatomic, readonly)	UILabel *label1;
@property (nonatomic, readonly)	UILabel *label2;
@end
