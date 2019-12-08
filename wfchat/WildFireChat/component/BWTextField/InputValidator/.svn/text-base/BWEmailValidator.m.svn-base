//
//  BWEmailValidator.m
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWEmailValidator.h"

@implementation BWEmailValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
        self.errorMessage = @"没有输入!";
        
    } else {
        
        BOOL isMatch = [input.text isMatch:RX(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")];
        if (isMatch == NO) {
            
            self.errorMessage = @"请输入正确的邮箱!";
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
    NSInteger maxLen = 100;
    if(range.location >= maxLen) {
        //返回NO, 表示不允许替换, 即不接受输入的新字符
        return NO;
    }
    
    // 验证输入的内容是否为 字母、数字、_@.+- 组成
    return [BWValidatorTool validatorEmailCharacters:string];
}

@end
