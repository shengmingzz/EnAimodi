//
//  AMDUtil.m
//  EnAimodi
//
//  Created by wshm on 14-2-10.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDUtil.h"

@implementation AMDUtil
+(UIBarButtonItem*) defaultRetLeftBarWithTarget:(id)target action:(SEL)action
{
    UIButton * btn =[[[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 43, 36.0f)]autorelease];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"Btn_Back@2x.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Btn_Back_Hit@2x.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem* item = [[[UIBarButtonItem alloc] initWithCustomView:btn]autorelease];
    return item;
}

@end
