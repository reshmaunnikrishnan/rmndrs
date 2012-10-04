//
//  settingDetailViewController.h
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 30/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalSettings.h"

@interface settingDetailViewController : UITableViewController{
    NSMutableArray *tones;
    AVAudioPlayer *player;
    int nowPlaying;
}

-(void) customizeTable;
-(void) toneChanged:(UIButton *)sender;

@end
