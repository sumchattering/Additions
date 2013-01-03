//
//  NSURL+ImageURL.m
//  HiveCore
//
//  Created by samyzee on 1/3/13.
//  Copyright (c) 2013 Simple Apps LLC. All rights reserved.
//

#import "NSURL+ImageURL.h"

@implementation NSURL (ImageURL)

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSURL*)imageURL{
    
    NSURL* URL = self;
    NSString* extension = [[[URL lastPathComponent] pathExtension] lowercaseString];
    if ([extension  isEqualToString:@"jpg"]||[extension  isEqualToString:@"jpeg"]||[extension isEqualToString:@"png"]||[extension isEqualToString:@"gif"]||[extension isEqualToString:@"tiff"]||[extension isEqualToString:@"tif"]||[extension isEqualToString:@"bmp"]) {
        return URL;
    }
    
    //Process Imgur URLs
    if(([[URL host] isEqualToString:@"imgur.com"]
        ||[[URL host] isEqualToString:@"www.imgur.com"])&&([[URL pathComponents] count]<3)){
        NSURL* iURL = [[[NSURL alloc] initWithScheme:@"http" host:@"i.imgur.com" path:URL.path] autorelease];
        return [iURL URLByAppendingPathExtension:@"jpg"];
    }
    
    //Process Quickmeme URLs
    if([[URL host] isEqualToString:@"quickmeme.com"]||[[URL host] isEqualToString:@"www.quickmeme.com"]){
        NSURL* iURL = [[NSURL URLWithString:@"http://i.qkme.me"] URLByAppendingPathComponent:URL.lastPathComponent];
        return [iURL  URLByAppendingPathExtension:@"jpg"];
    }
    
    //Process qkme.me URLs
    if([[URL host] isEqualToString:@"qkme.me"]||[[URL host] isEqualToString:@"www.qkme.me"]){
        NSURL* iURL = [[[NSURL alloc] initWithScheme:@"http" host:@"i.qkme.me" path:URL.path] autorelease];
        return [iURL URLByAppendingPathExtension:@"jpg"];
    }
    
    return nil;
}

@end
