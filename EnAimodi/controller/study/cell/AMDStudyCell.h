//
//  AMDStudyCell.h
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMDStudyModel.h"
@protocol AMDStudyCellDelegate;
@interface AMDStudyCell : UITableViewCell
{
    AMDStudyModel *model;
    
    UILabel *course_title;
    UILabel *course_date;
    UIImageView *course_image;
    UIProgressView *course_finish;
    UILabel *course_finish_per;
    UIImageView *image_coin;
    UILabel *course_coin_label;
    UIImageView *image_star;
    UILabel *course_star_label;
    UIImageView *image_end;
    UIButton *btn_handle;
    id<AMDStudyCellDelegate> delegate;
}
@property(nonatomic,retain) AMDStudyModel *model;
@property(nonatomic,retain) id<AMDStudyCellDelegate> delegate;
@end

@protocol AMDStudyCellDelegate <NSObject>

@optional
-(void) cellButton:(id)cell;

@end