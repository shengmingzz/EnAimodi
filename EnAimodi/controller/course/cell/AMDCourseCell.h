//
//  AMDCourseCell.h
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMDCourseModel.h"
@interface AMDCourseCell : UITableViewCell
{
    AMDCourseModel *model;
    
    UILabel *course_title_label;
    UILabel *course_descript_label;
    UIImageView *course_image;
    UILabel *hard_label;
    UIImageView *hard_easy;
    UIImageView *hard_normal;
    UIImageView *hard_difficulty;
    UIImageView *course_hot_new;
}
@property(nonatomic,retain) AMDCourseModel *model;
@end
