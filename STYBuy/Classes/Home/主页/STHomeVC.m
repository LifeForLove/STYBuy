//
//  STHomeVC.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STHomeVC.h"
#import "STHomeTableViewCell.h"
#import "STHomeListModel.h"
#import "STHomeDetailVC.h"


static NSString * const HomeCellOne  = @"HomeCellOne";

@interface STHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *infoArr;

@property (nonatomic,strong) UIView *headView;

@end

@implementation STHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SafeAreaNavHeight);
        make.left.right.mas_equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SafeAreaTabbarHeight);
    }];

    @weakify(self);
    self.tableView.mj_header = [GXRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadDataWithType:1];
    }];

    self.tableView.mj_footer = [GXRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadDataWithType:2];
    }];

    [self loadDataWithType:1];

    /*
     当没网时情况下 并且当前页面为空 如果联网成功则自动加载数据 下面是判断条件:
     1 networkStatus == AFNetworkReachabilityStatusNotReachable
     2 loadDataWithType 加载过后
     3 infoArr 中无数据
     */
    [[RACSignal combineLatest:@[RACObserve(STSharedAppDelegate, networkStatus),RACObserve(self, emptyTypes),RACObserve(self, infoArr)]reduce:^id(NSNumber * networkStatus,NSNumber * emptyType,NSMutableArray * infoArr){
        NSLog(@"=====================%@================",emptyType);
        return ([networkStatus integerValue] != AFNetworkReachabilityStatusNotReachable && infoArr.count == 0 && [emptyType integerValue] == 1) ? @1 : @0;
    }]subscribeNext:^(NSNumber * x) {
        if ([x integerValue] == 0) return;
            @strongify(self);
            [self.tableView.mj_header beginRefreshing];
    }];
}

- (void)loadDataWithType:(NSInteger)type
{
    @weakify(self);
    [STHomeListModel requestWithRequestMessage:^(NSObject *message,NSMutableDictionary * dic) {
        dic[@"p"] = type == 1 ? @1 : @((1 + self.infoArr.count/8) + (self.infoArr.count%8 == 0 ?0:1));
        dic[@"uid"] = @"co8vpOyzK9Zw";
        dic[@"mcode"] = @"qFytx@lc8W";
        dic[@"pid"] = @2;
        dic[@"t"] = @1;
        message.st_requestURL = HomeListURL;
        message.st_method = STRequestMethodGET;
        message.st_needHUD = YES;
    } success:^(NSArray * list) {
        @strongify(self);
        //设置空白视图
        [self tableViewConfigRequestStateForEmptyView:self.tableView error:nil];
        if (type == 1) {
            self.infoArr = list.mutableCopy;
            self.tableView.mj_footer.state = MJRefreshStateIdle;
        }else if (type == 2)
        {
            [self.infoArr addObjectsFromArray:list];
            if (list.count == 0) {
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }
        [self.tableView reloadData];
        //结束刷新
        [self.tableView st_endRefresh];
    } failure:^(NSError *error) {
        @strongify(self);
        //设置空白视图
        [self tableViewConfigRequestStateForEmptyView:self.tableView error:error];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:HomeCellOne];
    cell.model = self.infoArr[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:HomeCellOne configuration:^(STHomeTableViewCell * cell) {
        cell.model = self.infoArr[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STHomeDetailVC * vc = [[STHomeDetailVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView createTableView:UITableViewStyleGrouped];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.tableView registerClass:[STHomeTableViewCell class] forCellReuseIdentifier:HomeCellOne];
    }
    return _tableView;
}

- (NSMutableArray *)infoArr
{
    if (_infoArr == nil) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        _headView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    }
    return _headView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
