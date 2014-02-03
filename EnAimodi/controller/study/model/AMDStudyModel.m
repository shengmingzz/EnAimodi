//
//  AMDStudyModel.m
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDStudyModel.h"

@implementation AMDStudyModel
@synthesize course_star_label,course_finish,course_coin_label,course_date,course_finish_per,course_id,course_image,course_title;
-(void) dealloc
{
    [course_title release];
    [course_star_label release];
    [course_image release];
    [course_id release];
    [course_finish_per release];
    [course_date release];
    [course_coin_label release];
    [super dealloc];
}
@end
