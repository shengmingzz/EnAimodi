//
//  AMDMainViewController.h
//  EnAimodi
//
//  Created by wshm on 14-1-31.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMDMainViewController : UIViewController
{
    NSMutableArray* viewControllerArray;
    NSMutableArray* viewControllerIcon;
    NSMutableArray* viewControllerIconHit;
}
@property (nonatomic, retain) NSMutableArray* viewControllerArray;
@property (nonatomic, retain) NSMutableArray* viewControllerIcon;
@property (nonatomic, retain) NSMutableArray* viewControllerIconHit;
@end