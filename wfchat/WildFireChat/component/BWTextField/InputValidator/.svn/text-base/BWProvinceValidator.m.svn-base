//
//  BWProvinceValidator.m
//  Betway
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWProvinceValidator.h"

@implementation BWProvinceValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
        //        self.errorMessage = @"没有输入!";
        
    } else {
        
        BOOL isMatch = [input.text isValidProvinceWithMinLenth:2 maxLenth:21 containChinese:YES firstCannotBeDigtal:NO];
        if (isMatch == NO) {
            
            self.errorMessage = @"请输入2~20汉字!";
            
        } else {
            
            self.errorMessage = nil;
        }
    }
    
    return self.errorMessage == nil ? YES : NO;
}

- (BOOL)validateCharacter:(NSString *)string textField:(UITextField *)textField range:(NSRange)range
{
 
    self.errorMessage = @"请输入2~50字母或汉字!";
    
    // 监控UITextField是否已有内容
    if(range.length <= 0) {
        
        //有内容
        
    } else if(range.location == 0 && range.length != 0) {
        
        //内容被删除为空
        self.errorMessage = @"";
    }
    
    // 限制输入的最大长度.
    if(range.location + range.length > textField.text.length) {
        //返回NO, 表示不允许替换, 即不接受输入的新字符
        self.errorMessage = @"输入的用户名不能超过14个字符哦!";
        
        return NO;
    }
    NSInteger maxLen = 20;
    NSInteger newLen = textField.text.length + string.length - range.length;
    if (newLen > maxLen) {
        self.errorMessage = @"输入的用户名不能超过50个字符哦!";
        
        return NO;
    }
    
    // 验证输入的内容是否为 字母数字组成
//    return [string isValidProvinceWithMinLenth:1 maxLenth:21 containChinese:YES firstCannotBeDigtal:NO];
    if (string.length == 0) {
        return YES;
    }
    return [string isChineseAndLetterAndNumberWithMinLenth:1 maxLenth:21 containOtherCharacter:@""];
}

@end
