//
//  MasterViewController.h
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <
    ABPeoplePickerNavigationControllerDelegate>
{
    NSMutableArray *remindersNow;
    NSMutableArray *remindersSoon;
    NSMutableArray *remindersAfter;
    NSMutableArray *remindersAll;
}

@property (strong, nonatomic) NSMutableArray *remindersNow;
@property (strong, nonatomic) NSMutableArray *remindersSoon;
@property (strong, nonatomic) NSMutableArray *remindersAfter;
@property (strong, nonatomic) NSMutableArray *remindersAll;

@property (strong, nonatomic) DetailViewController *detailViewController;

-(void) createSettingsBarButton;
-(void) clickedSettings;
-(void) createAddContactsBarButton;
-(void) clickedAddContacts;
-(void) customizeNavBar;
-(void) customizeTable;

-(void) getAllReminderDetails;

- (void)displayPerson:(ABRecordRef)person;

@end
