//
//  FBAlertView.h
//  FootballNews
//
//  Created by getElementByYou on 2018/5/4.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBAlertView : UIView
@property (nonatomic, copy) void(^cancelBlock)(void);

@property (nonatomic, copy) void(^creatBlock)(void);

- (instancetype)initWithTitle:(NSString *)title
            createButtonTitle:(NSString *)createButtonTitle cancleBtnTitle:(NSString *)cancleButtonTitle
                        frame:(CGRect)frame;
@end
