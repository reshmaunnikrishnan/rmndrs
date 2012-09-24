//
//  DetailViewController.h
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIActionSheetDelegate>
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *numberLabel;
    
    IBOutlet UIButton *everyDayButton;
    IBOutlet UIButton *timeButton;
    IBOutlet UIButton *deleteButton;
        
    NSString *name;
    NSString *phone;
    NSString *viewTitle;
    NSDate   *time;
    NSString *frequency;
    
    NSManagedObjectContext *managedObjectContext;
    NSManagedObject *managedObject;
}

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UIButton *everyDayButton;
@property (nonatomic,retain) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *viewTitle;
@property (strong, nonatomic) NSDate   *time;
@property (strong, nonatomic) NSString *frequency;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObject *managedObject;

-(IBAction)actionSheetDatePickerPopUp:(id)sender;

@end
