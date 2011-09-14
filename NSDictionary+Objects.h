//
//  NSDictionary+Objects.h
//  Additions
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (helper)

- (NSString*) stringForKey:(id)key;

- (NSNumber*) numberForKey:(id)key;

- (NSMutableDictionary*) dictionaryForKey:(id)key;

- (NSMutableArray*) arrayForKey:(id)key;

@end