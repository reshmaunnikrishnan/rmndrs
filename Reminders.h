//
//  Reminders.h
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 16/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reminders : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * freq;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSDate   * lastcalled;

@property (nonatomic, retain) NSString *sectionIdentifier;

- (NSString *) frequencyTranslated:(NSTimeInterval) timeDiff;

@end
