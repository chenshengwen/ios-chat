//
//  WFCUConfigManager.h
//  WFChatUIKit
//
//  Created by heavyrain lee on 2019/9/22.
//  Copyright © 2019 WF Chat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WFCUAppServiceProvider.h"

NS_ASSUME_NONNULL_BEGIN

static int kGroupLimit = 500;
static int kForwardLimit = 100;

@interface WFCUConfigManager : NSObject
+ (WFCUConfigManager *)globalManager;

@property(nonatomic, strong)UIColor *backgroudColor;
/*
 * 与backgroudColor的区别是，backgroudColor是内容区的背景颜色；frameBackgroudColor是内容区之外框架的颜色，也用在输入框的背景色。
 */
@property(nonatomic, strong)UIColor *frameBackgroudColor;
@property(nonatomic, strong)UIColor *textColor;

@property(nonatomic, strong)UIColor *naviBackgroudColor;
@property(nonatomic, strong)UIColor *naviTextColor;

@property(nonatomic, weak)id<WFCUAppServiceProvider> appServiceProvider;

@property (nonatomic, assign) int groupLimit;//群成员限制
@property (nonatomic, assign) int forwardLimit;//转发数量限制

@end

NS_ASSUME_NONNULL_END
