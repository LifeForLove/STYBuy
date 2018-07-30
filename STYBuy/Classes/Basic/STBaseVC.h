//
//  STBaseVC.h
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STEmptyView.h"
@interface STBaseVC : UIViewController

@property (nonatomic,assign) NSInteger emptyTypes;


/**
 返回按钮的点击事件
 */
- (void)backAction;


/**
 当页面无数据时 展示此视图
 */
@property (nonatomic,strong) STEmptyView *emptyView;

/**
 当tableView 请求失败时  需要展示空白视图 调用此方法

 @param tableView tableView
 @param error 错误类型 当没有时传nil
 */
- (void)tableViewConfigRequestStateForEmptyView:(UITableView *)tableView error:(NSError *)error;


/**
 当需要获取空白视图的点击事件时  子类重写此方法
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view;

@end
