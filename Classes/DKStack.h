//
//  DKStack.h
//  Additions
//
//  Created by Dominik Krejčík on 25/09/2011.
//  Feel free to use and distribute as long as you mention me. Or buy me a beer.
//  https://github.com/dominikkrejcik/Objective-C-Stack---Queue

#import <Foundation/Foundation.h>


@interface DKStack : NSObject

- (NSArray*) objects;
- (void)pop;
- (void)push:(id)element;
- (void)clear;

- (id)top;
+ (DKStack*)stack;
- (NSInteger)size;
- (BOOL)isEmpty;

@end
