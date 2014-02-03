//
//  AMDStudyModel.h
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMDStudyModel : NSObject
{
    NSString *course_id;
    NSString *course_title;
    NSString *course_date;
    NSString *course_image;
    float course_finish;
    NSString *course_finish_per;
    NSString *course_coin_label;
    NSString *course_star_label;

}

@property (nonatomic,retain)NSString *course_id;
@property (nonatomic,retain)NSString *course_title;
@property (nonatomic,retain)NSString *course_date;
@property (nonatomic,retain)NSString *course_image;
@property (nonatomic,assign)float course_finish;
@property (nonatomic,retain)NSString *course_finish_per;
@property (nonatomic,retain)NSString *course_coin_label;
@property (nonatomic,retain)NSString *course_star_label;

@end
