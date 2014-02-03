//
//  AMDStudyViewController.h
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMDStudyCell.h"
@interface AMDStudyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AMDStudyCellDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_baseArray;
}
@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *baseArray;
@end
