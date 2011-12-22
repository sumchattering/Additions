#import "UISwitch-Extended.h"

#define TAG_OFFSET	900

@implementation UISwitch (tagged)
- (void) spelunkAndTag: (UIView *) aView withCount:(int *) count
{
	for (UIView *subview in [aView subviews])
	{
		if ([subview isKindOfClass:[UILabel class]])
		{
			*count += 1;
			[subview setTag:(TAG_OFFSET + *count)];
		}
		else 
			[self spelunkAndTag:subview withCount:count];
	}
}

- (UILabel *) label1 
{ 
	return (UILabel *) [self viewWithTag:TAG_OFFSET + 1]; 
}

- (UILabel *) label2 
{ 
	return (UILabel *) [self viewWithTag:TAG_OFFSET + 2]; 
}

+ (UISwitch *) switchWithLeftText: (NSString *) tag1 andRight: (NSString *) tag2
{
	UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
	
	int labelCount = 0;
	[switchView spelunkAndTag:switchView withCount:&labelCount];
	
	if (labelCount == 2)
	{
		[switchView.label1 setText:tag1];
		[switchView.label2 setText:tag2];
	}
	
	return [switchView autorelease];
}

@end


