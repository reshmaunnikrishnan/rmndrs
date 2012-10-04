//
//  settingDetailViewController.m
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 30/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "settingDetailViewController.h"

@implementation settingDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    tones = [[NSMutableArray alloc] init];
    [tones addObject:@"flo_rida-blow_my_whistle"];
    [tones addObject:@"Maroon_5-Payphone"];
    [tones addObject:@"psy-gangnam_style"];
    
    nowPlaying = -1;  
    
    [self customizeTable];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@" %d", [tones count]);
    return [tones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tones objectAtIndex:indexPath.row];

    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton setImage:[UIImage imageNamed:@"play-icon.png"] forState:UIControlStateNormal];
    [playButton setFrame:CGRectMake(0, 0, 35, 35)];
    playButton.backgroundColor = [UIColor clearColor];
    playButton.layer.cornerRadius = 20.0f;
    [playButton setTag:indexPath.row];
    
    [playButton addTarget:self action:@selector(toneChanged:) forControlEvents:UIControlEventTouchDown];
    
    cell.accessoryView = playButton;
    
    return cell;
}

-(void) toneChanged:(UIButton *)sender {
    int tag = sender.tag;
    
    UITableView *tableView = [self tableView];
    
    NSArray *indices = [tableView indexPathsForVisibleRows];
    
    for(int i=0; i < [indices count]; ++i) {
        UIButton *playButton = (UIButton *)[tableView cellForRowAtIndexPath:[indices objectAtIndex:i]].accessoryView;
        if(playButton) {
            [playButton setImage:[UIImage imageNamed:@"play-icon.png"] forState:UIControlStateNormal];
        }
    }
    
    // If a sound is playing stop it
    if (player) {
        [player stop];
        player = nil;
    }
    
    if(tag != nowPlaying) {
        if(!player){
            NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
            NSString *m4rFile = [NSString stringWithFormat:@"/%@.m4r", [tones objectAtIndex:tag]];
            resourcePath = [resourcePath stringByAppendingString:m4rFile];
            NSError* err;
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:
            [NSURL fileURLWithPath:resourcePath] error:&err];
            if( err ){
                NSLog(@"Failed with reason: %@", [err localizedDescription]);
            } else {
                player.delegate = self;
            }
        }
        if(player) {
            [player play];
            nowPlaying = tag;
            [sender setImage:[UIImage imageNamed:@"stop-icon.png"] forState:UIControlStateNormal];
        }
    } else {
        nowPlaying = -1;
    }
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellSelected = [tableView cellForRowAtIndexPath:indexPath];
    
    UIButton *thisBut = (UIButton *)cellSelected.accessoryView;
    thisBut.highlighted = NO;
    
//	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = @"Select a Tone";
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 10, 284, 23);
    label.textColor = [UIColor blackColor];
    label.font = [GlobalSettings baseFont:21.0];
    label.text = sectionTitle;
    label.backgroundColor = [UIColor clearColor];
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setFont:[GlobalSettings baseFont:19.0]];
    [cell setBackgroundColor:[GlobalSettings baseCellBackgroundColor]];
}

-(void) customizeTable 
{
    self.tableView.backgroundColor = [GlobalSettings backImage];
}

// AV Callback
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
}

@end
