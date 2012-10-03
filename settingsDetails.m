//
//  settingsDetails.m
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 28/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "settingsDetails.h"

@implementation settingsDetails

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    remindme= [[NSMutableArray alloc]init ];
               [remindme addObject:@"5mins"];
               [remindme addObject:@"10mins"];
                [remindme addObject:@"15mins"];
    [remindme addObject:@"30mins"];
    [remindme addObject:@"1hours"];


    
    //uilabel programmatically
    UILabel *remindmeLabel=[ [UILabel alloc ] initWithFrame:CGRectMake( 10,30, 100.0, 43.0)];
    remindmeLabel.textAlignment =  UITextAlignmentCenter;
    remindmeLabel.lineBreakMode =UILineBreakModeCharacterWrap;
    remindmeLabel.shadowColor=[UIColor blueColor];
    [remindmeLabel setFont:[GlobalSettings baseFont:18]];
    [remindmeLabel setBackgroundColor:[GlobalSettings baseCellBackgroundColor]];
    remindmeLabel.text = [NSString stringWithFormat: @ "Remind me Before"];
    [self.view addSubview:remindmeLabel];
    //ends here
    
    
 //   UITextField *remindmeText =[[UITextField alloc]initWithFrame:CGRectMake(122, 30, 150, 43)];
//    remindmeText.borderStyle = UITextBorderStyleRoundedRect;
//    remindmeText.font = [UIFont systemFontOfSize:15];
//    remindmeText.placeholder = @"enter text";
//    remindmeText.autocorrectionType = UITextAutocorrectionTypeNo;
//    remindmeText.keyboardType = UIKeyboardTypeDefault;
//    remindmeText.returnKeyType = UIReturnKeyDone;
//    remindmeText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    remindmeText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
//    remindmeText.delegate = self;
//    [remindmeText setReturnKeyType:UIReturnKeyDone];
//    [remindmeText addTarget:self
//                       action:@selector(textFieldFinished:)
//             forControlEvents:UIControlEventEditingDidEndOnExit];    
//    [remindmeText resignFirstResponder];
//
//    [self.view addSubview:remindmeText];
    
   // [self.view addSubview:remindmeText];
    
    //creating UiButton programmatically
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self 
               action:@selector(pickerPopUp:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(122.0, 30.0, 150.0, 43.0);
    [self.view addSubview:button];
    
    //end of uibutton program
    

   
}
-(void)pickerPopUp:(id)sender{
    
    UIActionSheet *actionsheet1 =[[UIActionSheet alloc]initWithTitle:NSLocalizedString(@"Remind me Before", @"Remind me Before") delegate:self cancelButtonTitle:NSLocalizedString(@"Done",@"Done")destructiveButtonTitle:NSLocalizedString(@"Cancel",@"Cancel") otherButtonTitles:nil];
    
    actionsheet1.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    UIPickerView *picker =[[UIPickerView alloc]initWithFrame:CGRectMake(30, 160, 260, 120)];
    picker.delegate=self;
    picker.dataSource=self;
    [actionsheet1 showInView:[[UIApplication sharedApplication] keyWindow]];
                      
          [actionsheet1 setBounds:CGRectMake(0, 0, 320, 485)];
    [actionsheet1 addSubview:picker];

    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [remindme count];
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [remindme objectAtIndex:row];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
