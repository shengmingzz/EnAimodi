//
//  AMDSortViewController.h
//  EnAimodi
//
//  Created by wshm on 14-2-1.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreFooterView.h"
#import "ASIHTTPRequest.h"
#import "RMStepsBar.h"
#import "AMDSortToolbar.h"
@interface AMDSortViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, EGORefreshTableHeaderDelegate, LoadMoreFooterViewDelegate,AMDSortToolbarDelegate>
{
    UITableView *_tableView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    LoadMoreFooterView *_loadMoreFooterView;
    BOOL _reloading;
    RequestType _requestType;
    
    NSMutableArray *_articlesArray;
    NSInteger _currentPage;
}
@property (nonatomic) BOOL isLoaded;
@property (retain, nonatomic) ASIHTTPRequest *articlesRequest;

@end
