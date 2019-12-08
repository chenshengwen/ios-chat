//
//  NSString+category.m
//  WFChatUIKit
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 Tom Lee. All rights reserved.
//

#import "NSString+category.h"

@implementation NSString (category)
+ (BOOL) isBlankString:(NSString *)string {
    if ([string isKindOfClass:[NSString class]]) {
        if (string == nil || string == NULL) {
            return YES;
        }
        if ([string isKindOfClass:[NSNull class]]) {
            return YES;
        }
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
        return NO;
    }
    return YES;
}
@end
