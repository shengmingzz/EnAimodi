//
//  AMDSortToolbar.m
//  EnAimodi
//
//  Created by wshm on 14-2-1.
//  Copyright (c) 2014年 fuzhou Aimodi Technology Co. Ltd. All rights reserved.
//

#import "AMDSortToolbar.h"
#define sort_toolbar_base_tag 3000
@implementation AMDSortToolbar
@synthesize selected = _selected;
@synthesize delegate;

-(void) dealloc{
    delegate = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        // Initialization code
        NSArray *img_strs = [ NSArray arrayWithObjects:@"Icon_Top1@2x.png",@"Icon_Top2@2x.png",@"Icon_Top3@2x.png",@"Icon_Top4@2x.png",@"Icon_Top5@2x.png",nil];
        NSArray *img_strs_sel = [NSArray arrayWithObjects:@"Icon_Top1_Hit@2x.png",@"Icon_Top2_Hit@2x.png",@"Icon_Top3_Hit@2x.png",@"Icon_Top4_Hit@2x.png",@"Icon_Top5_Hit@2x.png", nil];
        _selected = 0;
        for (int i=0; i<5; i++) {
            UIButton *btn = [[UIButton alloc] init ];
            float width = frame.size.width - 44*4;
            
            [btn setTag:(sort_toolbar_base_tag+i)];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:[img_strs objectAtIndex:i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[img_strs_sel objectAtIndex:i]] forState:UIControlStateSelected];
            if (i==0) {
                [btn setFrame:CGRectMake(0, 0, width, 44)];
                [btn setSelected:YES];
            }else{
                [btn setFrame:CGRectMake(width + (i-1)*44, 0, 44, 44)];
                [btn setSelected:NO];
            }
            [self addSubview:btn];
            [btn release];
        }
    }
    return self;
}
-(void) btnAction:(UIButton*)sender
{
    int tag = sender.tag;
    int baseTag = tag - sort_toolbar_base_tag;
    self.selected = baseTag;
    [self resizeBtnFrame];
    if (delegate) {
        [delegate sortToolbarSelected:self.selected];
    }
}
-(void) btnSelected:(int)selNum
{
    self.selected = selNum;
    [self resizeBtnFrame];
}
-(void) resizeBtnFrame
{
    for (int i=0; i<5; i++) {
        UIButton *btn = (UIButton*)[self viewWithTag:(sort_toolbar_base_tag + i)];
        float width = self.frame.size.width - 44*4;
        
        if (i==self.selected) {
            [btn setFrame:CGRectMake(i*44, 0, width, 44)];
            btn.selected = YES;
        }else if(i<self.selected){
            [btn setFrame:CGRectMake(i*44, 0, 44, 44)];
            btn.selected = NO;
        }else{
            [btn setFrame:CGRectMake(width + (i-1)*44, 0, 44, 44)];
            btn.selected = NO;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
