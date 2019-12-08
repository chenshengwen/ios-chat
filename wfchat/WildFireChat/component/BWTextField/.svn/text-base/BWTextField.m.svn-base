//
//  BWTextField.m
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWTextField.h"

@implementation BWTextField

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    UIView *leftView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    self.leftView          = leftView;
    self.leftViewMode      = UITextFieldViewModeWhileEditing;
    
//    [self yt_setPlaceholderTextColorForKey:kCK_Line_A font:FONT(12)];
//    self.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName : FONT(12)}];
//    [self setValue:FONT(12) forKeyPath:@"_placeholderLabel.font"];
}

- (BOOL)validate {
    
    return [self.validator validateInput:self];
}

- (BOOL)validateCharacter:(NSString *)string range:(NSRange)range {
    
    return [self.validator validateCharacter:string textField:self range:range];
}




@end
