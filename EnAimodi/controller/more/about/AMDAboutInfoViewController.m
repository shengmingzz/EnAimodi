//
//  AMDAboutInfoViewController.m
//  EnAimodi
//
//  Created by wshm on 14-2-11.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDAboutInfoViewController.h"
#import "FlipBoardNavigationController.h"
@interface AMDAboutInfoViewController ()
{
    UIWebView *webView;
    
}
@property(nonatomic,retain) UIWebView *webView;

@end

@implementation AMDAboutInfoViewController
@synthesize webView;

-(void) dealloc
{
    [webView release];
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
    self.title = @"关于";
    self.navigationItem.leftBarButtonItem = [AMDUtil defaultRetLeftBarWithTarget:self action:@selector(retback)];
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    webView = [[UIWebView alloc] init];
//    webView.frame = CGRectMake(0, 0, Main_Rect_Width, Main_Rect_Height-64);
    webView.frame = self.view.frame;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:webView];
	// Do any additional setup after loading the view.
    NSString *path =[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/about.html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) retback
{
    [self.flipboardNavigationController popViewController];
}

@end
