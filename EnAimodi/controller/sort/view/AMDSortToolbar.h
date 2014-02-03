//
//  AMDSortToolbar.h
//  EnAimodi
//
//  Created by wshm on 14-2-1.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMDSortToolbarDelegate;

@interface AMDSortToolbar : UIView
{
    int _selected;
    id<AMDSortToolbarDelegate> delegate;
}
@property(nonatomic,assign) int selected;
@property(nonatomic,assign) id<AMDSortToolbarDelegate> delegate;

-(void) btnSelected:(int)selNum;
@end

@protocol AMDSortToolbarDelegate <NSObject>
@optional
-(void) sortToolbarSelected:(int)selNum;
@end