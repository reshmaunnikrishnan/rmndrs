//
//  MasterViewController.m
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "SettingsViewController.h"

#import "GlobalSettings.h"

#import "DDBadgeViewCell.h"

#define NAVCOLOR [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]

#define NOWBADGESECTION 0
#define SOONBADGESECTION 1
#define AFTERBADGESECTION 2

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

@synthesize remindersAll;
@synthesize remindersNow;
@synthesize remindersSoon;
@synthesize remindersAfter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Rmndrs", @"Rmndrs");
        self.tableView.rowHeight = 60.0;
    }
    return self;
}
							
- (void)dealloc
{
//    [_detailViewController release];
//    [super dealloc];
}

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
    [self customizeNavBar];
    [self createSettingsBarButton];
    [self createAddContactsBarButton];
    
    [self customizeTable];
    
    [self getAllReminderDetails];
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [remindersAll count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dictionary = [remindersAll objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Reminders"];
    return [array count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    DDBadgeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DDBadgeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSDictionary *dictionary = [remindersAll objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Reminders"];
    NSDictionary *details = [array objectAtIndex:indexPath.row];
    
    cell.summary = [details objectForKey:@"name"];
    cell.detail = [details objectForKey:@"number"];
    
    if(indexPath.section == NOWBADGESECTION) {
        cell.badgeText = @"Now";
        cell.badgeColor = [GlobalSettings badgeNowColor];
    } else if(indexPath.section == SOONBADGESECTION) {
        cell.badgeText = @"Soon";
        cell.badgeColor = [GlobalSettings badgeSoonColor];
    } else if(indexPath.section == AFTERBADGESECTION) {
        cell.badgeText = @"After";
        cell.badgeColor = [GlobalSettings badgeAfterColor];
    }
    
    cell.badgeHighlightedColor = [GlobalSettings badgeSelectedColor];
    
    cell.imageView.image = [UIImage imageNamed:@"contact.png"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(DDBadgeViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setFont:[GlobalSettings baseFont:19.0]];
    [cell setBackgroundColor:[GlobalSettings baseCellBackgroundColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    
    NSDictionary *dictionary = [remindersAll objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Reminders"];
    NSDictionary *details = [array objectAtIndex:indexPath.row];
    
    self.detailViewController.name = [details objectForKey:@"name"];
    self.detailViewController.phone = [details objectForKey:@"number"];
    
    self.detailViewController.frequency = [details objectForKey:@"frequency"];
    self.detailViewController.time = [GlobalSettings convertStringToDate:[details objectForKey:@"time"]];
    
    self.detailViewController.viewTitle = @"Edit Rmndr";
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

-(void) createSettingsBarButton
{
    UIImage* settingsImg = [UIImage imageNamed:@"settings.png"];
    CGRect frameimg = CGRectMake(0, 0, 40, 40);
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:frameimg];
    [settingsButton setImage:settingsImg forState:UIControlStateNormal];

    [settingsButton addTarget:self action:@selector(clickedSettings)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *settingsBarButton =[[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    self.navigationItem.leftBarButtonItem = settingsBarButton;
}

-(void) clickedSettings
{
    SettingsViewController *settings = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settings animated:YES];}

-(void) createAddContactsBarButton
{
    UIImage* contactsImg = [UIImage imageNamed:@"contact.png"];
    CGRect frameimg = CGRectMake(0, 0, 40, 40);
    UIButton *contactsButton = [[UIButton alloc] initWithFrame:frameimg];
    [contactsButton setImage:contactsImg forState:UIControlStateNormal];
    
    [contactsButton addTarget:self action:@selector(clickedAddContacts)
             forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *contactsBarButton =[[UIBarButtonItem alloc] initWithCustomView:contactsButton];
    self.navigationItem.rightBarButtonItem = contactsBarButton;
}

-(void) clickedAddContacts
{
    // creating the picker
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	// place the delegate of the picker to the controll
	picker.peoplePickerDelegate = self;
	
	// showing the picker
	[self presentModalViewController:picker animated:YES];
	// releasing
//	[picker release];
}

-(void) customizeNavBar
{
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0], 
        UITextAttributeTextColor, 
      [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9], 
        UITextAttributeTextShadowColor, 
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], 
        UITextAttributeTextShadowOffset, 
      [GlobalSettings baseFont:22.0], 
        UITextAttributeFont, 
      nil]];
    
    UIImage *button30 = [UIImage imageNamed:@"button_textured_30.png"];
    UIImage *button24 = [UIImage imageNamed:@"button_textured_24.png"];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsLandscapePhone];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8], 
      UITextAttributeTextColor, 
      [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8], 
      UITextAttributeTextShadowColor, 
      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], 
      UITextAttributeTextShadowOffset, 
      [GlobalSettings baseFont:0.0], 
      UITextAttributeFont, 
      nil] 
    forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1], 
      UITextAttributeTextColor, 
      [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1], 
      UITextAttributeTextShadowColor, 
      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], 
      UITextAttributeTextShadowOffset, 
      [GlobalSettings baseFont:0.0], 
      UITextAttributeFont, 
      nil] 
    forState:UIControlStateHighlighted];
    
    UIImage *buttonBack30 = [[UIImage imageNamed:@"button_back_textured_30"] 
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    UIImage *buttonBack24 = [[UIImage imageNamed:@"button_back_textured_24"] 
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    self.navigationController.navigationBar.tintColor = NAVCOLOR;
    
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:@"denim.png"] 
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *NavigationLandscapeBackground = [[UIImage imageNamed:@"denim.png"] 
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground 
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground 
                                       forBarMetrics:UIBarMetricsLandscapePhone];
}

