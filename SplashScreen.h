//
//  SplashScreen.h
//  Rmndrs
//
//  Created by Dinesh Vasudevan on 03/09/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreen : UIViewController{
    IBOutlet UIView *splashView;
}
@property(nonatomic,retain) IBOutlet UIView *splashView;

-(void)showSplash;
-(void)hideSplash;
@end
