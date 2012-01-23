//
//  UIToolbarAdditions.h
//  HumanKitCatalog
//
//  Created by Sumeru Chatterjee on 1/13/12.
//  Copyright (c) 2012 Sumeru Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIToolbar (HICategory)

- (void)replaceItemWithTag:(NSInteger)tag withItem:(UIBarButtonItem*)item;

@end
