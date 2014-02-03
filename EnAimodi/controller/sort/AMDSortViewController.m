//
//  AMDSortViewController.m
//  EnAimodi
//
//  Created by wshm on 14-2-1.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDSortViewController.h"
#import "AMDSortToolbar.h"
@interface AMDSortViewController ()
{
    NSMutableArray *arraySort;
    NSMutableArray *arraySort1;
    NSMutableArray *arraySort2;
    NSMutableArray *arraySort3;
    NSMutableArray *arraySort4;
}
@end

@implementation AMDSortViewController

-(void) dealloc
{
    [_tableView release];
    [_refreshHeaderView release];
    [_loadMoreFooterView release];
    
    [arraySort release];
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
    arraySort = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        [arraySort addObject:[NSString stringWithFormat:@"arraySort--0 -- %d",i]];
    }
    arraySort1 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        [arraySort1 addObject:[NSString stringWithFormat:@"arraySort--1 -- %d",i]];
    }
    arraySort2 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        [arraySort2 addObject:[NSString stringWithFormat:@"arraySort--2 -- %d",i]];
    }
    arraySort3 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        [arraySort3 addObject:[NSString stringWithFormat:@"arraySort--3 -- %d",i]];
    }
    arraySort4 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        [arraySort4 addObject:[NSString stringWithFormat:@"arraySort--4 -- %d",i]];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height-44)];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - CGRectGetHeight(_tableView.bounds), CGRectGetWidth(self.view.frame), CGRectGetHeight(_tableView.bounds))];
        view.delegate = self;
        [_tableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    if (_loadMoreFooterView ==nil) {
        _loadMoreFooterView = [[LoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        _loadMoreFooterView.delegate = self;
        _tableView.tableFooterView = _loadMoreFooterView;
        _tableView.tableFooterView.hidden = NO;
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    _requestType = RequestTypeNormal;
    _currentPage = 0;
    _articlesArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self initArticlesRequestWithPage:_currentPage];

    AMDSortToolbar *toolbar = [[AMDSortToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44,self.view.frame.size.width, 44)];
    [toolbar setTag:1123];
    toolbar.delegate = self;
    [toolbar setBackgroundColor:[UIColor redColor]];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolbar];
    [toolbar release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    AMDSortToolbar *toobar = (AMDSortToolbar*)[self.view viewWithTag:1123];
    NSLog(@"toolbar:%f",toobar.frame.origin.y);
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentPage == 0) {
        return [arraySort count];
    }else if (_currentPage == 1){
        return [arraySort1 count];
    }else if (_currentPage == 2){
        return [arraySort2 count];
    }else if (_currentPage == 3){
        return [arraySort3 count];
    }else if (_currentPage == 4){
        return [arraySort4 count];
    }
    return [arraySort count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollectCellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier]autorelease];
    }
    NSString *string = @"";
    if (_currentPage == 0) {
        string = [arraySort objectAtIndex:indexPath.row];
    }else if (_currentPage == 1){
        string = [arraySort1 objectAtIndex:indexPath.row];
    }else if (_currentPage == 2){
        string = [arraySort2 objectAtIndex:indexPath.row];
    }else if (_currentPage == 3){
        string = [arraySort3 objectAtIndex:indexPath.row];
    }else if (_currentPage == 4){
        string = [arraySort4 objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = string;
    return cell;
}

#pragma mark - UITableView delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [QiuShiCell getCellHeight:[_articlesArray objectAtIndex:indexPath.row]];
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    QiuShiDetailViewController *detailVC = [[QiuShiDetailViewController alloc] initWithNibName:@"QiuShiDetailViewController" bundle:nil];
//    QiuShi *qs = (QiuShi *)[_articlesArray objectAtIndex:indexPath.row];
//    detailVC.qiushi = qs;
//    detailVC.title = [NSString stringWithFormat:@"糗事%@", qs.qiushiID];
//    [self.navigationController pushViewController:detailVC animated:YES];
//    [detailVC release];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollView delegate method
#pragma mark -
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
    if (_currentPage == 0) {
        _currentPage = 0;
    }else{
        _currentPage = _currentPage - 1;
    }
    AMDSortToolbar *toobar = (AMDSortToolbar*)[self.view viewWithTag:1123];
    [toobar btnSelected:_currentPage];
    [self initArticlesRequestWithPage:_currentPage];
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
    if (_currentPage == 4) {
        _currentPage = 4;
    }else{
        _currentPage++;
    }
    AMDSortToolbar *toobar = (AMDSortToolbar*)[self.view viewWithTag:1123];
    [toobar btnSelected:_currentPage];
    [self initArticlesRequestWithPage:_currentPage];
}

#pragma mark - ASIHttpRequest delegate methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:_tableView];
    }
    
    if (_requestType == RequestTypeNormal) {
//        [_articlesArray removeAllObjects];
    }
    
    [_tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Dialog simpleToast:@"网络不行了..."];
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:_tableView];
    }
    [_tableView reloadData];
}
- (void)initArticlesRequestWithPage:(NSInteger)page
{
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    self.articlesRequest = [ASIHTTPRequest requestWithURL:url];
    [self.articlesRequest setRequestMethod:@"GET"];
    self.articlesRequest.delegate = self;
    [self.articlesRequest startAsynchronous];
}
#pragma mark- amdtoolbar delegate
-(void) sortToolbarSelected:(int)selNum
{
    _reloading = YES;
    _requestType = RequestTypeLoadMore;
    _currentPage = selNum;
    [self initArticlesRequestWithPage:_currentPage];
}
@end