-(void) customizeTable 
{
    self.tableView.backgroundColor = [GlobalSettings backImage];
}

-(void) getAllReminderDetails
{
    remindersSoon = [[NSMutableArray alloc] init];
    remindersAfter = [[NSMutableArray alloc] init];
    remindersNow = [[NSMutableArray alloc] init];

    [remindersNow addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Jayasurian Makoth", @"name", @"1509827387", @"number", @"1d", @"frequency", @"02:40 PM", @"time", nil]];
    [remindersNow addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Dinesh Vasudevan", @"name", @"847384738", @"number", @"3d", @"frequency", @"12:50 PM", @"time", nil]];
    [remindersNow addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Unnikrishnan", @"name", @"9889080982", @"number", @"4d", @"frequency", @"05:30 AM",@"time", nil]];
    NSDictionary *remindersNowDict = [NSDictionary dictionaryWithObject:remindersNow forKey:@"Reminders"];
    
    [remindersAfter addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Thangu", @"name", @"9090098984", @"number", @"3d", @"frequency", @"10:20 AM", @"time", nil]];
    [remindersAfter addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Ponnu", @"name", @"8748789749", @"number", @"5d", @"frequency", @"01:00 PM", @"time", nil]];
    NSDictionary *remindersAfterDict = [NSDictionary dictionaryWithObject:remindersAfter forKey:@"Reminders"];
    
    [remindersSoon addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Peratta Thalla", @"name", @"7632763862", @"number",@"10d", @"frequency", @"04:30 PM", @"time", nil]];
    NSDictionary *remindersSoonDict = [NSDictionary dictionaryWithObject:remindersSoon forKey:@"Reminders"];
    
    remindersAll = [[NSMutableArray alloc] init];
    
    [remindersAll addObject:remindersNowDict];
    [remindersAll addObject:remindersSoonDict];
    [remindersAll addObject:remindersAfterDict];
}

-(void) clearAllReminderDetails
{

}

// Picker Controller Callback Start

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    [self displayPerson:person];
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)displayPerson:(ABRecordRef)person 
{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    
    self.detailViewController.name = name;
    self.detailViewController.phone = phone;
    
    self.detailViewController.viewTitle = @"New Rmndr";
    
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
}

// Picker Controller Callback End

@end
