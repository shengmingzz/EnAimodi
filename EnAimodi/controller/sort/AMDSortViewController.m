//
//  AMDSortViewController.m
//  EnAimodi
//
//  Created by wshm on 14-2-1.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDSortViewController.h"
#import "AMDSortToolbar.h"
#import "AMDSortCell.h"
#import "SortModel.h"
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
        SortModel *model = [[SortModel alloc] init];
        model.sortName = [NSString stringWithFormat:@"非鱼-0-%d",i];
        model.sortValue = 500 - i*20;
        [arraySort addObject:model];
        [model release];
    }
    arraySort1 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        SortModel *model = [[SortModel alloc] init];
        model.sortName = [NSString stringWithFormat:@"叶开-1-%d",i];
        model.sortValue = 10000 - i*300;
        [arraySort1 addObject:model];
        [model release];
    }
    arraySort2 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        SortModel *model = [[SortModel alloc] init];
        model.sortName = [NSString stringWithFormat:@"非墨-2-%d",i];
        model.sortValue = 200 - i*7;
        [arraySort2 addObject:model];
        [model release];
    }
    arraySort3 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        SortModel *model = [[SortModel alloc] init];
        model.sortName = [NSString stringWithFormat:@"蜜蜂-3-%d",i];
        model.sortValue = 200 - i*7;
        [arraySort3 addObject:model];
        [model release];
    }
    arraySort4 = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        SortModel *model = [[SortModel alloc] init];
        model.sortName = [NSString stringWithFormat:@"阿北-4-%d",i];
        model.sortValue = 200 - i*7;
        [arraySort4 addObject:model];
        [model release];
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
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    AMDSortCell *sortcell = (AMDSortCell*)cell;
    float red=0.0,green=0.0,blue=0.0;
    if (_currentPage == 0) {
        red = 38 + (156-38)*indexPath.row/[arraySort count];
        green = 154 + (189-154)*indexPath.row/[arraySort count];
        blue = 190 + (200-190)*indexPath.row/[arraySort count];
        sortcell.labelNum.backgroundColor = ColorRGB(red,green,blue);//156,189,200
        red = 48 + (195-48)*indexPath.row/[arraySort count];
        green = 192 + (236-192)*indexPath.row/[arraySort count];
        blue = 236 + (249-236)*indexPath.row/[arraySort count];
        sortcell.backColor.backgroundColor = ColorRGB(red,green,blue);//195,236,249
    }else if (_currentPage == 1){
        red = 207.0 - (207-205)*indexPath.row/[arraySort1 count];
        green = 120.0 + (178-120.0)*indexPath.row/[arraySort1 count];
        blue = 40 + (146-40)*indexPath.row/[arraySort1 count];
        sortcell.labelNum.backgroundColor = ColorRGB(red,green,blue);
        red = 255 + (255-255)*indexPath.row/[arraySort1 count];
        green = 153 + (223-153)*indexPath.row/[arraySort1 count];
        blue = 51 + (183-51)*indexPath.row/[arraySort1 count];
        sortcell.backColor.backgroundColor = ColorRGB(red,green,blue);//255,223,183
    }else if (_currentPage == 2){
        red = 178 + (196-178)*indexPath.row/[arraySort2 count];
        green = 65 + (161-65)*indexPath.row/[arraySort2 count];
        blue = 190 + (199-190)*indexPath.row/[arraySort2 count];
        sortcell.labelNum.backgroundColor = ColorRGB(red,green,blue);
        red = 221 + (246-221)*indexPath.row/[arraySort2 count];
        green = 81 + (202-81)*indexPath.row/[arraySort2 count];
        blue = 231 + (249-231)*indexPath.row/[arraySort2 count];
        sortcell.backColor.backgroundColor = ColorRGB(red,green,blue);//246,202,249
    }else if (_currentPage == 3){
        red = 87 + (168-87)*indexPath.row/[arraySort3 count];
        green = 167 + (193-167)*indexPath.row/[arraySort3 count];
        blue = 57 + (153-57)*indexPath.row/[arraySort3 count];
        sortcell.labelNum.backgroundColor = ColorRGB(red,green,blue);
        red = 109 + (211-109)*indexPath.row/[arraySort3 count];
        green = 240 + (240-209)*indexPath.row/[arraySort3 count];
        blue = 72 + (191-72)*indexPath.row/[arraySort3 count];
        sortcell.backColor.backgroundColor = ColorRGB(red,green,blue);//211,240,191
    }else if (_currentPage == 4){
        red = 69 + (162-69)*indexPath.row/[arraySort4 count];
        green = 69 + (162-69)*indexPath.row/[arraySort4 count];
        blue = 175 + (195-175)*indexPath.row/[arraySort4 count];
        sortcell.labelNum.backgroundColor = ColorRGB(red,green,blue);
        red = 86 + (203-86)*indexPath.row/[arraySort4 count];
        green = 86 + (203-86)*indexPath.row/[arraySort4 count];
        blue = 219 + (243-219)*indexPath.row/[arraySort4 count];
        sortcell.backColor.backgroundColor = ColorRGB(red,green,blue);//203,203,243
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollectCellIdentifier";
    AMDSortCell *cell = (AMDSortCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[AMDSortCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier]autorelease];
    }
    cell.labelNum.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.imagePhoto.image = [UIImage imageNamed:@"default_avatar.png"];

    if (_currentPage == 0) {
        SortModel *model = [arraySort objectAtIndex:indexPath.row];
        cell.labelName.text = model.sortName;
        cell.labelSort.text = [NSString stringWithFormat:@"%ld颗星",model.sortValue];
        
        float max = ((SortModel *)[arraySort objectAtIndex:0]).sortValue;
        float backwidth = ((cell.frame.size.width -44)*1.0*model.sortValue/max);
        cell.backColor.frame = CGRectMake(cell.backColor.frame.origin.x, cell.backColor.frame.origin.y, backwidth, cell.backColor.frame.size.height);
    }else if (_currentPage == 1){
        SortModel *model = [arraySort1 objectAtIndex:indexPath.row];
        cell.labelName.text = model.sortName;
        cell.labelSort.text = [NSString stringWithFormat:@"%ld金币",model.sortValue];
        
        float max = ((SortModel *)[arraySort1 objectAtIndex:0]).sortValue;
        float backwidth = ((cell.frame.size.width -44)*1.0*model.sortValue/max);
        cell.backColor.frame = CGRectMake(cell.backColor.frame.origin.x, cell.backColor.frame.origin.y, backwidth, cell.backColor.frame.size.height);
    }else if (_currentPage == 2){
        SortModel *model = [arraySort2 objectAtIndex:indexPath.row];
        cell.labelName.text = model.sortName;
        cell.labelSort.text = [NSString stringWithFormat:@"连续%ld天",model.sortValue];
        
        float max = ((SortModel *)[arraySort2 objectAtIndex:0]).sortValue;
        float backwidth = ((cell.frame.size.width -44)*1.0*model.sortValue/max);
        cell.backColor.frame = CGRectMake(cell.backColor.frame.origin.x, cell.backColor.frame.origin.y, backwidth, cell.backColor.frame.size.height);
    }else if (_currentPage == 3){
        SortModel *model = [arraySort3 objectAtIndex:indexPath.row];
        cell.labelName.text = model.sortName;
        cell.labelSort.text = [NSString stringWithFormat:@"连闯%ld关",model.sortValue];
        
        float max = ((SortModel *)[arraySort3 objectAtIndex:0]).sortValue;
        float backwidth = ((cell.frame.size.width -44)*1.0*model.sortValue/max);
        cell.backColor.frame = CGRectMake(cell.backColor.frame.origin.x, cell.backColor.frame.origin.y, backwidth, cell.backColor.frame.size.height);
    }else if (_currentPage == 4){
        SortModel *model = [arraySort4 objectAtIndex:indexPath.row];
        cell.labelName.text = model.sortName;
        cell.labelSort.text = [NSString stringWithFormat:@"%ld分钟",model.sortValue];
        
        float max = ((SortModel *)[arraySort4 objectAtIndex:0]).sortValue;
        float backwidth = ((cell.frame.size.width -44)*1.0*model.sortValue/max);
        cell.backColor.frame = CGRectMake(cell.backColor.frame.origin.x, cell.backColor.frame.origin.y, backwidth, cell.backColor.frame.size.height);
    }

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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