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

#import <CoreData/CoreData.h>

#import "Reminders.h"

@class AppDelegate;
@class DetailViewController;

@interface MasterViewController : UITableViewController <
    ABPeoplePickerNavigationControllerDelegate, NSFetchedResultsControllerDelegate>
{
    NSMutableArray *remindersNow;
    NSMutableArray *remindersSoon;
    NSMutableArray *remindersAfter;
    NSMutableArray *remindersAll;
    
    NSManagedObjectContext *managedObjectContext;
    
}

@property (strong, nonatomic) NSMutableArray *remindersNow;
@property (strong, nonatomic) NSMutableArray *remindersSoon;
@property (strong, nonatomic) NSMutableArray *remindersAfter;
@property (strong, nonatomic) NSMutableArray *remindersAll;

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void) createSettingsBarButton;
-(void) clickedSettings;
-(void) createAddContactsBarButton;
-(void) clickedAddContacts;
-(void) customizeNavBar;
-(void) customizeTable;

- (void)insertNewObject:(DetailViewController *) detailViewController;

- (void)displayPerson:(ABRecordRef)person;

@end
