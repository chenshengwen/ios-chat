//
//  MyLoginViewController.m
//  WildFireChat
//
//  Created by 陈圣文 on 2019/12/8.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import "MyLoginViewController.h"
#import <WFChatClient/WFCChatClient.h>
#import <WFChatUIKit/WFChatUIKit.h>
#import "AppDelegate.h"
#import "WFCBaseTabBarController.h"
#import "MBProgressHUD.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "WFCPrivacyViewController.h"
#import "AppService.h"
#import "BWPasswordValidator.h"
#import "BWUserNameValidator.h"
#import "OpenInstallSDK.h"
#import <UMPush/UMessage.h>  //友盟推送


typedef NS_ENUM(NSInteger,LoginType) {
    myLoginType,
    myRegistType
};

#define errorMsg @"渠道获取失败，请使用正确地址重新安装"

@interface MyLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *regihterBtn;
@property (weak, nonatomic) IBOutlet UIButton *inputCodeBtn;

@property (weak, nonatomic) IBOutlet BWTextField *confirepasswordTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnTopCon;
@property (weak, nonatomic) IBOutlet UIButton *secturyBtn;
@property (nonatomic, copy) NSString *channelId;

@property (nonatomic, assign) LoginType type;

@end

@implementation MyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChannelInputView) name:knotificationDimissChannelId object:nil];
    //是否第一次安装app，弹窗渠道输入框
    BOOL isFirstInstall = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstInstall];
    if (!isFirstInstall) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstInstall];
        [self showChannelInputView];
    }
    
    self.phoneTF.layer.borderColor = GrayBlogColor.CGColor;
    self.phoneTF.layer.borderWidth = 1;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    self.phoneTF.validator = [BWUserNameValidator new];

    
    self.passwordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.passwordTF.layer.borderWidth = 1;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    self.passwordTF.validator = [BWPasswordValidator new];

    
    self.confirepasswordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.confirepasswordTF.layer.borderWidth = 1;
    self.confirepasswordTF.leftViewMode = UITextFieldViewModeAlways;
    self.confirepasswordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    self.confirepasswordTF.validator = [BWPasswordValidator new];

    
    self.confirepasswordTF.hidden = YES;
    self.secturyBtn.hidden = YES;
    self.loginBtnTopCon.constant = 50;
    
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedPassword"];
    if (!BWIsNull(phone)) {
        self.phoneTF.text = phone;
    }
    
    if (!BWIsNull(password)) {
        self.passwordTF.text = password;
        self.loginBtn.backgroundColor = kRedThemColor;
    }

}


- (void)channelTextChange:(NSNotification *)noti {
    UITextField *textField = noti.object;
    self.channelId = textField.text;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)loginClick:(UIButton *)sender {
    [self resetKeyboard:nil];
    
    NSString *channelId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultchannelID];
    if (!channelId) {
        [self showChannelInputView];
        return;
    }
    
    if ([GlobalTool getAppID]) {
        if (self.type == myLoginType) {
            [self logintAction];
        }else {
            [self registerAction];
        }
    }else {

        [self getAppIdFormChannelId:channelId];
    }
    
    
}

- (void)showChannelInputView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入渠道码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *comfir = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:weakSelf.channelId forKey:kUserDefaultchannelID];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[AppService sharedAppService] getAppIDWithChannelId:weakSelf.channelId  Success:^(NSString * _Nonnull appId, NSString * _Nonnull appUrl) {
              
              [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kUserDefaultAppID];
              [[NSUserDefaults standardUserDefaults] setObject:appUrl forKey:kUserDefaultAppURL];
              [[NSUserDefaults standardUserDefaults] synchronize];

          } error:^(NSString * _Nonnull message, int errorCode) {
              
          }];
    }];
    [alert addAction:cacel];
    [alert addAction:comfir];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入渠道码";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(channelTextChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)getAppIdFormChannelId:(NSString *)channelId {
    
    [[AppService sharedAppService] getAppIDWithChannelId:channelId Success:^(NSString * _Nonnull appId, NSString * _Nonnull appUrl) {
        
        [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kUserDefaultAppID];
        [[NSUserDefaults standardUserDefaults] setObject:appUrl forKey:kUserDefaultAppURL];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (self.type == myLoginType) {
            [self logintAction];
        }else {
            [self registerAction];
        }

    } error:^(NSString * _Nonnull message, int errorCode) {
        if (errorCode == 404) {
            [self showChannelInputView];
        }
        [MBProgressHUD showMessage:message];

    }];
    
}

