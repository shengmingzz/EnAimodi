//
//  AMDStudyListViewController.h
//  EnAimodi
//
//  Created by wshm on 14-2-10.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMDBaseHeaderMoreViewController.h"
#import "PSCollectionView.h"
@interface AMDStudyListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, EGORefreshTableHeaderDelegate, LoadMoreFooterViewDelegate,PSCollectionViewDelegate, PSCollectionViewDataSource>
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
@property (retain, nonatomic) PSCollectionView *collectionView;
@property (retain , nonatomic) NSMutableArray *baseArray;

- (void)initBaseRequestWithPage:(NSInteger)page;
@end
