//
//  AMDMoreCell.m
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDMoreCell.h"

@implementation AMDMoreCell
@synthesize imageSide,des;
-(void) dealloc
{
    [imageSide release];
    [des release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imageSide = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7.5, 29, 29)];
        [imageSide setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:imageSide];
        des = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.frame.size.width-50, self.frame.size.height)];
        [des setBackgroundColor:[UIColor clearColor]];
        [des setFont:[UIFont systemFontOfSize:14.0]];
        [self.contentView addSubview:des];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
