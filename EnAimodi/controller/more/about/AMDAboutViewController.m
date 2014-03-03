//
//  AMDAboutViewController.m
//  EnAimodi
//
//  Created by wshm on 14-2-11.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDAboutViewController.h"
#import "FlipBoardNavigationController.h"
#import "AMDAboutInfoViewController.h"
@interface AMDAboutViewController ()<MFMailComposeViewControllerDelegate>
{
    NSArray *arrayAbout;
}
@property(nonatomic,assign) EmailCompletionBlock emailCompletionBlock;
@end

@implementation AMDAboutViewController
@synthesize emailCompletionBlock = _emailCompletionBlock;
-(void) dealloc
{
    _emailCompletionBlock = nil;
    [arrayAbout release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"关于我们";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [AMDUtil defaultRetLeftBarWithTarget:self action:@selector(retback)];
    arrayAbout = [[NSArray alloc] initWithObjects:@"关于大嘴说英语",@"给我评分",@"意见反馈",@"真爱大调查",nil];
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrayAbout count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [arrayAbout objectAtIndex:indexPath.row];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AMDAboutInfoViewController *info = [[AMDAboutInfoViewController alloc] init];
        UINavigationController *naviCtrol = [[UINavigationController alloc] initWithRootViewController:info];
        [self.flipboardNavigationController pushViewController:naviCtrol];
        [info release];
        [naviCtrol release];
    }else if (indexPath.row == 1){
        [self showAppInAppStoreWithId:[[NSBundle mainBundle]objectForInfoDictionaryKey:@"AppStoreID"]];
    }else if(indexPath.row == 2){
        [self composeEmail:@"给大嘴说英语的建议" body:@"" isHTML:NO recipients:[NSArray arrayWithObject:IdeaMostEmail] completion:nil];
    }else if (indexPath.row == 3){
//        Icon_Love_1@2x.png
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (void) composeEmail:(NSString*)subject body:(NSString*)body isHTML:(BOOL)isHTML recipients:(NSArray*)recipients completion:(EmailCompletionBlock)completion{
    _emailCompletionBlock = completion;
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController * email = [[MFMailComposeViewController alloc]init];
        email.mailComposeDelegate = self;
        [email setToRecipients:recipients];
        [email setSubject:subject];
        [email setMessageBody:body isHTML:isHTML];
        if(self.flipboardNavigationController) {
            [self.flipboardNavigationController presentViewController:email animated:YES completion:nil];
        }else {
            [self presentViewController:email animated:YES completion:nil];
        }
        email = nil;
    }else {
        if(_emailCompletionBlock) _emailCompletionBlock(NO,0,nil);
    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:^() {
        if(_emailCompletionBlock)_emailCompletionBlock(YES,result,error);
    }];
}
- (void) showAppInAppStoreWithId:(NSString*)appId{
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
@end
