//
//  DetailViewController.m
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "DetailViewController.h"

#import "GlobalSettings.h"

#define datePickerTag 100

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize nameLabel;
@synthesize numberLabel;
@synthesize everyDayButton;
@synthesize timeButton;
@synthesize deleteButton;

@synthesize name;
@synthesize phone;
@synthesize viewTitle;
@synthesize time;
@synthesize frequency;

@synthesize managedObject;
@synthesize managedObjectContext = __managedObjectContext;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Stripe.png"]];
    
    [self.nameLabel setFont:[GlobalSettings baseFont:21.0]];
    [self.numberLabel setFont:[GlobalSettings baseFont:19.0]];
    [self.everyDayButton.titleLabel setFont:[GlobalSettings baseFont:21.0]];
    [self.timeButton.titleLabel setFont:[GlobalSettings baseFont:21.0]];
    [self.deleteButton.titleLabel setFont:[GlobalSettings baseFont:19.0]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(managedObject != nil) {
        name = [managedObject valueForKey:@"name"];
        phone = [managedObject valueForKey:@"phone"];
        frequency = [managedObject valueForKey:@"freq"];
        time = [managedObject valueForKey:@"time"];
    }
    
    if (name != nil) {
        nameLabel.text = name;
    }
    
    if (phone != nil) {
        numberLabel.text = phone;
    }
    
    if (viewTitle != nil) {
        self.title = viewTitle;
    }
    
    [timeButton setTitle:[GlobalSettings interpretUserTime:time] forState:UIControlStateNormal];
} 

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

// Time Picker Code

-(IBAction)actionSheetDatePickerPopUp:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choose Time",@"Choose Time")delegate:self cancelButtonTitle:NSLocalizedString(@"Done",@"Done")
                                               destructiveButtonTitle:NSLocalizedString(@"Cancel",@"Cancel")
                                                    otherButtonTitles:nil]; 
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(30, 160, 0, 0)];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker setMinuteInterval:10];
    
    [datePicker setDate:time];                            
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    [actionSheet addSubview:datePicker];

    [datePicker setTag: datePickerTag];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex]) 
    {    
        UIDatePicker *datePicker = (UIDatePicker *) [actionSheet viewWithTag: datePickerTag];
        
        time = datePicker.date;
        [timeButton setTitle:[GlobalSettings interpretUserTime:time] forState:UIControlStateNormal]; 
        
        if(managedObject) {
            [managedObject setValue:time forKey:@"time"];
        }
        
    }
}

// Time Picker Code End
							
@end
