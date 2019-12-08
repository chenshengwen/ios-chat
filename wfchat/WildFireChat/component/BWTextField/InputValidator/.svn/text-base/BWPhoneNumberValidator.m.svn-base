//
//  BWPhoneNumberValidator.m
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWPhoneNumberValidator.h"

@implementation BWPhoneNumberValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
        self.errorMessage = @"电话号码未填写";
        //        [self showErrorMessage:self.errorMessage];
        
    } else {
        
        // 剔除非法字符（仅保留数字）
        NSString *digitsOnly = [self getDigitsOnly:input.text];
        
        BOOL isMatch = [digitsOnly isMatch:RX(@"^1[0-9]{10}$")];
        if (isMatch == NO) {
            
            self.errorMessage = @"联系电话格式错误";
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
    NSInteger maxLen = 11;
    NSInteger newLen = textField.text.length + string.length - range.length;
    if (newLen > maxLen) {
        self.errorMessage = @"输入的联系电话不能超过11位数字!";
        //        [self showErrorMessage:self.errorMessage];
        return NO;
    }
    
    //    // 验证输入的内容是否为 数字组成
    //    if ([SFValidatorTool validatorNumbers:string]) {
    //        return
    //        // 格式化手机号
    ////        [self formatTextField:textField validateCharacter:string range:range maxLen:maxLen textFieldType:SFInputFieldTypePhone];
    //    }
    
    return [BWValidatorTool validatorNumbers:string];
}

@end
