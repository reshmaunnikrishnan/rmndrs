//
//  GlobalSettings.h
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_ALARM_KEY @"Alarm"
#define DB_REMINDER_KEY @"Reminder Before"
#define DB_SNOOZE_KEY @"Snooze"

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
+(NSString *) interpretUserfrequency:(NSString *) frequency;

+(NSString *) interpretUserDay:(UIPickerView *) picker;
+(NSDate *) convertStringToDate:(NSString *) dateStr;

+(NSString *) interpretUserSettings:(NSString *) value key:(NSString *)key;

@end
