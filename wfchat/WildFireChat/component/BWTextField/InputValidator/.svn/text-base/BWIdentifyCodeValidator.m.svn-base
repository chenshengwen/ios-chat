//
//  BWIdentifyCodeValidator.m
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWIdentifyCodeValidator.h"

@implementation BWIdentifyCodeValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
        self.errorMessage = @"验证码不能为空!";
        
    } else {
        self.errorMessage = nil;
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
    NSInteger maxLen = self.codeLength;
    NSInteger newLen = textField.text.length + string.length - range.length;
    if (newLen > maxLen) {
        NSString *errorMessage = [NSString stringWithFormat:@"输入的验证码只能为%ld位的数字哦!", self.codeLength];
        self.errorMessage = errorMessage;
        return NO;
    }
    
    // 验证输入的内容是否为 字母数字组成
    return [BWValidatorTool validatorNumbers:string];
}

- (NSInteger)codeLength
{
    if (_codeLength <= 0) {
        _codeLength = 4;
    }
    return _codeLength;
}

@end
