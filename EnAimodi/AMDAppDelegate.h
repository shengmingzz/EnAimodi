//
//  AMDAppDelegate.h
//  EnAimodi
//
//  Created by wshm on 14-1-31.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipBoardNavigationController.h"
#import "AMDMainViewController.h"

@interface AMDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FlipBoardNavigationController * flipBoardNVC;
@property (strong, nonatomic) AMDMainViewController * mainVC;
@end
