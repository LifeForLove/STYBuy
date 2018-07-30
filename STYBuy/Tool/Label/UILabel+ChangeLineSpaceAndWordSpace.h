//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  Gafaer
//
//  Created by apple on 2017/8/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;


/**
 改变行间距和字间距
 先赋值 后改间距
 @param label 传入该Label
 @param lineSpace 行间距
 @param wordSpace 字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
