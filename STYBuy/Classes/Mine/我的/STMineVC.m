//
//  STMineVC.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STMineVC.h"
#import "UserCenterCell.h"
#import "STMineHeadCell.h"
#import "STMIneModel.h"
#import "STUserInfoVC.h"
static NSString * const STMineHeadCellIdentifier  = @"STMineHeadCellIdentifier";
static NSString * const STMineCenterCellIdentifier  = @"STMineCenterCellIdentifier";
@interface STMineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *infoArr;
@property (nonatomic,strong) STMIneModel *model;

@end

@implementation STMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"myplist" ofType:@"plist"]];
    [self createView];
    [self loadData];
    [self observerNoti];
}

- (void)loadData
{
    //游客不加载数据
    if (STCurrentUser.userState == 0) return;
    
    self.model = [[STMIneModel alloc]init];
    self.model.headpic = @"http://thirdwx.qlogo.cn/mmopen/vi_32/enQbP1IewUNibuL8auU8tQcvWIvS3RwV1pREic4J6l09owlfv4xzcb8mOu2ibJh8bvEggYfNYyLghXmxqvpJ7nrPA/132";
    [self.tableView reloadData];
    [self.tableView st_endRefresh];
}

/**
 监听通知
 */
- (void)observerNoti
{
    //监听刷新一级界面的通知
    @weakify(self);
    [[STNotificationCenter rac_addObserverForName:STRefreshHomeDataNotification object:nil]subscribeNext:^(NSNotification * noti) {
        @strongify(self);
        self.model = nil;
        [self.tableView reloadData];
        [self loadData];
    }];
}


- (void)createView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SafeAreaNavHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    @weakify(self);
    self.tableView.mj_header = [GXRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : self.infoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 120 : 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 10 : 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        STMineHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:STMineHeadCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        @weakify(self);
        [[[cell.iconTap rac_gestureSignal] takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(UIGestureRecognizer * ges) {
            @strongify(self);
            [self iconClickAction];
        }];
        return cell;
    }
    UserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:STMineCenterCellIdentifier];
    cell.nameLabel.text = self.infoArr[indexPath.row][@"title"];
    cell.leftImage.image = [UIImage imageNamed:self.infoArr[indexPath.row][@"img"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1)
    {
        NSInteger ID = [self.infoArr[indexPath.row][@"id"] integerValue];
        switch (ID) {
            case 1001:
            {
                //我的收藏
                NSLog(@"我的收藏");
            }
                break;
            case 1002:
            {
                NSLog(@"收货地址");
            }
                break;
            case 1003:
            {
                NSLog(@"实名认证");
            }
                break;
            case 1004:
            {
                //加盟合作
                NSLog(@"加盟合作");
            }
                break;
            case 1005:
            {
                //联系客服
                NSLog(@"联系客服");
            }
                break;
            case 1006:
            {
                NSLog(@"平台规则");
                break;
            }
            case 1007:
            {
                //关于天易购
                NSLog(@"关于天易购");
            }
                break;
                
            default:
                break;
        }
        
    }
}



/**
 头像点击事件
 */
- (void)iconClickAction
{
    if (STCurrentUser.userState == 0) {
        @weakify(self);
        [STLoginView show:^(NSInteger code) {
            if (code == 200) {
                @strongify(self);
                [FBIWarningView showMessage:@"登录成功"];
                [self loadData];
            }
        }];
    }else
    {
        NSLog(@"头像点击");
        STUserInfoVC * vc = [[STUserInfoVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView createTableView:UITableViewStyleGrouped];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.tableView registerClass:[STMineHeadCell class] forCellReuseIdentifier:STMineHeadCellIdentifier];
        [self.tableView registerClass:[UserCenterCell class] forCellReuseIdentifier:STMineCenterCellIdentifier];
    }
    return _tableView;
}


@end
