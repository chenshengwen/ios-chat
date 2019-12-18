//
//  BWPasswordValidator.m
//  Betway
//
//  Created by mac on 2019/6/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWPasswordValidator.h"

@implementation BWPasswordValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
                self.errorMessage = @"没有输入!";
        
    } else {
        
        BOOL isMatch = [input.text isValidBWPassword];

        if (isMatch == NO) {
            
            self.errorMessage = @"密码须由6-14位的字母、数字，并区分大小写";
            
        } else {
            
            self.errorMessage = nil;
            
        }
    }
    
    return self.errorMessage == nil ? YES : NO;
}

- (BOOL)validateCharacter:(NSString *)string textField:(UITextField *)textField range:(NSRange)range
{
    self.errorMessage = @"请输入6~14字母或数字!";
    
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
        self.errorMessage = @"输入的密码不能超过14个字符哦!";
        
        return NO;
    }
    NSInteger maxLen = 14;
    NSInteger newLen = textField.text.length + string.length - range.length;
    if (newLen > maxLen) {
        self.errorMessage = @"输入的密码不能超过14个字符哦!";
        
        return NO;
    }
    
    // 验证输入的内容是否为 字母数字和^$#@组成
    return [BWValidatorTool validatorPasswordCharacters:string];
}

@end
