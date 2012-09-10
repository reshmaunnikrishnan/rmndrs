//
//  GlobalSettings.m
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "GlobalSettings.h"

@implementation GlobalSettings

static NSString *baseFontValue = @"HelveticaNeue";

static NSString *baseFontLight = @"-Light";
static NSString *baseFontBold = @"-CondensedBold";

static NSString *baseBackground = @"Stripe.png";
    
+(UIFont *) baseFont:(float) mysize
{
    return [UIFont fontWithName:[baseFontValue stringByAppendingFormat:baseFontLight] size:mysize];
//    return [UIFont fontWithName:@"Noteworthy-Light" size:mysize];
//    return [UIFont fontWithName:@"TrebuchetMS" size:mysize];
}

+(UIFont *) baseFontBold:(float) mysize
{
    return [UIFont fontWithName:[baseFontValue stringByAppendingFormat:baseFontBold] size:mysize];
    //    return [UIFont fontWithName:@"Noteworthy-Light" size:mysize];
    //    return [UIFont fontWithName:@"TrebuchetMS" size:mysize];
}


+(UIColor *) baseCellBackgroundColor
{
    float color = 0.93;
    return [UIColor colorWithRed:color green:color blue:color alpha:1];
}

+(UIColor *) badgeNowColor
{
    return [UIColor colorWithRed:0.74 green:0 blue:0.37 alpha:1];
}

+(UIColor *) badgeAfterColor
{
    return [UIColor colorWithRed:0 green:0.74 blue:0 alpha:1];
}

+(UIColor *) badgeSoonColor
{
    return [UIColor colorWithRed:0.33 green:0.66 blue:1 alpha:1];
}

+(UIColor *) backImage
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:baseBackground]];
}

+(UIColor *) badgeSelectedColor 
{
    return [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
}

+(NSString *) interpretUserTime:(NSDate *) date
{
    NSString *formattedString; 
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeStyle:NSDateFormatterShortStyle];
    if(date == nil) {
        date = [[NSDate alloc] init];
    }
    formattedString = [df stringFromDate:date];
    [df release];
    
    NSLog(@"Date GOT :%@  String CREATED %@", date, formattedString);
    
    return formattedString;
}

+(NSString *) interpretUserDay:(UIPickerView *) picker
{
    return nil;
}

+(NSDate *) convertStringToDate:(NSString *) dateStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    NSLog(@"String GOT :%@  Date CREATED %@", dateStr, date.debugDescription);
    
    return date;
    
}

@end
