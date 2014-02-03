//
//  AMDCourseViewController.m
//  EnAimodi
//
//  Created by wshm on 14-2-2.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDCourseViewController.h"
#import "AMDCourseCell.h"
#import "AMDCourseModel.h"
@interface AMDCourseViewController ()

@end

@implementation AMDCourseViewController

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
    baseArray = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        AMDCourseModel *model = [[AMDCourseModel alloc] init];
        model.course_hard_type = Course_Hard_easy;
        model.course_title = @"驾车考试";
        model.course_descript = @"你开车吗?开车时有没有什么事情让你头痛的呢?今天我们来看看开车可能要遇到的麻烦事吧.";
        [baseArray addObject:model];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [baseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CourseCellIdentifier";
    AMDCourseCell *cell = (AMDCourseCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[AMDCourseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier]autorelease];
    }
    AMDCourseModel *model = [baseArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMDCourseCell *courseCell = (AMDCourseCell*)cell;
    [courseCell setNeedsDisplay];
}
#pragma mark - UITableView delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    _reloading = YES;
    _requestType = RequestTypeNormal;
    if (_currentPage == 0) {
        _currentPage = 0;
    }else{
        _currentPage = _currentPage - 1;
    }
//    AMDSortToolbar *toobar = (AMDSortToolbar*)[self.view viewWithTag:1123];
//    [toobar btnSelected:_currentPage];
    [self initBaseRequestWithPage:_currentPage];
}
- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreFooterView *)view
{
    _reloading = YES;
    _requestType = RequestTypeLoadMore;
    if (_currentPage == 4) {
        _currentPage = 4;
    }else{
        _currentPage++;
    }
//    AMDSortToolbar *toobar = (AMDSortToolbar*)[self.view viewWithTag:1123];
//    [toobar btnSelected:_currentPage];
    [self initBaseRequestWithPage:_currentPage];
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
@end
