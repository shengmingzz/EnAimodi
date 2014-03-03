//
//  AMDStudyViewController.m
//  EnAimodi
//
//  Created by wshm on 14-2-3.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDStudyViewController.h"
#import "AMDStudyModel.h"
#import "AMDStudyCell.h"

#import "AMDStudyListViewController.h"
#import "FlipBoardNavigationController.h"
@interface AMDStudyViewController ()

@end

@implementation AMDStudyViewController
@synthesize tableView = _tableView;
@synthesize baseArray = _baseArray;
-(void) dealloc
{
    [_tableView release];
    [_baseArray release];
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
    _baseArray = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        AMDStudyModel *model = [[AMDStudyModel alloc] init];
        model.course_title = @"50个州";
//        model.course_image = @"bg_dashboard_default@2x.jpg";
        model.course_image = [NSString stringWithFormat:@"0%d.jpg",i];//@"bg_dashboard_default@2x.jpg";
        model.course_date = @"20天前";
        model.course_finish_per = @"10%完成";
        model.course_star_label = @"1/30";
        model.course_coin_label = @"21/265";
        model.course_finish = 0.3;
        [_baseArray addObject:model];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_baseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"studyCellIdentifier";
    AMDStudyCell *cell = (AMDStudyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[AMDStudyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier]autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    AMDStudyModel *model = [_baseArray objectAtIndex:indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMDStudyCell *courseCell = (AMDStudyCell*)cell;
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

    AMDStudyListViewController *listCtrl = [[AMDStudyListViewController alloc]init];
    UINavigationController *naviCtrol = [[UINavigationController alloc] initWithRootViewController:listCtrl];
    [self.parentViewController.flipboardNavigationController pushViewController:naviCtrol];
    naviCtrol.navigationBar.translucent = NO;
    [listCtrl release];
    [naviCtrol release];
}

-(void) cellButton:(id)cell
{
    NSIndexPath *path = [_tableView indexPathForCell:cell];
    AMDStudyModel *model = [_baseArray objectAtIndex:path.row];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"移除课程" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"清除课程缓存",@"下载全部课程",@"查看课程详情",  nil];
    actionSheet.tag = 2001;
    [actionSheet showInView:self.view];
    [actionSheet release];

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2001) {
        if (buttonIndex == 0) {

        }else{
            
        }
    }
}
@end
