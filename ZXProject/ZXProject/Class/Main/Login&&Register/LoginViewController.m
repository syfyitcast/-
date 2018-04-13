//
//  LoginViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "LoginViewController.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import "RegisterViewController.h"
#import "MainTabBarController.h"
#import "ForgetPasswordCotroller.h"
#import "HttpClient.h"
#import "UserManager.h"
#import "UserLocationManager.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    int codeTime;
}

@property (nonatomic, strong) UIImageView *bgImageView;//背景图片
@property (nonatomic, strong) UIImageView *iconImageView;//用户头像
@property (nonatomic, strong) UIImageView *mobileIcon;
@property (nonatomic, strong) FButton *sendCodeBtn;//发送验证码按钮
@property (nonatomic, strong) UIImageView *screCodeIcon;
@property (nonatomic, strong) UITextField *mobileField;//手机号码
@property (nonatomic, strong) UITextField *screCodeField;//验证码
@property (nonatomic, strong) FButton *loginBtn;//登陆按钮
@property (nonatomic, strong) FButton *forgetPasswdBtn;//忘记密码
@property (nonatomic, strong) FButton *registerBtn;//立即注册
@property (nonatomic, strong) FButton *pwdForgetBtn;//找回密码;

@property (nonatomic, assign) BOOL loginStatus;
@property (nonatomic, strong) NSTimer *codeTimer;//验证码定时器

@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UIView *lineTwo;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isLocationAuthrize];
    codeTime = 60;
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self setSubviews];
    [self statusAccountLogin];
    
}

- (void)isLocationAuthrize{//判断有没有定位权限
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.75;
    coverView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.text = @"智慧环卫app需要使用您手机的始终定位权限,否则app无法正常使用";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.width = self.view.width *  0.8;
    label.x = self.view.width * 0.1;
    label.height = 50;
    label.y = (self.view.height - label.height)*0.5;
    [coverView addSubview:label];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        //定位功能可用
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用
        [[UIApplication sharedApplication].keyWindow addSubview:coverView];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setSubviews{
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.mobileIcon];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.mobileField];
    [self.view addSubview:self.lineOne];
    [self.view addSubview:self.screCodeIcon];
    [self.view addSubview:self.screCodeField];
    [self.view addSubview:self.lineTwo];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.forgetPasswdBtn];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.pwdForgetBtn];
    __weak typeof(self) weakself = self;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.top.equalTo(weakself.view.mas_top).offset(60);
        make.width.mas_equalTo(272*0.5);
        make.height.mas_equalTo(272*0.5);
    }];
    [self.mobileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.top.equalTo(weakself.iconImageView.mas_bottom).offset(60);
        make.size.mas_equalTo(weakself.mobileIcon.image.size);
    }];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.bottom.equalTo(weakself.mobileIcon.mas_bottom).offset(3);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    [self.mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mobileIcon.mas_right).offset(10);
        make.bottom.equalTo(weakself.mobileIcon.mas_bottom);
        make.height.mas_equalTo(17);
        make.right.equalTo(weakself.sendCodeBtn.mas_left).offset(-10);
    }];
    [self.lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakself.mobileIcon.mas_bottom).offset(5);
    }];
    [self.screCodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.top.equalTo(weakself.lineOne.mas_bottom).offset(30);
        make.size.mas_equalTo(weakself.screCodeIcon.image.size);
    }];
    [self.screCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.screCodeIcon.mas_right).offset(10);
        make.bottom.equalTo(weakself.screCodeIcon.mas_bottom);
        make.height.mas_equalTo(17);
        make.right.equalTo(weakself.mobileField.mas_right);
    }];
    [self.pwdForgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.bottom.equalTo(weakself.screCodeIcon.mas_bottom).offset(3);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    [self.lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakself.screCodeIcon.mas_bottom).offset(5);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.height.mas_equalTo(44);
        make.top.equalTo(weakself.lineTwo.mas_bottom).offset(30);
    }];
    [self.forgetPasswdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.loginBtn.mas_right);
        make.top.equalTo(weakself.loginBtn.mas_bottom).offset(12);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(20);
    }];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.loginBtn.mas_left);
        make.top.equalTo(weakself.loginBtn.mas_bottom).offset(12);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(20);
    }];
}

