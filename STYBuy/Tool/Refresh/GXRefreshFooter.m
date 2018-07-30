//
//  GXRefreshFooter.m
//  MartialMaster
//
//  Created by apple on 2017/10/1.
//  Copyright © 2017年 getElementByYou. All rights reserved.
//

#import "GXRefreshFooter.h"

@implementation GXRefreshFooter

- (void)prepare
{
    [super prepare];
    self.stateLabel.font = TextSubTitleFont;
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即加载" forState:MJRefreshStatePulling];
    [self setTitle:@"正在努力加载..." forState:MJRefreshStateRefreshing];
    UIImage * img = [UIImage imageNamed:@"noDataFoot"];
    [self setImages:@[img] forState:MJRefreshStateNoMoreData];
}

@end
