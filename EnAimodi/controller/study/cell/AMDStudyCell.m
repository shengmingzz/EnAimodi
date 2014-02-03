//
//  AMDStudyCell.m
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDStudyCell.h"

@implementation AMDStudyCell
@synthesize model;
@synthesize delegate;
-(void) dealloc
{
    [course_image release];
    [btn_handle release];
    [course_title release];
    [course_date release];
    [course_finish release];
    [course_finish_per release];
    [image_coin release];
    [image_star release];
    [image_end release];
    [course_coin_label release];
    [course_star_label release];
    delegate = nil;
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
        [course_image.layer setMasksToBounds:YES];
        [course_image setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_image];
        
        btn_handle = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10-3 -50, 10,  40, 20)];
        [btn_handle setBackgroundColor:[UIColor clearColor]];
        [btn_handle setImage:[UIImage imageNamed:@"Btn_MoreAction@2x.png"] forState:UIControlStateNormal];
        [viewback addSubview:btn_handle];
        [btn_handle addTarget:self action:@selector(studyCellSel:) forControlEvents:UIControlEventTouchUpInside];
        
        course_title = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, self.frame.size.width - 20, 25)];
        [course_title setFont:[UIFont systemFontOfSize:16.0]];
        [course_title setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_title];
        
        course_date = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, self.frame.size.width - 20, 20)];
        [course_date setFont:[UIFont systemFontOfSize:13.0]];
        [course_date setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_date];
        
        course_finish = [[UIProgressView alloc] initWithFrame:CGRectMake(5, 165, self.frame.size.width-50, 15)];
        [viewback addSubview:course_finish];
        
        course_finish_per = [[UILabel alloc] initWithFrame:CGRectMake(5, 180, 80, 25)];
        [course_finish_per setFont:[UIFont systemFontOfSize:12.0]];
        [course_finish_per setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_finish_per];
        
        image_coin = [[UIImageView alloc] initWithFrame:CGRectMake(100, 182.5, 20, 20)];
        [viewback.layer setCornerRadius:5.0];
        [image_coin setBackgroundColor:[UIColor clearColor]];
        image_coin.image = [UIImage imageNamed:@"Icon_Point_S@2x.png"];
        [viewback addSubview:image_coin];
        
        course_coin_label = [[UILabel alloc] initWithFrame:CGRectMake(125, 180, 60, 25)];
        [course_coin_label setFont:[UIFont systemFontOfSize:12.0]];
        [course_coin_label setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_coin_label];
        
        image_star = [[UIImageView alloc] initWithFrame:CGRectMake(190, 182.5, 20, 20)];
        [viewback.layer setCornerRadius:5.0];
        [image_star setBackgroundColor:[UIColor clearColor]];
        image_star.image = [UIImage imageNamed:@"Icon_Star_Hit@2x.png"];
        [viewback addSubview:image_star];
        
        course_star_label = [[UILabel alloc] initWithFrame:CGRectMake(215, 180, 60, 25)];
        [course_star_label setFont:[UIFont systemFontOfSize:12.0]];
        [course_star_label setBackgroundColor:[UIColor clearColor]];
        [viewback addSubview:course_star_label];
        
        image_end = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 150, 30, 30)];
        [viewback.layer setCornerRadius:5.0];
        [image_end setBackgroundColor:[UIColor clearColor]];
        image_end.image = [UIImage imageNamed:@"Icon_PassDefault@2x.png"];
        [viewback addSubview:image_end];
        
        [viewback release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) drawRect:(CGRect)rect
{
    course_title.text = model.course_title;
    course_date.text = model.course_date;
    course_image.image = [UIImage imageNamed:model.course_image];
    course_finish.progress = model.course_finish;
    course_finish_per.text = model.course_finish_per;
    course_coin_label.text = model.course_coin_label;
    course_star_label.text = model.course_star_label;
}
-(void) studyCellSel:(UIButton*)sender
{
    if (delegate) {
        [delegate cellButton:self];
    }
}
@end