- (void)forgetPasswordAction{
    ForgetPasswordCotroller *vc = [[ForgetPasswordCotroller alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickRegisterAction{
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)statusAccountLogin{
    self.loginStatus = YES;//账号登录
    self.pwdForgetBtn.hidden = NO;
    [self.forgetPasswdBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
    [self.forgetPasswdBtn addTarget:self action:@selector(statusScreCodeLogin) forControlEvents:UIControlEventTouchUpInside];
    self.screCodeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{
                                                                                                                                                NSForegroundColorAttributeName:WhiteColor,
                                                                                                                                                NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                                                                                                }];
    _mobileField.attributedPlaceholder = [[NSMutableAttributedString alloc]
                                          initWithString:@"请输入账号" attributes:@{
                                                                                NSForegroundColorAttributeName:WhiteColor,
                                                                                NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                                
                                                                                
                                                                                }];
    self.mobileField.keyboardType = UIKeyboardTypeTwitter;
    self.mobileField.text = @"13467311554";
    self.screCodeField.text = @"a123456";
    self.screCodeField.keyboardType = UIKeyboardTypeTwitter;
    self.screCodeField.secureTextEntry = YES;
    self.screCodeIcon.image = [UIImage imageNamed:@"pwdIcon"];
    __weak typeof(self) weakself = self;
    [self.screCodeIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakself.screCodeIcon.image.size);
    }];
    self.sendCodeBtn.hidden = YES;
}

- (void)statusScreCodeLogin{
    self.loginStatus = NO;//账号登录
    self.pwdForgetBtn.hidden = YES;
    [self.forgetPasswdBtn setTitle:@"账号登录" forState:UIControlStateNormal];
    [self.forgetPasswdBtn addTarget:self action:@selector(statusAccountLogin) forControlEvents:UIControlEventTouchUpInside];
    self.screCodeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{
                                                                                                                NSForegroundColorAttributeName:WhiteColor,
                                                                                                                NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                                                                }];
    _mobileField.attributedPlaceholder = [[NSMutableAttributedString alloc]
                                          initWithString:@"请输入手机号" attributes:@{
                                                                               NSForegroundColorAttributeName:WhiteColor,
                                                                               NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                               
                                                                               
                                                                               }];
    self.mobileField.keyboardType = UIKeyboardTypeTwitter;
    self.mobileField.text = @"";
    self.screCodeField.text = @"";
    self.screCodeField.keyboardType =  UIKeyboardTypeNumberPad;
    self.screCodeField.secureTextEntry = NO;
    self.screCodeIcon.image = [UIImage imageNamed:@"scrIcon"];
    __weak typeof(self) weakself = self;
    [self.screCodeIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakself.screCodeIcon.image.size);
    }];
    self.sendCodeBtn.hidden = NO;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    __weak typeof(self) weakself = self;
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).offset(self.view.height - height - 400);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    __weak typeof(self) weakself = self;
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).offset(60);
    }];
}

#pragma mark - ClickAction

- (void)clickSendCodeBtn{
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.mobileField.text];
    if(isMatch) { //有效手机号
        NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:self.mobileField.text];
        if(isMatch) { //有效手机号
            [self getCode];
            [HttpClient zx_httpClientToGetVerifyCodeWithType:3 andMobile:self.mobileField.text andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                if (code == 0) {
                    NSDictionary *dict = data[@"verificationCode"];
                    [NetworkConfig sharedNetworkingConfig].smsid = dict[@"smsid"];
                }else{
                    if ([message isKindOfClass:[NSNull class]]) {
                        [MBProgressHUD showError:@"注册失败"];
                    }else{
                        [MBProgressHUD showError:message];
                    }
                }
            }];
        }else//无效手机号
        {
            [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
        }
    }else//无效手机号
    {
        [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
    }
}

- (void)clickLoginAtion{
    if (!self.loginStatus) {
        NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:self.mobileField.text];
        if (isMatch) {
            if (self.screCodeField.text.length == 6) {
                ZXSHOW_LOADING(self.view, @"登录中...");
                [HttpClient zx_httpClientToLoginWithUserName:self.mobileField.text andVerifyCode:self.screCodeField.text andSmsid:[NetworkConfig sharedNetworkingConfig].smsid?[NetworkConfig sharedNetworkingConfig].smsid:self.screCodeField.text andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                    ZXHIDE_LOADING
                    if (code == 0) {
                        NSDictionary *userInfo = data[@"systemuser"];
                        [[UserManager sharedUserManager] getUserInfomationWithDict:userInfo];
                        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        MainTabBarController *mainVc = [[MainTabBarController alloc] init];
                        window.rootViewController = mainVc;
                    }else{
                        if ([message isKindOfClass:[NSNull class]] || message.length == 0) {
                            [MBProgressHUD showError:[NSString stringWithFormat:@"登录失败 code = %zd",code] toView:self.view];
                        }else{
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    }
                }];
            }else{
                [MBProgressHUD showError:@"请输入格式正确的验证码"];
            }
        }else{
            [MBProgressHUD showError:@"请输入正确的手机号码"];
        }
    }else{//账号密码登录
        if (self.mobileField.text.length != 0) {
            if (self.screCodeField.text.length >= 6) {
                ZXSHOW_LOADING(self.view, @"登录中...");
                [HttpClient zx_httpClientToLoginWithUserName:self.mobileField.text andPassword:self.screCodeField.text andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                    ZXHIDE_LOADING
                    if (code == 0) {
                        NSDictionary *userInfo = data[@"systemuser"];
                        [[UserManager sharedUserManager] getUserInfomationWithDict:userInfo];
                        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        MainTabBarController *mainVc = [[MainTabBarController alloc] init];
                        window.rootViewController = mainVc;
                    }else{
                        if ([message isKindOfClass:[NSNull class]] || message.length == 0) {
                            [MBProgressHUD showError:[NSString stringWithFormat:@"登录失败 code = %d",code] toView:self.view];
                        }else{
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    }
                }];
            }else{
                [MBProgressHUD showError:@"请输入格式正确的密码" toView:self.view];
            }
        }else{
            [MBProgressHUD showError:@"请输入账号  "];
        }
    }
}

