//
//  SHRightWrongView.h
//  YesNo
//
//  Created by getElementByYou on 2016/12/24.
//  Copyright © 2016年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

/*************** 设置视图的类型 ***************/
typedef enum : NSUInteger {
    SHRightWrongViewTypeRight,
    SHRightWrongViewTypeWrong,
    SHRightWrongViewTypeGanTan,
} SHRightWrongViewType ;

@interface SHRightWrongView : UIView


/*************** 显示：类型、标题、完成回调。1.5s延迟 ***************/
+ (void)showType:(SHRightWrongViewType)type andTitle:(NSString *)title Fanish:(void(^)(void))fanish;


/*************** 显示：设置标题、延迟时间、完成 ***************/
+ (void)showType:(SHRightWrongViewType)type andTitle:(NSString *)title delay:(CGFloat)delay Fanish:(void(^)(void))fanish;


@end
