//
//  UITableView+Extension.h
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)
/**
 创建tableView
 */
+ (instancetype)createTableView:(UITableViewStyle)style;

/**
 结束刷新
 */
- (void)st_endRefresh;
@end
