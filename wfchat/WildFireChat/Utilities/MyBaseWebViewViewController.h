//
//  MyBaseWebViewViewController.h
//  WildFireChat
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBaseWebViewViewController : UIViewController
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,copy)NSString *url;
@end

NS_ASSUME_NONNULL_END
