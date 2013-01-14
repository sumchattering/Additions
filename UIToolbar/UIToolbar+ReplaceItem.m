//
//  UIToolbar+ReplaceItem.m
//  Additions
//
//  Imported from three20 by Sumeru Chatterjee on 1/13/12.
//

#import "UIToolbar+ReplaceItem.h"

@implementation UIToolbar (ReplaceItem)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)replaceItemWithTag:(NSInteger)tag withItem:(UIBarButtonItem*)item {
    NSInteger buttonIndex = 0;
    for (UIBarButtonItem* button in self.items) {
        if (button.tag == tag) {
            NSMutableArray* newItems = [NSMutableArray arrayWithArray:self.items];
	    newItems[buttonIndex] = item;
            self.items = newItems;
            break;
        }
        ++buttonIndex;
    }
}

@end
