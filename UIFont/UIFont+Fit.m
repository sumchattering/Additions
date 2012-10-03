//
//  UIFont+Fit.m
//  Additions
//
//  Created by Sumeru Chatterjee on 12/26/11.
//

#import "UIFont+Fit.h"

@implementation UIFont (Fit)

///////////////////////////////////////////////////////////////////////////////////////////////////
+(UIFont*) maximumBoldSystemFontThatFitsSingleLineString:(NSString*)string inWidth:(CGFloat)width {

    CGFloat min=1,max=300,fontSize;
    CGSize labelSize;
    do {

        fontSize = (min+max)/2;
        labelSize = [string sizeWithFont:[UIFont boldSystemFontOfSize:(min+max)/2]];

        if (labelSize.width>width)
            max=fontSize;
        else if (labelSize.width<width)
            min=fontSize;

    } while (((int)min<(int)max)&&((int)labelSize.width!=(int)width));

    return [UIFont boldSystemFontOfSize:fontSize];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(UIFont*) maximumBoldSystemFontThatFitsString:(NSString*)string inSize:(CGSize)maxSize {

    CGFloat min=1,max=maxSize.height,fontSize;
    CGSize labelSize;
    do {

        fontSize = (min+max)/2;
        labelSize = [string sizeWithFont:[UIFont boldSystemFontOfSize:(min+max)/2]
                       constrainedToSize:CGSizeMake(maxSize.width,CGFLOAT_MAX)
                           lineBreakMode:UILineBreakModeWordWrap];

        if (labelSize.height>maxSize.height)
            max=fontSize;
        else if (labelSize.height<maxSize.height)
            min=fontSize;

    } while (((int)min<(int)max)&&((int)labelSize.height!=(int)maxSize.height));
    return [UIFont boldSystemFontOfSize:fontSize];
}

@end
