//
//  BWCardNoValidator.m
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWCardNoValidator.h"

@implementation BWCardNoValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
        //        self.errorMessage = @"没有输入!";
        
    } else {
        
        BOOL isMatch = [self isValidCardNumber:input.text];
        if (isMatch == NO) {
            
            self.errorMessage = @"请输入正确的银行卡号!";
            //            [self showErrorMessage:self.errorMessage];
            
        } else {
            
            self.errorMessage = nil;
        }
    }
    
    return self.errorMessage == nil ? YES : NO;
}

- (BOOL)validateCharacter:(NSString *)string textField:(UITextField *)textField range:(NSRange)range
{
    // 监控UITextField是否已有内容
    if(range.length <= 0) {
        
        //有内容
        
    } else if(range.location == 0 && range.length != 0) {
        
        //内容被删除为空
    }
    
    // 限制输入的最大长度.
    if(range.location + range.length > textField.text.length) {
        //返回NO, 表示不允许替换, 即不接受输入的新字符
        return NO;
    }
    NSInteger maxLen = 24;
    /*   判断string中是否包含- 复制粘贴的时候   */
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSInteger newLen = textField.text.length + string.length - range.length;
    if (newLen > maxLen) {
        self.errorMessage = @"输入的银行卡号不能超过21位哦!";
        //        [self showErrorMessage:self.errorMessage];
        return NO;
    }
    
    // 验证输入的内容是否为 数字组成
    if ([BWValidatorTool validatorNumbers:string]) {
        // 格式化银行卡号
        return [self formatTextField:textField validateCharacter:string range:range maxLen:maxLen];
    }
    return NO;
}

// 检查银行卡是否合法
// Luhn算法
- (BOOL)isValidCardNumber:(NSString *)cardNumber
{
    NSString *digitsOnly = [self getDigitsOnly:cardNumber];
    NSInteger sum = 0;
    NSInteger digit = 0;
    NSInteger addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    NSInteger modulus = sum % 10;
    return modulus == 0;
}

@end