- (void)logintAction {
    
    if ([self.phoneTF.text isMobileNumber]) {
        [MBProgressHUD showMessage:@"不允许使用手机号码作为用户名"];
        return;
    }
    
    if (![self.phoneTF validate]) {
        [MBProgressHUD showMessage:@"请输入6~20字母或数字!"];
        return;
    }
    
    if (![self.passwordTF validate]) {
        [MBProgressHUD showMessage:@"请输入6-15位英文、数字、可使用特殊符号"];
        return;
    }
    
    
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       hud.label.text = @"登陆中...";
       [hud showAnimated:YES];
       
         [[AppService sharedAppService] login:self.phoneTF.text
                                     password:self.passwordTF.text
                                      company:[GlobalTool getAppID]
                                      success:^(NSString *userId, NSString *token, BOOL newUser) {
             [[NSUserDefaults standardUserDefaults] setObject:self.phoneTF.text forKey:@"savedName"];
             [[NSUserDefaults standardUserDefaults] setObject:self.passwordTF.text forKey:@"savedPassword"];

             [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"savedToken"];
             [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"savedUserId"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             //绑定别名
             [UMessage setAlias:userId type:[GlobalTool getAliasType] response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                 NSLog(@"response:%@",responseObject);
             }];
         //需要注意token跟clientId是强依赖的，一定要调用getClientId获取到clientId，然后用这个clientId获取token，这样connect才能成功，如果随便使用一个clientId获取到的token将无法链接成功。
             [[WFCCNetworkService sharedInstance] connect:userId token:token];
             
             dispatch_async(dispatch_get_main_queue(), ^{
               [hud hideAnimated:YES];
                 WFCBaseTabBarController *tabBarVC = [WFCBaseTabBarController new];
                 tabBarVC.newUser = newUser;
                 [UIApplication sharedApplication].delegate.window.rootViewController =  tabBarVC;
             });
         } error:^(int errCode, NSString *message) {
             NSLog(@"login error with code %d, message %@", errCode, message);
           dispatch_async(dispatch_get_main_queue(), ^{
             [hud hideAnimated:YES];
             
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             hud.mode = MBProgressHUDModeText;
               hud.label.text = BWIsNull(message) ? @"登陆失败" : message;
             hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
             [hud hideAnimated:YES afterDelay:1.f];
           });
         }];
}

- (void)registerAction {
    
  if ([self.phoneTF.text isMobileNumber]) {
           [MBProgressHUD showMessage:@"不允许使用手机号码作为用户名"];
           return;
       }
       
       if (![self.phoneTF validate]) {
           [MBProgressHUD showMessage:@"请输入6~20字母或数字!"];
           return;
       }
    
    if (![self.passwordTF validate]) {
        [MBProgressHUD showMessage:@"请输入6-15位英文、数字、可使用特殊符号"];
        return;

    }
    
    if (![self.confirepasswordTF validate]) {
        [MBProgressHUD showMessage:@"请输入6-15位英文、数字、可使用特殊符号"];
        return;
    }
    
    if (![self.passwordTF.text isEqualToString:self.confirepasswordTF.text]) {
        [MBProgressHUD showMessage:@"两次密码输入不一致"];
        return;
    }

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"注册中...";
    [hud showAnimated:YES];
    
    [[AppService sharedAppService] regist:self.phoneTF.text password:self.passwordTF.text company:[GlobalTool getAppID] success:^(NSString * _Nonnull userId, NSString * _Nonnull name) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [hud hideAnimated:YES];
            //用户注册成功后调用
            [OpenInstallSDK reportRegister];
            [MBProgressHUD showMessage:@"注册成功，请点击登录"];
            NSLog(@"userId:%@,name:%@",userId,name);
            [self registClick:self.regihterBtn];
        });
    } error:^(int errCode, NSString * _Nonnull message) {
        NSLog(@"login error with code %d, message %@", errCode, message);
        dispatch_async(dispatch_get_main_queue(), ^{
          [hud hideAnimated:YES];
          
          MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          hud.mode = MBProgressHUDModeText;
            hud.label.text = BWIsNull(message) ? @"注册失败" : message;
          hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
          [hud hideAnimated:YES afterDelay:1.f];
        });
    }];
}

- (IBAction)registClick:(UIButton *)sender {
    if (self.type == myLoginType) {
        self.type = myRegistType;
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        [sender setTitle:@"登录" forState:UIControlStateNormal];
        
        self.confirepasswordTF.hidden = NO;
        self.secturyBtn.hidden = NO;
        self.loginBtnTopCon.constant = 100;
        self.inputCodeBtn.hidden = NO;
    }else {
        self.type = myLoginType;
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [sender setTitle:@"新用户" forState:UIControlStateNormal];
        
        self.confirepasswordTF.hidden = YES;
        self.secturyBtn.hidden = YES;
        self.loginBtnTopCon.constant = 50;
        self.inputCodeBtn.hidden = YES;
    }
    
}


