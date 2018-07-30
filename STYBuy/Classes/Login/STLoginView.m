//
//  STLoginView.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STLoginView.h"
#import "STBaseVC.h"


@interface STLoginVC :STBaseVC

/**
 背景scrollView
 */
@property (nonatomic,strong) UIScrollView *scrollView;

/**
 账号
 */
@property (nonatomic,strong) UITextField *nameT;

/**
 密码
 */
@property (nonatomic,strong) UITextField *pwdT;

/**
 登录按钮
 */
@property (nonatomic,strong) UIButton *loginBtn;

/**
 登录信号
 */
@property (nonatomic,strong) RACSubject *loginSingle;

@end

@interface STLoginView ()
@end

@implementation STLoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    STLoginVC * vc = [[STLoginVC alloc]init];
    @weakify(self);
    [[vc.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton * x){
        @strongify(self);
        NSLog(@"开始登录");
        [NSThread sleepForTimeInterval:0.2];
        
        [STUserManager change:^(STUser *user) {
            user.userId = @"361003";
            user.userState = 1;
        }];
        
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.result) {
                self.result(200);
            }
        }];
    }];
    [self pushViewController:vc animated:NO];
}

+ (void)show:(resultBlock)result
{
    STLoginView * nav = [[STLoginView alloc]init];
    if (result) {
        nav.result = result;
    }
    [[UIViewController currentTopVC] presentViewController:nav animated:YES completion:nil];
}

@end

@implementation STLoginVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UINavigationBar appearance] setTintColor:White_Color];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:Main_Color] forBarMetrics:UIBarMetricsDefault];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView];

    @weakify(self);
    [[RACSignal combineLatest:@[[self.nameT rac_textSignal],[self.pwdT rac_textSignal]] reduce:^id(NSString * name , NSString * pwd){
        return @(name.length >= 2 && pwd.length >= 6);
    }]subscribeNext:^(NSNumber * x) {
        @strongify(self);
        self.loginBtn.enabled = [x boolValue];
    }];
    
}


- (void)createView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.nameT];
    [self.scrollView addSubview:self.pwdT];
    [self.scrollView addSubview:self.loginBtn];
    
    //重新设置导航栏的样式
    //nav 文字颜色
    [[UINavigationBar appearance] setTintColor:Main_Color];
    //导航栏的颜色
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:self.view.backgroundColor] forBarMetrics:UIBarMetricsDefault];
    
    UIButton * leftBtn = [UIButton buttonWithTextColor:Main_Color font:TextTitleFont];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    @weakify(self);
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton * x) {
        @strongify(self);
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    leftBtn.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    
    [self.nameT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SafeAreaNavHeight + 60);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(50);
    }];
    
    [self.pwdT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameT.mas_bottom).offset(40);
        make.left.right.equalTo(self.nameT);
        make.height.equalTo(self.nameT);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameT);
        make.top.equalTo(self.pwdT.mas_bottom).offset(90);
        make.height.equalTo(self.nameT);;
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.loginBtn.mas_bottom).offset(150);
    }];
}


- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (UITextField *)nameT
{
    if (_nameT == nil) {
        _nameT = [[UITextField alloc]init];
        _nameT.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        _nameT.keyboardType = UIKeyboardTypeNumberPad;
        _nameT.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameT.maxCount = 15;
    }
    return _nameT;
}

- (UITextField *)pwdT
{
    if (_pwdT == nil) {
        _pwdT = [[UITextField alloc]init];
        _pwdT.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        _pwdT.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdT.secureTextEntry = YES;
        _pwdT.maxCount = 15;
    }
    return _pwdT;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithTextColor:White_Color font:TextTitleFont backgroundNormalColor:Main_Color backgroundDisableColor:Text_DHS_Color];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.enabled = NO;
    }
    return _loginBtn;
}


@end


