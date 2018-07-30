//
//  STBaseVC.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STBaseVC.h"

@interface STBaseVC ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation STBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = Background_Color;
    
    if (@available(iOS 11.0, *)) {
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //如果是栈顶控制器 就不加返回按钮
    if (self != self.navigationController.viewControllers.firstObject) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    }
    //设置侧滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 允许空白展位图的滚动 如果不想滚动 子类重写该方法即可
 */
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}


/**
 返回自定义的空白占位视图
 */
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    [scrollView addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(scrollView);
        make.center.equalTo(scrollView);
    }];
    return self.emptyView;
}


/**
 当tableView中没有数据时需展示不同类型的空白占位图
 */
- (void)tableViewConfigRequestStateForEmptyView:(UITableView *)tableView error:(NSError *)error
{
    //先设置空白展位图
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    
    //如果请求失败的情况
    if (error) {
        switch (error.code) {
            case NSURLErrorNotConnectedToInternet: //-1009
                self.emptyView.emptyType = STEmptyType_NoNetWork;
                self.emptyTypes = 1;
                break;
            case NSURLErrorTimedOut:
                self.emptyView.emptyType = STEmptyType_TimedOut;
                self.emptyTypes = 2;
                break;
            default:
                self.emptyView.emptyType = STEmptyType_ErrorDefault;
                self.emptyTypes = 3;
                break;
        }
        [tableView reloadData];
        [tableView st_endRefresh];
    }else
    {
        //请求成功但 没有内容的情况
        self.emptyView.emptyType = STEmptyType_NoData;
        self.emptyTypes = 0;
    }
    
    
}

/**
 空白占位图的点击事件
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (STEmptyView *)emptyView
{
    if (_emptyView == nil) {
        _emptyView = [[STEmptyView alloc]init];
    }
    return _emptyView;
}



@end
