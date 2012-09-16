//
//  SettingsViewController.m
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "SettingsViewController.h"
#import "GlobalSettings.h"

#import "DDBadgeViewCell.h"

@implementation SettingsViewController

@synthesize settings;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Settings", @"Settings");
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
    [self populateSettings];
    
    [self customizeTable];
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DDBadgeViewCell *cell;
    
    NSDictionary *cellDict = [settings objectAtIndex:indexPath.row];
    NSString *badgeValue = [cellDict objectForKey:@"badge"];
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if(badgeValue == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        } else {
            cell = [[DDBadgeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withImage:TRUE];
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(badgeValue == nil) {
        cell.textLabel.text = [cellDict objectForKey:@"title"];
//        if([[cellDict objectForKey:@"tpe"] isEqualToString:@"switch"]) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            cell.accessoryView = switchView;
            [switchView setOn:NO animated:NO];
            [switchView addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
//            [switchView release];
//        }
    } else {
        cell.summary = [cellDict objectForKey:@"title"];
        
        cell.imageView.image = [UIImage imageNamed:[cellDict objectForKey:@"img"]];
        
        if(badgeValue != nil) {
            cell.badgeText = badgeValue;
        }
        
        cell.badgeHighlightedColor = [GlobalSettings badgeSelectedColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(DDBadgeViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setFont:[GlobalSettings baseFont:19.0]];
    [cell setBackgroundColor:[GlobalSettings baseCellBackgroundColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void) customizeTable 
{
        self.tableView.backgroundColor = [GlobalSettings backImage];
}

-(void) populateSettings
{
    NSDictionary *alarmRow = [NSDictionary dictionaryWithObjectsAndKeys:@"Alarm Tone", 
                              @"title", @"ringtone1", @"badge", 
                              @"button", @"tpe", @"music.png", @"img", nil];
    NSDictionary *reminderRow = [NSDictionary dictionaryWithObjectsAndKeys:@"Remind Before", 
                              @"title", @"10 Minutes", @"badge", 
                              @"button", @"tpe", @"alarm.png", @"img", nil];
    NSDictionary *snoozeRow = [NSDictionary dictionaryWithObjectsAndKeys:@"Snooze", 
                                 @"title", nil, @"badge", @"switch", @"tpe", nil];
    settings = [[NSMutableArray alloc]init];
    [settings addObject:alarmRow];
    [settings addObject:reminderRow];
    [settings addObject:snoozeRow];
}

-(void) switchChanged
{
    
}

@end
