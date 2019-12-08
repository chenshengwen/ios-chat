//
//  BWMoneyValidator.m
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWMoneyValidator.h"

@implementation BWMoneyValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
        self.errorMessage = @"输入金额不能为空!";
        
    } else {
        
        // 只能输入零和非零开头的数字："^(0|[1-9][0-9]*)$"。
        // 只能输入有两位小数的正实数："^[0-9]+(.[0-9]{2})?$"。
        // 只能输入有1~3位小数的正实数："^[0-9]+(\.[0-9]{1,3})?$
        
        BOOL isMatch = [input.text isMatch:RX(@"^[0-9]+(\\.[0-9]{0,2})?$")];
        if (isMatch == NO) {
            
            self.errorMessage = @"请输入正确的金额!";
            
        } else {
            
            self.errorMessage = nil;
        }
    }
    
    return self.errorMessage == nil ? YES : NO;
}

- (BOOL)validateCharacter:(NSString *)string textField:(UITextField *)textField range:(NSRange)range {
    
    // 监控UITextField是否已有内容
    if(range.length <= 0) {
        
        //有内容
        
    } else if(range.location == 0 && range.length != 0) {
        
        //内容被删除为空
    }
    
    // 限制输入的最大长度.
    NSInteger maxLen = 10;
    if(range.location >= maxLen) {
        //返回NO, 表示不允许替换, 即不接受输入的新字符
        
        self.errorMessage = @"输入的金额已达到最大限制!";
        
        return NO;
    }
    
    // 用来标示字符串中是否存在小数点
    BOOL exitPoint = NO;
    BOOL res = YES;
    
    // 合法的字符集合
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    
    while (i < string.length) {
        // 首先判断是否有不合法的字符
        NSString *subString = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [subString rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO; //说明subString是不合法的字符
            break;
        }
        //第一个字符不能是小数点
        if ((textField.text.length == 0) && ([subString isEqualToString:@"."])) {
            res = NO;
            break;
        }
        //只能有一个小数点
        if ([subString isEqualToString:@"."]) {
            exitPoint = YES;
            NSString *str = textField.text;
            NSRange strRange = [str rangeOfString:@"."];
            if (strRange.length > 0) {
                res = NO;//textfield已经存在小数点，而且即将输入的也是小数点
                break;
            }
        }
        //小数点后两位
        NSRange rangePoint = [textField.text rangeOfString:@"."];
        if (rangePoint.length > 0) {
            NSString *point = [[textField.text componentsSeparatedByString:@"."] lastObject];
            if (point.length >= 2) {
                res = NO;
                break;
            }
        }
        i++;
    }
    return res;
}

@end
