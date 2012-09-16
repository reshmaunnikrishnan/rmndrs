//
//  SettingsViewController.h
//  Rmndrs
//
//  Created by Reshma Unnikrishnan on 01/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController {
    NSMutableArray *settings;
}

@property (nonatomic, retain) NSMutableArray *settings;


-(void) customizeTable;
-(void) populateSettings;
-(void) switchChanged;

@end