- (IBAction)inputCodeAction:(UIButton *)sender {
    [self showChannelInputView];
    
}


- (void)resetKeyboard:(id)sender {
    [self.phoneTF resignFirstResponder];
    
    [self.passwordTF resignFirstResponder];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.phoneTF ) {
        self.phoneTF.layer.borderColor = UIColor.systemRedColor.CGColor;
        self.phoneTF.layer.borderWidth = 1;
        self.passwordTF.layer.borderColor = GrayBlogColor.CGColor;
        self.passwordTF.layer.borderWidth = 1;
        self.confirepasswordTF.layer.borderColor = GrayBlogColor.CGColor;
        self.confirepasswordTF.layer.borderWidth = 1;
    }else if (textField == self.passwordTF){
        self.phoneTF.layer.borderColor = GrayBlogColor.CGColor;
        self.phoneTF.layer.borderWidth = 1;
        self.passwordTF.layer.borderColor = UIColor.systemRedColor.CGColor;
        self.passwordTF.layer.borderWidth = 1;
        self.confirepasswordTF.layer.borderColor = GrayBlogColor.CGColor;
        self.confirepasswordTF.layer.borderWidth = 1;
    }else {
        self.phoneTF.layer.borderColor = GrayBlogColor.CGColor;
        self.phoneTF.layer.borderWidth = 1;
        self.passwordTF.layer.borderColor = GrayBlogColor.CGColor;
        self.passwordTF.layer.borderWidth = 1;
        self.confirepasswordTF.layer.borderColor = UIColor.systemRedColor.CGColor;
        self.confirepasswordTF.layer.borderWidth = 1;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BWTextField *customField = (BWTextField *)textField;
    return [customField validateCharacter:string range:range];
}

- (void)textDidChange:(id<UITextInput>)textInput {
    if (textInput == self.phoneTF) {
        if ([self.phoneTF validate]) {
            if (self.passwordTF.text.length > 5 && self.passwordTF.text.length >5) {
                if (self.type == myLoginType) {
                    self.loginBtn.backgroundColor = kRedThemColor;
                    self.loginBtn.enabled = YES;
                }else {
                    if ([self.passwordTF.text isEqualToString:self.confirepasswordTF.text]) {
                        self.loginBtn.backgroundColor = kRedThemColor;
                        self.loginBtn.enabled = YES;
                    }else {
                        self.loginBtn.backgroundColor = GrayBlogColor;
                        self.loginBtn.enabled = NO;

                    }
                }
                
            }else {
                self.loginBtn.backgroundColor = GrayBlogColor;
                self.loginBtn.enabled = NO;
            }
        }else {
            self.loginBtn.backgroundColor = GrayBlogColor;
            self.loginBtn.enabled = NO;
        }
    }else if (textInput == self.passwordTF){
        if (self.passwordTF.text.length > 5) {
            if ([self.phoneTF validate]) {
                if (self.type == myLoginType) {
                    self.loginBtn.backgroundColor = kRedThemColor;
                    self.loginBtn.enabled = YES;
                }else {
                    if ([self.passwordTF.text isEqualToString:self.confirepasswordTF.text]) {
                        self.loginBtn.backgroundColor = kRedThemColor;
                        self.loginBtn.enabled = YES;
                    }else {
                        self.loginBtn.backgroundColor = GrayBlogColor;
                        self.loginBtn.enabled = NO;
                    }
                }
                
            }else {
                self.loginBtn.backgroundColor = GrayBlogColor;
                self.loginBtn.enabled = NO;
            }
        }else {
            self.loginBtn.backgroundColor = GrayBlogColor;
            self.loginBtn.enabled = NO;
        }
    }else {
        if (self.confirepasswordTF.text.length > 5) {
            if ([self.phoneTF validate] && [self.passwordTF.text isEqualToString:self.confirepasswordTF.text]) {
                self.loginBtn.backgroundColor = kRedThemColor;
                self.loginBtn.enabled = YES;
            }else {
                self.loginBtn.backgroundColor = GrayBlogColor;
                self.loginBtn.enabled = NO;
            }
        }else {
            self.loginBtn.backgroundColor = GrayBlogColor;
            self.loginBtn.enabled = NO;
        }
    }

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    self.phoneTF.layer.borderColor = GrayBlogColor.CGColor;
    self.phoneTF.layer.borderWidth = 1;
    self.passwordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.passwordTF.layer.borderWidth = 1;
    self.confirepasswordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.confirepasswordTF.layer.borderWidth = 1;
}

- (IBAction)passwordSecturyClick1:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry = !sender.selected;
}

- (IBAction)passwordSecturyClick2:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.confirepasswordTF.secureTextEntry = !sender.selected;
}

@end
