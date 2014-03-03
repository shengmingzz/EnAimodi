//
//  SortModel.h
//  EnAimodi
//
//  Created by wshm on 14-2-11.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortModel : NSObject
{
    NSString *sortName;
    long sortValue;
    NSString *sortImage;
}
@property(nonatomic,retain) NSString *sortName;
@property(nonatomic,assign) long sortValue;
@property(nonatomic,retain) NSString *sortImage;
@end
