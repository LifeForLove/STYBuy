//
//  UITableView+Extension.m
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

+ (instancetype)createTableView:(UITableViewStyle)style
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:style];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
    } else {
    }
    return tableView;
}

- (void)st_endRefresh
{
    if ([self.mj_header isRefreshing])[self.mj_header endRefreshing];
    if ([self.mj_footer isRefreshing])[self.mj_footer endRefreshing];
}


@end
