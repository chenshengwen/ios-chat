//
//  MyMacros.h
//  WildFireChat
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#ifndef MyMacros_h
#define MyMacros_h

// 判断是否是iPhone X, iPhoneXS和iPhoneX的相关尺寸相同
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//#define isIPhoneXAll ([[UIApplication sharedApplication] statusBarFrame].size.height == 44)
#define isIPhoneXAll    ({BOOL isPhoneX = NO;if (@available(iOS 11.0, *)) {isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;}(isPhoneX);})

// 状态栏高度
#define kStatusBarH  (isIPhoneXAll ? 44.f : 20.f)
// 导航栏高度
#define kNavigationBarH (isIPhoneXAll ? 88.f : 64.f)
// tabBar高度
#define kTabBarH (isIPhoneXAll ? (49.f+34.f) : 49.f)
// home indicator高度
#define kIndicatorH (isIPhoneXAll ? 34.f : 0.f)
// 状态栏高度
#define KStatus (isIPhoneXAll ? 24.f : 0.f)

//----------------------ABOUT COLOR 颜色相关 ----------------------------

/** RGB */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
/** RGBA */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/** RGB 颜色转换（16进制->10进制）*/
#define HexCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** RGB 颜色转换带透明度（16进制->10进制）*/
#define HexACOLOR(hexValue, alphaValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(hexValue & 0x0000FF))/255.0 \
alpha:alphaValue]
/** 随机颜色 */
#define randomColor [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]

/** 选中颜色 青色*/
#define selectColor   HexCOLOR(0x00A826)
/*   灰色   */
#define GrayBlogColor  HexCOLOR(0xD1D2D3)
//主题红
#define kRedThemColor HexCOLOR(0xEF413E)

// 是否为空字符串
#define BWIsNull(string) [BWDealNullTool isNullValue:string]

#define WS(weakSelf)    __weak __typeof(&*self) weakSelf = self;
#define StrongSelf(strongSelf)  __strong __typeof(weakSelf)strongSelf = weakSelf;

#define screenWidth        [UIScreen mainScreen].bounds.size.width
#define screenHeight       [UIScreen mainScreen].bounds.size.height

#define FONT(a)          [UIFont systemFontOfSize:a]
#define boldFont(a)          [UIFont boldSystemFontOfSize:a]

#define kShenshi @"SHENSHI"     //盛世
#define kJINSHENG @"JINSHENG"   //金盛
#define kYINGRONG @"YINGRONG"   //盈融
#define kYINGCHENG @"YINGCHENG"   //赢城
#define kCHENGXIN @"CHENGXIN"   //诚信
#define kJIUZHOU  @"JIUZHOU"    //九州
#define kLIYING   @"LIYING"     //利赢
#define k918      @"918"        //918
#define k518      @"518"        //518

#define kShenshi_URL @"https://ss111.cc/mobile/v3/"         //盛世
#define kJINSHENG_URL @"https://gy0007.com/m/#/%22"   //金盛
#define kYINGRONG_URL @"https://yr869.com/m/#/"   //盈融
#define kYINGCHENG_URL @"http://yc987cp.com/m/"   //赢城
#define kCHENGXIN_URL @"https://858cxcp.com/m/#/"   //诚信
#define kJIUZHOU_URL  @"https://jz6998.com/m/"    //九州
#define kLIYING_URL   @"https://ly18.cc/mobile/v3/"     //利赢
#define k918_URL      @"https://jc918.cc/mobile/v3/"        //918
#define k518_URL      @"http://www.518gycp.com/mobile/v3/"        //518


#endif /* MyMacros_h */
