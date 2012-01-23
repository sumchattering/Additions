//
//  UIToolbarAdditions.m
//  HumanKitCatalog
//
//  Created by Sumeru Chatterjee on 1/13/12.
//  Copyright (c) 2012 Sumeru Chatterjee. All rights reserved.
//

#import "UIToolbarAdditions.h"

@implementation UIToolbar (HICategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)replaceItemWithTag:(NSInteger)tag withItem:(UIBarButtonItem*)item {
    NSInteger buttonIndex = 0;
    for (UIBarButtonItem* button in self.items) {
        if (button.tag == tag) {
            NSMutableArray* newItems = [NSMutableArray arrayWithArray:self.items];
            [newItems replaceObjectAtIndex:buttonIndex withObject:item];
            self.items = newItems;
            break;
        }
        ++buttonIndex;
    }
}


@end
