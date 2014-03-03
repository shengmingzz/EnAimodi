//
//  AMDCourseCell.m
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDCourseCell.h"

@implementation AMDCourseCell
@synthesize model;

-(void) dealloc
{
    [model release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *viewback = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, 210)];
        [viewback.layer setBorderWidth:0.5];
        [viewback.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [viewback.layer setCornerRadius:5.0];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:viewback];
        
        course_image = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width - 16, 160)];
        [course_image.layer setCornerRadius:5.0];
//        [course_image.layer setBorderWidth:0.5];
//        [course_image.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [course_image.layer setMasksToBounds:YES];
        [course_image setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_image];
        
        course_hot_new = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 10-3 -50, 3,  50, 50)];
        [viewback.layer setCornerRadius:5.0];
        [course_hot_new setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_hot_new];
        
        course_title_label = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, self.frame.size.width - 20, 25)];
        [course_title_label setFont:[UIFont systemFontOfSize:16.0]];
        [course_title_label setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_title_label];
        
        hard_label = [[UILabel alloc] initWithFrame:CGRectMake(75, 130, self.frame.size.width - 20, 15)];
        [hard_label setFont:[UIFont systemFontOfSize:12.0]];
        [hard_label setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:hard_label];
        
        hard_easy = [[UIImageView alloc] initWithFrame:CGRectMake(15, 130, 15, 15)];
        [viewback.layer setCornerRadius:5.0];
        [hard_easy setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:hard_easy];
        
        hard_normal = [[UIImageView alloc] initWithFrame:CGRectMake(35, 130, 15, 15)];
        [viewback.layer setCornerRadius:5.0];
        [hard_normal setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:hard_normal];
        
        hard_difficulty = [[UIImageView alloc] initWithFrame:CGRectMake(55, 130, 15, 15)];
        [viewback.layer setCornerRadius:5.0];
        [hard_difficulty setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:hard_difficulty];
        
        course_descript_label = [[UILabel alloc] initWithFrame:CGRectMake(5, 165, self.frame.size.width - 20, 40)];
        [course_descript_label setBackgroundColor:[UIColor clearColor]];
        [course_descript_label setFont:[UIFont systemFontOfSize:13.0]];
        course_descript_label.numberOfLines = 2;
        [viewback addSubview:course_descript_label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setModel:(AMDCourseModel *)_model
{
    [_model retain];
    [model release];
    model = _model;
}
-(void) drawRect:(CGRect)rect
{
    course_descript_label.text = model.course_descript;
    course_title_label.text = model.course_title;
    if (model.course_hard_type == Course_Hard_easy) {
        hard_label.text = @"新手级";
        hard_easy.image = [UIImage imageNamed:@"Icon_Level_1_Hit@2x.png"];
        hard_normal.image = [UIImage imageNamed:@"Icon_Level_2@2x.png"];
        hard_difficulty.image = [UIImage imageNamed:@"Icon_Level_3@2x.png"];
    }else if (model.course_hard_type == Course_Hard_normal){
        hard_label.text = @"进阶级";
        hard_easy.image = [UIImage imageNamed:@"Icon_Level_1@2x.png"];
        hard_normal.image = [UIImage imageNamed:@"Icon_Level_2_Hit@2x.png"];
        hard_difficulty.image = [UIImage imageNamed:@"Icon_Level_3@2x.png"];
    }else{
        hard_label.text = @"挑战级";
        hard_easy.image = [UIImage imageNamed:@"Icon_Level_1@2x.png"];
        hard_normal.image = [UIImage imageNamed:@"Icon_Level_2@2x.png"];
        hard_difficulty.image = [UIImage imageNamed:@"Icon_Level_3_Hit@2x.png"];
    }
//    course_image.image = [UIImage imageNamed:@"Bg_ModuleActive@2x.png"];
    course_image.image = [UIImage imageNamed:model.course_image];
    course_hot_new.image = [UIImage imageNamed:@"Icon_New_L@2x.png"];
}
@end
