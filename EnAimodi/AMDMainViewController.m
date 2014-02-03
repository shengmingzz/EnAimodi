//
//  AMDMainViewController.m
//  EnAimodi
//
//  Created by wshm on 14-1-31.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDMainViewController.h"
#import "FlipBoardNavigationController.h"
static const float TAB_BAR_HEIGHT = 32;
static const float TAB_BUTTON_WIDTH = 25;
static const NSInteger TAG_OFFSET = 1000;
static const NSInteger TAG_TOP_VIEW = 2000;

@interface AMDMainViewController ()
{
    UIScrollView *nibScrollView;
    //左右滑动部分
	UIPageControl *pageControl;
    int currentPage;
    BOOL pageControlUsed;
    
    UILabel *labelTitle;
    
    NSArray *arrayTite;
}
@end

@implementation AMDMainViewController
@synthesize viewControllerArray;
@synthesize viewControllerIcon;
@synthesize viewControllerIconHit;
-(void) dealloc
{
    for (UIViewController *viewctrl in viewControllerArray) {
        [viewctrl release]; viewctrl = nil;
    }
    [viewControllerIcon release];
    [viewControllerIconHit release];
    [nibScrollView release];
    [arrayTite release];
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
    arrayTite = [[NSArray alloc] initWithObjects:@"hi",@"课程库",@"排行榜",@"更多...", nil];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initMenu];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidUnload
{
    for (UIViewController *viewctrl in viewControllerArray) {
        [viewctrl willMoveToParentViewController:nil];
        [viewctrl removeFromParentViewController];
    }
    for (UIView *view in nibScrollView.subviews) {
        [view removeFromSuperview];
    }
}
- (void) layoutSubviews
{
    nibScrollView.contentSize = CGSizeMake(nibScrollView.frame.size.width * 3, nibScrollView.frame.size.height);
    int i=0;
    for (UIView *view in nibScrollView.subviews) {
        [view setFrame:CGRectMake(i*nibScrollView.frame.size.width, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height)];
        [view sizeToFit];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) retBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) initLabelTitle:(UIView*)view
{
    labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 150, TAB_BAR_HEIGHT)];
    [labelTitle setTextAlignment:NSTextAlignmentLeft];
    [labelTitle setTextColor:[UIColor blueColor]];
    [labelTitle setFont:[UIFont systemFontOfSize:18.0]];
    labelTitle.text = [arrayTite objectAtIndex:0];
    [view addSubview:labelTitle];
}
-(void) initMenu
{
    float height = 0.0;
    if (iOS_7) {
        height = 20.0;
    }
    UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, height, self.view.frame.size.width, TAB_BAR_HEIGHT)];
    [viewtop setBackgroundColor:[UIColor whiteColor]];
    [viewtop setTag:TAG_TOP_VIEW];
    [self addTabButtons:viewtop];
    [self initLabelTitle:viewtop];
    [self.view addSubview:viewtop];
    
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0.0, TAB_BAR_HEIGHT-0.5, self.view.frame.size.width, 0.5)];
    [viewline setBackgroundColor:[UIColor lightGrayColor]];
    [viewtop addSubview:viewline];
    [viewline release];
    [viewtop release];
    
    height = height + TAB_BAR_HEIGHT;
    
    nibScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, height, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-height)];
    [nibScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:nibScrollView];
    [self initScrollView];
    
}
- (void)addTabButtons:(UIView*)view
{
    int total = [self.viewControllerArray count];
//    float perWidth = self.view.frame.size.width /total;
    float begin = 310-30*total;
    if (begin < 160) {
        begin = 160;
    }
    for (int i=0; i< [self.viewControllerArray count]; i++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(begin + i*(TAB_BUTTON_WIDTH+5), 0, TAB_BUTTON_WIDTH, TAB_BUTTON_WIDTH)];
		button.tag = TAG_OFFSET + i;
		[button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
		button.titleLabel.shadowOffset = CGSizeMake(0, 1);
        [button setBackgroundColor:[UIColor clearColor]];
        NSString *normalIcon = [self.viewControllerIcon objectAtIndex:i];
        NSString *hitIcon = [self.viewControllerIconHit objectAtIndex:i];
        [button setImage:[UIImage imageNamed:normalIcon] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:hitIcon] forState:UIControlStateSelected];
		[view addSubview:button];
        if (i == 0) {
            [button setSelected:YES];
        }
    }
}
- (void)initScrollView {
    
    //设置 tableScrollView
    // a page is the width of the scroll view
    nibScrollView.pagingEnabled = YES;
    nibScrollView.clipsToBounds = NO;
    if ([self.viewControllerArray count] <= 0) {
        nibScrollView.contentSize = CGSizeMake(nibScrollView.frame.size.width , nibScrollView.frame.size.height);
    }else{
        nibScrollView.contentSize = CGSizeMake(nibScrollView.frame.size.width * [self.viewControllerArray count] , nibScrollView.frame.size.height);
    }
    nibScrollView.showsHorizontalScrollIndicator = NO;
    nibScrollView.showsVerticalScrollIndicator = NO;
    nibScrollView.scrollsToTop = NO;
    nibScrollView.delegate = self;
    nibScrollView.bounces = NO;
    //    [nibScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    [nibScrollView setContentOffset:CGPointMake(0, 0)];
    [nibScrollView setBackgroundColor:[UIColor whiteColor]];
    
    //公用
    currentPage = 0;
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    [self createAllEmptyPagesForScrollView];
}
-(void) createAllEmptyPagesForScrollView
{
    int index = 0;
    for (UIViewController *viewctrl in self.viewControllerArray) {
        CGRect rect = CGRectMake(0, 0, nibScrollView.frame.size.width, nibScrollView.frame.size.height);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(320*index, 0, 320, nibScrollView.frame.size.height)];
        [viewctrl.view setFrame:rect];
        [view addSubview:viewctrl.view];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [viewctrl.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [nibScrollView addSubview:view];
        [view release];
        ++index;
    }
}
-(void) setViewControllerArray:(NSMutableArray *)_viewControllerArray
{
    
    for (UIViewController *viewctrl in viewControllerArray) {
        [viewctrl willMoveToParentViewController:nil];
        [viewctrl removeFromParentViewController];
    }
    [_viewControllerArray retain];
    [viewControllerArray release];
    viewControllerArray = _viewControllerArray;
    for (UIViewController *viewctrl in viewControllerArray) {
        [self addChildViewController:viewctrl];
        [viewctrl didMoveToParentViewController:self];
        if ([viewctrl respondsToSelector:@selector(didMoveToParentViewController:)])
        {
            [viewctrl didMoveToParentViewController:self];
        }
    }
}
- (void) btnActionShow
{
    int tag = TAG_OFFSET + currentPage;
    [self topButtonAction:tag];
}
-(void) topButtonAction:(int)tag
{
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    UIView *topview = [self.view viewWithTag:TAG_TOP_VIEW];
    NSString *titleStr = [arrayTite objectAtIndex:(tag - TAG_OFFSET)];
    labelTitle.text = titleStr;
    for (int i= 0; i< [self.viewControllerIcon count]; i++) {
        if (tag == i+TAG_OFFSET) {
            UIButton *btn = (UIButton*)[topview viewWithTag:(i+TAG_OFFSET)];
            [btn setSelected:YES];
        }else{
            UIButton *btn = (UIButton*)[topview viewWithTag:(i+TAG_OFFSET)];
            [btn setSelected:NO];
        }
    }
    [nibScrollView setContentOffset:CGPointMake(320*(tag - TAG_OFFSET), 0)];//页面滑动
    [UIView commitAnimations];
}
-(void)tabButtonPressed:(UIButton*)btn
{
    int tag = btn.tag;
    [self topButtonAction:tag];
    return;
}
#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(scrollView == nibScrollView){
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 3) / pageWidth) + 1;
        
        pageControl.currentPage = page;
        currentPage = page;
        pageControlUsed = NO;
        [self btnActionShow];
    }
}

@end
