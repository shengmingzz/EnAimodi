//
//  AMDSortCell.m
//  EnAimodi
//
//  Created by wshm on 14-2-10.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDSortCell.h"

@implementation AMDSortCell
@synthesize labelName,labelNum,labelSort,imagePhoto,backColor;
- (void) dealloc
{
    [labelName release];
    [labelNum release];
    [labelSort release];
    [imagePhoto release];
    [backColor release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        labelNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, self.frame.size.height)];
        [labelNum setFont:[UIFont systemFontOfSize:16.0]];
        [labelNum setAutoresizesSubviews:YES];
        [labelNum setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:labelNum];
        [labelNum setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [labelNum setTextAlignment:NSTextAlignmentCenter];
        
        backColor = [[UIView alloc] initWithFrame:CGRectMake(44, 0, 0, self.frame.size.height)];
        [backColor setBackgroundColor:[UIColor clearColor]];
        [backColor setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self.contentView addSubview:backColor];
        
        labelName = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, self.frame.size.height)];
        [labelName setFont:[UIFont systemFontOfSize:14.0]];
        [labelName setAutoresizesSubviews:YES];
        [labelName setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:labelName];
        
        labelSort = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-120, 0, 110, self.frame.size.height)];
        [labelSort setFont:[UIFont systemFontOfSize:14.0]];
        [labelSort setAutoresizesSubviews:YES];
        [labelSort setTextColor:[UIColor grayColor]];
        [labelSort setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:labelSort];
        
        imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(53, (self.frame.size.height-36)/2, 36, 36)];
        [imagePhoto setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:imagePhoto];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
