//
//  AMDCourseModel.h
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    Course_Hard_easy,
    Course_Hard_normal,
    Course_Hard_difficulty,
} Course_hard_type;

@interface AMDCourseModel : NSObject
{
    NSString *course_id;
    Course_hard_type course_hard_type;
    NSString *course_title;
//    UIImageView *course_image;
    NSString *course_image;
    NSString *course_descript;
}
@property (nonatomic,retain) NSString *course_id;
@property (nonatomic,assign) Course_hard_type course_hard_type;
@property (nonatomic,retain) NSString *course_title;
@property (nonatomic,retain) NSString *course_image;
@property (nonatomic,retain) NSString *course_descript;

@end
