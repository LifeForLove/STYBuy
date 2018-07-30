//
//  STShopVC.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STShopVC.h"
#import "STShopModel.h"
#import "STShopRecomModel.h"

#import "STRecomCell.h"
#import "STTJZQCell.h"
#import "STCZJPCell.h"
#import "STClassfiyCell.h"
#import "STShopHeadCell.h"
#import "STSinglAdCell.h"

static NSString * const ShopHeadCellIdentifier  = @"ShopHeadCellIdentifier";
static NSString * const ShopClassifyCellIdentifier  = @"ShopClassifyCellIdentifier";
static NSString * const ShopSingleAdCellIdentifier  = @"ShopSingleAdCellIdentifier";
static NSString * const ShopAdlistCellIdentifier  = @"ShopAdlistCellIdentifier";
static NSString * const ShopTJZQCellIdentifier  = @"ShopTJZQCellIdentifier";
static NSString * const ShopRecomCellIdentifier  = @"ShopRecomCellIdentifier";


@interface STShopVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) STShopModel *model;

@end

@implementation STShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SafeAreaNavHeight);
        make.left.right.mas_equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SafeAreaTabbarHeight);
    }];
    
    @weakify(self);
    self.tableView.mj_header = [GXRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    [self loadData];
    
}
- (void)loadData
{
    @weakify(self);
    [STShopModel requestWithRequestMessage:^(NSObject *message, NSMutableDictionary *dict) {
    } success:^(STShopModel * model) {
        @strongify(self);
        NSLog(@"%@",model);
        self.model = model;
        [self.tableView st_endRefresh];
    } failure:^(NSError *error) {
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identi = self.model.identiList[indexPath.section];
    if ([identi isEqualToString:ShopHeadCellIdentifier]) {
        //首页轮播
        STShopHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopHeadCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        cell.infoArr = self.model.bannerList;
        return cell;
    }else if ([identi isEqualToString:ShopClassifyCellIdentifier])
    {
        //商品分类
        STClassfiyCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopClassifyCellIdentifier];
        cell.infoArr = self.model.targetList;
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        return cell;
    }else if ([identi isEqualToString:ShopSingleAdCellIdentifier])
    {
        //单品广告
        STSinglAdCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopSingleAdCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        cell.model = self.model.singleAd;
        return cell;
    }else if ([identi isEqualToString:ShopAdlistCellIdentifier])
    {
        //推荐精品
        STCZJPCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopAdlistCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        cell.infoArr = self.model.adList;
        return cell;
    }else if ([identi isEqualToString:ShopTJZQCellIdentifier])
    {
        //特价专区
        STTJZQCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopTJZQCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        cell.model = self.model.subjectList[indexPath.row];
        return cell;
    }else if ([identi isEqualToString:ShopRecomCellIdentifier])
    {
        STRecomCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopRecomCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        cell.model = self.model.recommend.productList[indexPath.row];
        return cell;
    }
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.identiList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * identi = self.model.identiList[section];
    if ([identi isEqualToString:ShopHeadCellIdentifier]) {
        //首页轮播
        return 1;
    }else if ([identi isEqualToString:ShopClassifyCellIdentifier])
    {
        //商品分类
        return 1;
    }else if ([identi isEqualToString:ShopSingleAdCellIdentifier])
    {
        //单品广告
        return 1;
    }else if ([identi isEqualToString:ShopAdlistCellIdentifier])
    {
        //推荐精品
        return 1;
    }else if ([identi isEqualToString:ShopTJZQCellIdentifier])
    {
        //特价专区
        return self.model.subjectList.count;
    }else if ([identi isEqualToString:ShopRecomCellIdentifier])
    {
        //为你推荐
        return self.model.recommend.productList.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identi = self.model.identiList[indexPath.section];
    if ([identi isEqualToString:ShopHeadCellIdentifier]) {
        //首页轮播
        return 200;
    }else if ([identi isEqualToString:ShopClassifyCellIdentifier])
    {
        //商品分类
        return 176;
    }else if ([identi isEqualToString:ShopSingleAdCellIdentifier])
    {
        //单品广告
        return 80;
    }else if ([identi isEqualToString:ShopAdlistCellIdentifier])
    {
        //推荐精品
        return 220;
    }else if ([identi isEqualToString:ShopTJZQCellIdentifier])
    {
        //特价专区
        return 200 + 140;
    }else if ([identi isEqualToString:ShopRecomCellIdentifier])
    {
        //为你推荐
        return 140;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString * identi = self.model.identiList[section];
    return [identi isEqualToString:ShopAdlistCellIdentifier] ? 0.01 : 10;
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
        [_tableView registerClass:[STShopHeadCell class] forCellReuseIdentifier:ShopHeadCellIdentifier];
        [_tableView registerClass:[STClassfiyCell class] forCellReuseIdentifier:ShopClassifyCellIdentifier];
        [_tableView registerClass:[STSinglAdCell class] forCellReuseIdentifier:ShopSingleAdCellIdentifier];
        [_tableView registerClass:[STCZJPCell class] forCellReuseIdentifier:ShopAdlistCellIdentifier];
        [_tableView registerClass:[STTJZQCell class] forCellReuseIdentifier:ShopTJZQCellIdentifier];
        [_tableView registerClass:[STRecomCell class] forCellReuseIdentifier:ShopRecomCellIdentifier];
    }
    return _tableView;
}




@end
