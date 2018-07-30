//
//  FBAlertView.m
//  FootballNews
//
//  Created by getElementByYou on 2018/5/4.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "FBAlertView.h"

@interface FBAlertView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *createBtn;

@property (nonatomic, strong) UIButton *cancleBtn;



@end


@implementation FBAlertView

- (instancetype)initWithTitle:(NSString *)title
            createButtonTitle:(NSString *)createButtonTitle cancleBtnTitle:(NSString *)cancleButtonTitle
                        frame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createView:title createButtonTitle:createButtonTitle cancleBtnTitle:cancleButtonTitle];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
    }
    
    return self;
}

- (void)createView:(NSString *)title createButtonTitle:(NSString *)createButtonTitle cancleBtnTitle:(NSString *)cancleButtonTitle
{
    
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.textColor = Text_Black_Color;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = TextTitleFont;
        label;
    });
    
    
    self.createBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:createButtonTitle forState:UIControlStateNormal];
        button.backgroundColor  = self.backgroundColor;
        button.titleLabel.font = TextTitleFont;
        [button setTitleColor:Main_Color forState:UIControlStateNormal];
        button;
    });
    
    self.cancleBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:cancleButtonTitle forState:UIControlStateNormal];
        button.backgroundColor  = self.backgroundColor;
        button.titleLabel.font = TextTitleFont;
        [button setTitleColor:Text_Black_Color forState:UIControlStateNormal];
        button;
    });
    
    [self addSubview:_titleLabel];
    [self addSubview:_createBtn];
    [self addSubview:_cancleBtn];
    
    
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.height.mas_equalTo(44 * AUTO_WIDTH);
        make.width.mas_equalTo(self.mj_w/2);
    }];
    
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.height.width.equalTo(self.cancleBtn);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self.cancleBtn.mas_top);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    
    UIView * h_line = [[UIView alloc]init];
    h_line.backgroundColor = Text_DHS_Color;
    [self addSubview:h_line];
    [h_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cancleBtn.mas_top);
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(self);
    }];
    
    UIView * s_line = [[UIView alloc]init];
    s_line.backgroundColor = Text_DHS_Color;
    [self addSubview:s_line];
    [s_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(self.cancleBtn);
        make.centerY.equalTo(self.cancleBtn);
        make.width.mas_equalTo(0.5);
    }];
    
    
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft  cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.cancleBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.cancleBtn.layer.mask = maskLayer;
    
    
    UIBezierPath *maskPathAgreeBtn = [UIBezierPath bezierPathWithRoundedRect:self.createBtn.bounds byRoundingCorners:UIRectCornerBottomRight  cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayerAgree = [[CAShapeLayer alloc] init];
    maskLayerAgree.frame = self.createBtn.bounds;
    maskLayerAgree.path = maskPathAgreeBtn.CGPath;
    self.createBtn.layer.mask = maskLayerAgree;
    
}



- (void)cancel {
    
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (void)createAction {
    
    if (_creatBlock) {
        _creatBlock();
    }
}




@end
