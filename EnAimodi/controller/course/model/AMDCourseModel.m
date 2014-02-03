//
//  AMDCourseModel.m
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDCourseModel.h"

@implementation AMDCourseModel
@synthesize course_descript;
@synthesize course_hard_type;
@synthesize course_image;
@synthesize course_title;
@synthesize course_id;
-(void) dealloc
{
    [course_title release];
    [course_image release];
    [course_descript release];
    [course_id release];
    [super dealloc];
}
@end
