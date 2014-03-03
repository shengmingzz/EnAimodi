//
//  AMDSortCell.h
//  EnAimodi
//
//  Created by wshm on 14-2-10.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMDSortCell : UITableViewCell
{
    UILabel *labelNum;
    UIImageView *imagePhoto;
    UIView *backColor;
    UILabel *labelName;
    UILabel *labelSort;
}
@property(nonatomic,retain) UILabel *labelNum;
@property(nonatomic,retain) UIImageView *imagePhoto;
@property(nonatomic,retain) UIView *backColor;
@property(nonatomic,retain) UILabel *labelName;
@property(nonatomic,retain) UILabel *labelSort;
@end
