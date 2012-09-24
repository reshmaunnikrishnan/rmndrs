//
//  MasterViewController.h
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <CoreData/CoreData.h>

#import "Reminders.h"

#import "DDBadgeViewCell.h"

@class AppDelegate;
@class DetailViewController;

@interface MasterViewController : UITableViewController <
    ABPeoplePickerNavigationControllerDelegate, NSFetchedResultsControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void) createSettingsBarButton;
-(void) clickedSettings;
-(void) createAddContactsBarButton;
-(void) clickedAddContacts;
-(void) customizeNavBar;
-(void) customizeTable;

- (NSManagedObject *)insertNewObject:(NSString *)name phone:(NSString *)phone time:(NSDate *)time frequency:(NSString *)freq;

- (void)displayPerson:(ABRecordRef)person;

- (void)configureCell:(DDBadgeViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
