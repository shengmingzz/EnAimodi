//
//  AMDAboutViewController.h
//  EnAimodi
//
//  Created by wshm on 14-2-11.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
typedef void (^EmailCompletionBlock)(BOOL success,MFMailComposeResult result,NSError * error );
@interface AMDAboutViewController : UITableViewController
- (void) composeEmail:(NSString*)subject body:(NSString*)body isHTML:(BOOL)isHTML recipients:(NSArray*)recipients completion:(EmailCompletionBlock)completion;
@end
