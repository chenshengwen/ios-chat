//
//  MyBaseWebViewViewController.m
//  WildFireChat
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import "MyBaseWebViewViewController.h"
#import "NSString+category.h"
#import "UIImage+Category.h"

@interface MyBaseWebViewViewController ()<WKUIDelegate, WKNavigationDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIProgressView *myProgressView;

@end

@implementation MyBaseWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *navigationBarBackGraoudImage = [UIImage imageWithColor:[UIColor redColor]];
//    [self.navigationController.navigationBar setBackgroundImage:[navigationBarBackGraoudImage
//                   stretchableImageWithLeftCapWidth:navigationBarBackGraoudImage.size.width
//                   topCapHeight:navigationBarBackGraoudImage.size.height]
//    forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = YES;

//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self creatWebView];

}


-(void)creatWebView{
    //以下代码适配大小
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = wkUController;
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    config.userContentController = [[WKUserContentController alloc] init];

    config.allowsInlineMediaPlayback = YES;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kTabBarH) configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
//    self.webView.scrollView.backgroundColor = cellBgColor;

    [self.view addSubview:self.webView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:self.myProgressView];
    
    [self requstWeb];
}


- (void)requstWeb{
   
    if (![NSString isBlankString:self.url]) {
        NSURL *url = [[NSURL alloc] initWithString:self.url];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        [self.webView reload];
    }
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}
#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        //        JDWLog(@"newprogress == %lf",newprogress);
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kStatusBarH, [UIScreen mainScreen].bounds.size.width, 1)];
        _myProgressView.tintColor = UIColor.redColor;
        _myProgressView.trackTintColor = UIColor.whiteColor;
    }
    
    return _myProgressView;
}
@end
