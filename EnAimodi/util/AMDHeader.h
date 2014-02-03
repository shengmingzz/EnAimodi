//
//  AMDHeader.h
//  EnAimodi
//
//  Created by wshm on 14-1-31.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#ifndef EnAimodi_AMDHeader_h
#define EnAimodi_AMDHeader_h

#define iOS_7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f     //  判断是不是 iOS 7 以上系统

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define Main_Rect_Width [UIScreen mainScreen].bounds.size.width
#define Main_Rect_Height [UIScreen mainScreen].bounds.size.height

#endif
