//
//  SortModel.m
//  EnAimodi
//
//  Created by wshm on 14-2-11.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "SortModel.h"

@implementation SortModel
@synthesize sortImage,sortName,sortValue;
-(void) dealloc{
    [sortName release];
    [sortImage release];
    [super dealloc];
}
@end
