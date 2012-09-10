//
//  GlobalSettings.h
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalSettings : NSObject

+(UIFont *) baseFont:(float) mysize;
+(UIFont *) baseFontBold:(float) mysize;
+(UIColor *) baseCellBackgroundColor;
+(UIColor *) badgeNowColor;
+(UIColor *) badgeAfterColor;
+(UIColor *) badgeSoonColor;
+(UIColor *) backImage;

+(UIColor *) badgeSelectedColor;

+(NSString *) interpretUserTime:(NSDate *) date;
+(NSString *) interpretUserDay:(UIPickerView *) picker;
+(NSDate *) convertStringToDate:(NSString *) dateStr;

@end
