//
//  AMDMoreViewController.m
//  EnAimodi
//
//  Created by wshm on 14-1-31.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDMoreViewController.h"
#import "FlipBoardNavigationController.h"
#import "AMDMoreCell.h"
@interface AMDMoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _aboutTitles;
    NSArray * _shareTitles;
    NSArray *_shareImage;
    NSArray * _contactTitles;
    UITableView *_tableView;
}
@end

@implementation AMDMoreViewController

-(void) dealloc
{
    [_aboutTitles release];
    [_shareTitles release];
    [_shareImage release];
    [_contactTitles release];
    [_tableView release];
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _aboutTitles = [[NSArray alloc] initWithObjects:@"我的单词本", nil];
    _shareTitles = [[NSArray alloc] initWithObjects:@"我的账号",@"账户充值",@"关于",@"常见问题",@"词典管理",@"设置",@"新版本内容", nil];
    _shareImage = [[NSArray alloc] initWithObjects:@"icon_setting_1@2x.png",@"icon_setting_8@2x.png",@"icon_setting_2@2x.png",@"icon_setting_3@2x.png",@"icon_setting_4@2x.png",@"icon_setting_5@2x.png",@"icon_setting_6@2x.png", nil];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Delegate and Datasource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return [_aboutTitles count];
    } else if(section==1) {
        return [_shareTitles count];
    } else if(section==2) {
        return [_contactTitles count];
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"header_cell"];
    UILabel * label = (UILabel*)[cell viewWithTag:1];
    if(section==0){
        [label setText:@"ABOUT"];
    }else if(section==1) {
        [label setText:@"SHARE"];
    }else if(section==2) {
        [label setText:@"CONTACT"];
    }
    return cell;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"menu_cell";
    AMDMoreCell *cell = (AMDMoreCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[AMDMoreCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString * title =@"";
    if(indexPath.section == 0) {
        title = [_aboutTitles objectAtIndex:indexPath.row];
    }else if(indexPath.section ==1) {
        title = [_shareTitles objectAtIndex:indexPath.row];
    }
    cell.des.text = title;
    cell.imageSide.image = [UIImage imageNamed:[_shareImage objectAtIndex:indexPath.row]];
    return  cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *page = [[UIViewController alloc]init];
    [page.view setBackgroundColor:[UIColor blueColor]];
    UINavigationController *naviCtrol = [[UINavigationController alloc] initWithRootViewController:page];
    [self.parentViewController.flipboardNavigationController pushViewController:naviCtrol];
    [page release];
    [naviCtrol release];
//    if(indexPath.section == 0) {
//        if(indexPath.row == 0) {
//            // About this App
//            [self viewOnWeb:[NSURL URLWithString:[[NSBundle mainBundle]objectForInfoDictionaryKey:@"AboutLink"]]];
//        }else if(indexPath.row == 1) {
//            // Credits
//            [self viewOnWeb:[NSURL URLWithString:[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CreditsLink"]]];
//        }
//    } else if(indexPath.section == 1) {
//        __weak NSURL * appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"AppStoreID"]]];
//        if(indexPath.row == 0) {
//            // Share via Facebook
//            [self postToFacebook:@"" url:appStoreURL image:nil completion:^(BOOL success, NSString *message) {
//                if(!success) {
//                    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Share via Facebook" andMessage:message];
//                    [alertView addButtonWithTitle:@"Close"
//                                             type:SIAlertViewButtonTypeDestructive
//                                          handler:^(SIAlertView *alert) {
//                                              NSLog(@"Button2 Clicked");
//                                          }];
//                    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
//                    [alertView show];
//                    alertView = nil;
//                    
//                }
//            }];
//        }else if(indexPath.row == 1) {
//            // Share via Twitter
//            [self postToTwitter:@"" url:appStoreURL image:nil completion:^(BOOL success, NSString *message) {
//                if(!success) {
//                    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Share via Facebook" andMessage:message];
//                    [alertView addButtonWithTitle:@"Close"
//                                             type:SIAlertViewButtonTypeDestructive
//                                          handler:^(SIAlertView *alert) {
//                                              NSLog(@"Button2 Clicked");
//                                          }];
//                    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
//                    [alertView show];
//                    alertView = nil;
//                    
//                }
//            }];
//        }else if(indexPath.row == 2) {
//            // Share via Email
//            [self composeEmail:@"Contact Us" body:[NSString stringWithFormat:@"\n\n%@",appStoreURL.absoluteString] isHTML:NO recipients:nil completion:nil];
//        }
//    }else if(indexPath.section == 2) {
//        if(indexPath.row ==0) {
//            // Contact Us
//            [self composeEmail:@"Contact Us" body:@"" isHTML:NO recipients:@[[[NSBundle mainBundle]objectForInfoDictionaryKey:@"ContactUsEmail"]]  completion:nil];
//        } else if(indexPath.row == 1)  {
//            // Rate this App
//            [self showAppInAppStoreWithId:[[NSBundle mainBundle]objectForInfoDictionaryKey:@"AppStoreID"]];
//        }
//    }
}

- (void) viewOnWeb:(NSURL*) url{
//    WebBrowserViewController * webBrowserVC = [self.storyboard instantiateViewControllerWithIdentifier:@"web_vc"];
//    webBrowserVC.url = url;
//    [self.flipboardNavigationController presentNatGeoViewController:webBrowserVC];
//    webBrowserVC = nil;
}
@end
