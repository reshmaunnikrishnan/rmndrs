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
#define freqPickerTag 200

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
@synthesize freqDays;
@synthesize freqDayConverted;

@synthesize managedObject;
@synthesize managedObjectContext;

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
    
    freqDays = [[NSMutableArray alloc]init];
    [freqDays addObject:@"1d"];
    [freqDays addObject:@"2d"];
    [freqDays addObject:@"3d"];
    [freqDays addObject:@"4d"];
    [freqDays addObject:@"5d"];
    [freqDays addObject:@"6d"];
    [freqDays addObject:@"7d"];
    
    freqDayConverted = [[NSMutableArray alloc]init];
    for (int i=0; i < [freqDays count]; ++i) {
        [freqDayConverted addObject:[GlobalSettings interpretUserfrequency:[freqDays objectAtIndex:i]]];
    }
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
    [everyDayButton setTitle:[GlobalSettings interpretUserfrequency:frequency ]forState:UIControlStateNormal ];
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
    if (buttonIndex == [actionSheet cancelButtonIndex]) {    
        UIDatePicker *datePicker = (UIDatePicker *) [actionSheet viewWithTag: datePickerTag];
        UIPickerView *freqpicker = (UIPickerView *)[actionSheet viewWithTag:freqPickerTag];
        NSLog(@"GOT THE DONE EVENT");
        if(datePicker) {
            time = datePicker.date;
            [timeButton setTitle:[GlobalSettings interpretUserTime:time] forState:UIControlStateNormal]; 
            if(managedObject) {
                [managedObject setValue:time forKey:@"time"];
                NSError *error = nil;
                if (![managedObjectContext save:&error]) {
                    /*
                 
                     Replace this implementation with code to handle the error appropriately.
                     
                     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                     */
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
            }
        }
        if (freqpicker) {
            int row = [freqpicker selectedRowInComponent:0];
            frequency = [freqDays objectAtIndex:row];
            [everyDayButton setTitle:[freqDayConverted objectAtIndex:row] forState:UIControlStateNormal]; 
            if(managedObject) {
                [managedObject setValue:frequency forKey:@"freq"];
                NSError *error = nil;
                if (![managedObjectContext save:&error]) {
                    /*
                     
                     Replace this implementation with code to handle the error appropriately.
                     
                     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                     */
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
            }
        }
    }
}

// Time Picker Code End

// Frequency Picker Code

-(IBAction)actionSheetFrequencyPickerPopUp:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choose Frequency",@"Choose Frequency")delegate:self cancelButtonTitle:NSLocalizedString(@"Done",@"Done")
                                               destructiveButtonTitle:NSLocalizedString(@"Cancel",@"Cancel")
                                                    otherButtonTitles:nil]; 
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    UIPickerView *freqpicker = [[UIPickerView alloc]initWithFrame:CGRectMake(30, 160, 260, 120)];
    freqpicker.showsSelectionIndicator = YES;
    freqpicker.dataSource = self;
    freqpicker.delegate=self;
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
    [freqpicker selectRow:[freqDays indexOfObject:frequency] inComponent:0 animated:NO];
    
    [actionSheet addSubview:freqpicker];
    [freqpicker setTag:freqPickerTag];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [freqDayConverted count];
}
    
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [freqDayConverted objectAtIndex:row];
}    

// Frequency Picker Code End

// Delete Button Callback

-(IBAction)deleteReminder:(id)sender {
    if (managedObjectContext != nil && managedObject != nil) {
        [managedObjectContext deleteObject:managedObject];
        // Save the context.
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

    }
    [self.navigationController popViewControllerAnimated:YES];
}

// End Delete Button Callback
							
@end