- (void)changeCodeBtn{
    if (codeTime == 0) {
        [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.sendCodeBtn.enabled = YES;
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        codeTime = 60;
        return;
    }
    codeTime--;
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%zds",codeTime] forState:UIControlStateNormal];
}

- (void)getCode{
    [self.sendCodeBtn setTitle:@"60s" forState:UIControlStateNormal];
    self.sendCodeBtn.enabled = NO;
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeCodeBtn) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.codeTimer forMode:NSRunLoopCommonModes];
    [self.codeTimer fire];
}

#pragma mark - setter && getter

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"loginBG"];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"avater"];
        _iconImageView.layer.cornerRadius = 272*0.25;
    }
    return _iconImageView;
}

- (UIImageView *)mobileIcon{
    if (_mobileIcon == nil) {
        _mobileIcon = [[UIImageView alloc] init];
        _mobileIcon.image = [UIImage imageNamed:@"mobileIcon"];
    }
    return _mobileIcon;
}

- (FButton *)sendCodeBtn{
    if (_sendCodeBtn == nil) {
        _sendCodeBtn = [[FButton alloc] init];
        [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        _sendCodeBtn.backgroundColor = [UIColor clearColor];
        [_sendCodeBtn setTitleColor:UIColorWithRGB(121, 118, 118) forState:UIControlStateNormal];
        _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [_sendCodeBtn addTarget:self action:@selector(clickSendCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendCodeBtn;
}

- (UITextField *)mobileField{
    if (_mobileField == nil) {
        _mobileField = [[UITextField alloc] init];
        _mobileField.tintColor = WhiteColor;
        _mobileField.textColor = WhiteColor;
        _mobileField.keyboardType = UIKeyboardTypeNumberPad;
        NSMutableAttributedString *nString = [[NSMutableAttributedString alloc]
                                              initWithString:@"请输入手机号" attributes:@{
                                                                                        NSForegroundColorAttributeName:WhiteColor,
                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                                                        
                                                                                                        
                                                                                                                }];
        _mobileField.attributedPlaceholder = nString;
    }
    return _mobileField;
}

- (UIView *)lineOne{
    if (_lineOne == nil) {
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = [UIColor whiteColor];
    }
    return _lineOne;
}

- (UIImageView *)screCodeIcon{
    if (_screCodeIcon == nil) {
        _screCodeIcon = [[UIImageView alloc] init];
        _screCodeIcon.image = [UIImage imageNamed:@"scrIcon"];
    }
    return _screCodeIcon;
}

- (UITextField *)screCodeField{
    if (_screCodeField == nil) {
        _screCodeField = [[UITextField alloc] init];
        _screCodeField.keyboardType = UIKeyboardTypeNumberPad;               ;
        _screCodeField.textColor = WhiteColor;
        NSAttributedString *nString = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{
                                                                                                        NSForegroundColorAttributeName:WhiteColor,
                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                                                        }];
        _screCodeField.attributedPlaceholder = nString;
        
       
    }
    return _screCodeField;
}

- (UIView *)lineTwo{
    if (_lineTwo == nil) {
        _lineTwo = [[UIView alloc] init];
        _lineTwo.backgroundColor = WhiteColor;
    }
    return _lineTwo;
}

- (FButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [[FButton alloc] init];
        _loginBtn.backgroundColor = WhiteColor;
        [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:UIColorWithRGB(70,210,70) forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 6;
        _loginBtn.enabled = YES;
        [_loginBtn addTarget:self action:@selector(clickLoginAtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (FButton *)forgetPasswdBtn{
    if (_forgetPasswdBtn == nil) {
        _forgetPasswdBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_forgetPasswdBtn setTitle:@"账号登录" forState:UIControlStateNormal];
        [_forgetPasswdBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _forgetPasswdBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [_forgetPasswdBtn addTarget:self action:@selector(statusAccountLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswdBtn;
}

- (FButton *)registerBtn{
    if (_registerBtn == nil) {
        _registerBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [_registerBtn addTarget:self action:@selector(clickRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (FButton *)pwdForgetBtn{
    if (_pwdForgetBtn == nil) {
        _pwdForgetBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_pwdForgetBtn setTitle:@"找回密码" forState:UIControlStateNormal];
        [_pwdForgetBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _pwdForgetBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [_pwdForgetBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdForgetBtn;
}



@end
