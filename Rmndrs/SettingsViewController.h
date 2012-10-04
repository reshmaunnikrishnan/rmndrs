//
//  SettingsViewController.h
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "settingDetailViewController.h"

#import <CoreData/CoreData.h>
#import "Settings.h"

#import "DDBadgeViewCell.h"

@interface SettingsViewController : UITableViewController<NSFetchedResultsControllerDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *minutesSelection;
    
    NSManagedObject *alarmManagedObject;
    NSManagedObject *reminderManagedObject;
    NSManagedObject *snoozeManagedObject;
}
@property(strong,nonatomic) settingDetailViewController *settingDetail;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(DDBadgeViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

-(void) customizeTable;
-(void) populateSettings;
-(void) switchChanged;

- (NSManagedObject *)insertNewObject:(NSString *)name type:(NSString *)type value:(NSString *)value img:(NSString *)img;

- (void)prepopulateSettings;

-(void)actionSheetFrequencyPickerPopUp:(NSManagedObject *) managedObject;

@end
