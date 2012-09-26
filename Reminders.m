//
//  Reminders.m
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 16/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "Reminders.h"


@implementation Reminders

@dynamic name;
@dynamic phone;
@dynamic freq;
@dynamic time;
@dynamic lastcalled;

@dynamic sectionIdentifier;

#pragma mark -
#pragma mark Transient properties

- (NSString *)sectionIdentifier { 
    
    NSLog(@"SECTION IDENTIFIER CALLED");
    
    NSDate *theStartDate = self.lastcalled; // Got yesterdays date
    if(theStartDate == nil) {
        theStartDate = [[NSDate alloc] init]; // Got todays date
    }
    
    NSTimeInterval timeDiff = [theStartDate timeIntervalSinceNow]; // (60*60*24)
    NSString *sectn = [self frequencyTranslated:timeDiff];
    NSLog(sectn);
    return sectn;
}

- (NSString *) frequencyTranslated:(NSTimeInterval) timeDiff {
    int days = floor(timeDiff/(60*60*24));
    if(days < 0) {
        days = days * -1;
    }
    int calculatedF = [self.freq intValue]; // ["5d" intValue] = 5
    int dateDiff = calculatedF - days;
    
    NSLog(@"Days --> %d", days);
    NSLog(@"Calculated F --> %d", calculatedF);
    NSLog(@"Datediff --> %d", dateDiff);

    if(dateDiff < 1) { // This goes to the now section
        return @"now";
    }
    if(dateDiff < 3) { // This goes to the soon section
        return @"soon";
    }
    return @"after"; // This goes to the after section
}

+ (NSSet *)keyPathsForValuesAffectingSectionIdentifier {
    // If the value of timeStamp changes, the section identifier may change as well.
    return [NSSet setWithObject:@"freq"];
}

@end
