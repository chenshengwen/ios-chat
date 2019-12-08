//
//  BWTextField.h
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWInputValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWTextField : UITextField

/**
 *  抽象的策略
 */
@property (nonatomic, strong) BWInputValidator *validator;

/**
 *  初始化textField
 *
 *  @param frame frame大小
 *
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  验证 输入合法性
 *
 *  @return 是否合法,不合法,读取InputValidator当中的errorMessage
 */
- (BOOL)validate;

/**
 *  验证 当前输入字符合法性
 *
 *  @param string 新输入的字符
 *  @param range  输入的范围
 *
 *  @return 返回NO,表示输入无效
 */
- (BOOL)validateCharacter:(NSString*)string range:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
