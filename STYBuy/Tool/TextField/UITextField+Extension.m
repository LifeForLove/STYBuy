//
//  UITextField+Extension.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "UITextField+Extension.h"

static char const * const maxCountKey = "maxCountKey";

static char const * const moneyCountKey = "moneyCountKey";

static char const * const maxMoneyKey = "maxMoneyKey";

@interface UITextField ()<UITextFieldDelegate>

@end


@implementation UITextField (Extension)

- (void)setMaxCount:(NSInteger)maxCount
{
    NSNumber * number = [NSNumber numberWithInteger:maxCount];
    objc_setAssociatedObject(self,maxCountKey, number, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setMoneyCount:(NSInteger)moneyCount
{
    NSNumber * number = [NSNumber numberWithInteger:moneyCount];
    objc_setAssociatedObject(self, moneyCountKey, number, OBJC_ASSOCIATION_RETAIN);
    self.delegate = self;
}

- (void)setMaxMoney:(NSInteger)maxMoney
{
    NSNumber * number = [NSNumber numberWithInteger:maxMoney];
    objc_setAssociatedObject(self, maxMoneyKey, number, OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)maxMoney
{
    NSNumber *number = objc_getAssociatedObject(self, maxMoneyKey);
    return [number integerValue];
}

- (NSInteger)moneyCount
{
    NSNumber *number = objc_getAssociatedObject(self, moneyCountKey);
    return [number integerValue];
}

- (NSInteger)maxCount
{
    NSNumber *number = objc_getAssociatedObject(self, maxCountKey);
    return [number integerValue];
}

#pragma mark - UITextField Delegate
-(void)textFieldEditChanged:(UITextField *)textField
{
    NSInteger length = self.maxCount;
    NSString *toBeString = textField.text;
    //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    UITextInputMode *currmode = textField.textInputMode;
    NSString *lang = [currmode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"] ||[lang isEqualToString:@"zh-Hant"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //            textField.text = [self filterCharactor:textField.text withRegex:@"[^\u4e00-\u9fa5]"];//筛选出汉字
            if (toBeString.length > length) {
                textField.text = [toBeString substringToIndex:length];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > length) {
            textField.text = [toBeString substringToIndex:length];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    /*
     
     1.start with zero 0000.....was forbiden
     
     2.have no '.' & the first character is not '0'
     
     3.limit the count of '.'
     
     4.if the first character is '0',then the next one must be '.'
     
     5.condition like "0.0.0"was forbiden
     
     6.limit the num of zero after '.'
     
     */
    
    if(((string.intValue<0) || (string.intValue>9))){
        
        //MyLog(@"====%@",string);
        
        if ((![string isEqualToString:@"."])) {
            
            return NO;
            
        }
        
        return NO;
        
    }
    
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    
    [futureString  insertString:string atIndex:range.location];
    
    
    
    NSInteger dotNum = 0;
    
    NSInteger flag=0;
    
    const NSInteger limited = 2;
    
    if((int)futureString.length>=1){
        
        
        
        if([futureString characterAtIndex:0] == '.'){//the first character can't be '.'
            
            return NO;
            
        }
        
        if((int)futureString.length>=2){//if the first character is '0',the next one must be '.'
            
            if(([futureString characterAtIndex:1] != '.'&&[futureString characterAtIndex:0] == '0')){
                
                return NO;
                
            }
            
        }
        
    }
    
    NSInteger dotAfter = 0;
    
    for (int i = (int)futureString.length-1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            dotNum ++;
            
            dotAfter = flag+1;
            
            if (flag > limited) {
                
                return NO;
                
            }
            
            if(dotNum>1){
                
                return NO;
                
            }
            
        }
        
        flag++;
        
    }
    
    if(futureString.length - dotAfter > self.moneyCount){
        
        //[MBProgressHUD toastMessage:@"超出最大金额"];
        
        return NO;
        
    }
    
    
    //限制输入的最大金额
    if (self.maxMoney) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
        if (toBeString.floatValue > self.maxMoney) {
            return NO;
        }
    }
    
    return YES;
    
}



@end
