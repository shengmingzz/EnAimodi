//
//  AMDStudyListViewController.m
//  EnAimodi
//
//  Created by wshm on 14-2-10.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDStudyListViewController.h"
#import "JSON.h"
#import "AMDStudyDetailCell.h"
@interface AMDStudyListViewController ()

@end

@implementation AMDStudyListViewController
@synthesize baseArray;
@synthesize isLoaded;
@synthesize baseRequest;
@synthesize collectionView = _collectionView;

-(void) dealloc
{
    [baseArray release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"课程列表";
    
    [self initView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initView
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 3;
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - CGRectGetHeight(_collectionView.bounds), CGRectGetWidth(self.view.frame), CGRectGetHeight(_collectionView.bounds))];
        view.delegate = self;
        _collectionView.headerView = view;
        _refreshHeaderView = view;
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    if (_loadMoreFooterView ==nil) {
        _loadMoreFooterView = [[LoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        _loadMoreFooterView.delegate = self;
        _collectionView.footerView = _loadMoreFooterView;
    }
    
    baseArray = [[NSMutableArray alloc] init];
    
    [self loadNeiHanVideoDataSource];
}
- (void)loadNeiHanVideoDataSource
{
    [self initNeiHanVideoWithPage:_currentPage];
}
#pragma mark - ASIHTTPRequest method
#define api_neihan_video(offset)                [NSString stringWithFormat:@"http://api.jimu.me/video/?device=iPod4,1&app=iPhone&mix_list=1&sign=1831c697bbfd19e33618cfb896e9e553&category_id=33&v=2&am_user_id=142471&method=video.list&unique_id=88:C6:63:67:C4:ED&count=10&start=%d", offset]
- (void)initNeiHanVideoWithPage:(NSInteger)page
{
    self.baseRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:api_neihan_video(page * 10)]];
    
    self.baseRequest.delegate = self;
    [self.baseRequest startAsynchronous];
}
#pragma mark - PSCollectionViewDelegate and DataSource methods

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return [baseArray count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    NSDictionary *item = [baseArray objectAtIndex:index];
    
    AMDStudyDetailCell *cell = (AMDStudyDetailCell *)[_collectionView dequeueReusableViewForClass:[AMDStudyDetailCell class]];
    if (!cell) {
        cell = [[AMDStudyDetailCell alloc] initWithFrame:CGRectZero];
    }
    [cell collectionView:_collectionView fillCellWithObject:item atIndex:index];
    
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    NSDictionary *item = [baseArray objectAtIndex:index];
    
    return [AMDStudyDetailCell rowHeightForObject:item inColumnWidth:_collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
//    NSDictionary *dict = [baseArray objectAtIndex:index];
//    NeiHanVideoDetailViewController *detailVC = [[NeiHanVideoDetailViewController alloc] initWithNibName:@"NeiHanVideoDetailViewController" bundle:nil];
//    detailVC.videoDict = dict;
//    [self.navigationController pushViewController:detailVC animated:YES];
//    [detailVC release];
}

#pragma mark - UIScrollView delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_loadMoreFooterView loadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreFooterView loadMoreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    _reloading = YES;
    _requestType = RequestTypeNormal;
    
    _currentPage = 0;
    [self loadNeiHanVideoDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}


#pragma mark - LoadMoreFooterView delegate method

- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreFooterView *)view
{
    _reloading = YES;
    _requestType = RequestTypeLoadMore;
    
    _currentPage++;
    [self loadNeiHanVideoDataSource];
}

#pragma mark - ASIHTTPRequest delegate methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dic = [request.responseString JSONValue];
//    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
//    NSDictionary *dic = [jsonDecoder objectWithData:[request responseData]];
//    [jsonDecoder release];
    
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_collectionView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:_collectionView];
    }
    
    if (_requestType == RequestTypeNormal) {
        [baseArray removeAllObjects];
    }
    
    [baseArray addObjectsFromArray:[dic objectForKey:@"data"]];
    
    [self dataSourceDidLoad];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self dataSourceDidError];
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_collectionView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:_collectionView];
    }
}
- (void)dataSourceDidLoad
{
    [self.collectionView reloadData];
}
- (void)dataSourceDidError
{
    [Dialog simpleToast:@"呵呵,挂了!"];
    
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_collectionView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:_collectionView];
    }
}
@end
