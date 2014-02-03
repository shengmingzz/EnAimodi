//
//  AMDBaseHeaderMoreViewController.h
//  EnAimodi
//
//  Created by wshm on 14-2-2.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreFooterView.h"
#import "ASIHTTPRequest.h"
@interface AMDBaseHeaderMoreViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, EGORefreshTableHeaderDelegate, LoadMoreFooterViewDelegate>
{
    UITableView *_tableView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    LoadMoreFooterView *_loadMoreFooterView;
    BOOL _reloading;
    RequestType _requestType;
    
    NSMutableArray *baseArray;
    NSInteger _currentPage;
}
@property (nonatomic) BOOL isLoaded;
@property (retain, nonatomic) ASIHTTPRequest *baseRequest;

- (void)initBaseRequestWithPage:(NSInteger)page;
@end
