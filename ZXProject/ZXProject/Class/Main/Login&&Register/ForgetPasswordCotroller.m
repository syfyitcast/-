//
//  ForgetPasswordCotroller.m
//  ZXProject
//
//  Created by Me on 2018/2/15.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ForgetPasswordCotroller.h"
#import "GobHeaderFile.h"
#import "HttpClient.h"
#import <Masonry.h>

@interface ForgetPasswordCotroller (){
    int codeTime;
}

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *mobileIcon;
@property (nonatomic, strong) FButton *sendCodeBtn;//发送验证码按钮
@property (nonatomic, strong) UIImageView *screCodeIcon;
@property (nonatomic, strong) UITextField *mobileField;//手机号码
@property (nonatomic, strong) UITextField *screCodeField;//验证码
@property (nonatomic, strong) UIImageView *pwdIcon;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UIImageView *pwdIconTwo;
@property (nonatomic, strong) UITextField *pwdTextFieldTwo;
@property (nonatomic, strong) FButton *submitBtn;//提交按钮



@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UIView *lineFour;

@property (nonatomic, strong) NSTimer *codeTimer;

@end

@implementation ForgetPasswordCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    codeTime = 60;
    [self setNavigationLeftItem];
    [self setupSubviews];
    self.view.backgroundColor = WhiteColor;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviHeaderBg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:WhiteColor
                                                                      }];
}

- (void)setNavigationLeftItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigationBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItem)];
    
}

- (void)clickLeftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

-  (void)setupSubviews{
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.mobileIcon];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.mobileField];
    [self.view addSubview:self.screCodeIcon];
    [self.view addSubview:self.screCodeField];
    [self.view addSubview:self.lineOne];
    [self.view addSubview:self.lineTwo];
    [self.view addSubview:self.pwdIcon];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.lineThree];
    [self.view addSubview:self.pwdTextFieldTwo];
    [self.view addSubview:self.pwdIconTwo];
    [self.view addSubview:self.lineFour];
    [self.view addSubview:self.submitBtn];
    __weak typeof(self) weakself = self;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    [self.mobileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.top.equalTo(weakself.view.mas_top).offset(80);
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
    [self.lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakself.screCodeIcon.mas_bottom).offset(5);
    }];
    [self.pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.top.equalTo(weakself.lineTwo.mas_bottom).offset(30);
        make.size.mas_equalTo(weakself.pwdIcon.image.size);
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.pwdIcon.mas_right).offset(10);
        make.bottom.equalTo(weakself.pwdIcon.mas_bottom);
        make.height.mas_equalTo(17);
        make.right.equalTo(weakself.mobileField.mas_right).offset(20);
    }];
    [self.lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakself.pwdIcon.mas_bottom).offset(5);
    }];
    [self.pwdIconTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.top.equalTo(weakself.lineThree.mas_bottom).offset(30);
        make.size.mas_equalTo(weakself.pwdIconTwo.image.size);
    }];
    [self.pwdTextFieldTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.pwdIconTwo.mas_right).offset(10);
        make.bottom.equalTo(weakself.pwdIconTwo.mas_bottom);
        make.height.mas_equalTo(17);
        make.right.equalTo(weakself.pwdTextField.mas_right);
    }];
    [self.lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakself.pwdIconTwo.mas_bottom).offset(5);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(30);
        make.right.equalTo(weakself.view.mas_right).offset(-30);
        make.height.mas_equalTo(44);
        make.top.equalTo(weakself.lineFour.mas_bottom).offset(30);
    }];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    __weak typeof(self) weakself = self;
    [self.mobileIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).offset(self.view.height - height - 265);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    __weak typeof(self) weakself = self;
    [self.mobileIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).offset(80);
    }];
}

#pragma mark - setter && getter

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
            [HttpClient zx_httpClientToGetVerifyCodeWithType:2 andMobile:self.mobileField.text andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                if (code == 0) {
                    NSDictionary *dict = data[@"verificationCode"];
                    [NetworkConfig sharedNetworkingConfig].smsid = dict[@"smsid"];
                }else{
                    if ([message isKindOfClass:[NSNull class]]) {
                        [MBProgressHUD showError:@"注册失败" toView:self.view];
                    }else{
                        [MBProgressHUD showError:message toView:self.view];
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

- (void)clickSubmitAction{
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.mobileField.text];
    if(isMatch) { //有效手机号
        if (self.screCodeField.text.length == 6) {
            if (self.pwdTextField.text.length >= 6) {
                if ([self.pwdTextFieldTwo.text isEqualToString:self.pwdTextField.text]) {
                    [HttpClient zx_httpClientToForgetPasswordWithMobile:self.mobileField.text andVerifyCode:self.screCodeField.text andSmsid:[NetworkConfig sharedNetworkingConfig].smsid andNewPassword:self.pwdTextField.text andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                        if (code == 0) {
                            [MBProgressHUD showSuccess:@"密码重置成功"];
                            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.0];
                        }else{
                            if ([message isKindOfClass:[NSNull class]] || message.length == 0) {
                                [MBProgressHUD showError:[NSString stringWithFormat:@"重置密码失败 code = %zd",code]];
                            }else{
                                [MBProgressHUD showError:message];
                            }
                        }
                    }];
                }else{
                   [MBProgressHUD showError:@"两次密码输入不一致"];
                }
            }else{
               [MBProgressHUD showError:@"密码长度不能小于6位"];
            }
        }else{
            [MBProgressHUD showError:@"请输入正确的验证码"];
        }
        
    }else{//无效手机号
            [MBProgressHUD showError:@"请输入正确的手机号码"];
    }
}

#pragma mark - setter && getter

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"loginBG"];
    }
    return _bgImageView;
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
        _screCodeField.textColor = WhiteColor;
        _screCodeField.keyboardType = UIKeyboardTypeNumberPad;
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

- (UIImageView *)pwdIcon{
    if (_pwdIcon == nil) {
        _pwdIcon = [[UIImageView alloc] init];
        _pwdIcon.image = [UIImage imageNamed:@"pwdIcon"];
    }
    return _pwdIcon;
}

- (UITextField *)pwdTextField{
    if (_pwdTextField == nil) {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.textColor = WhiteColor;
        NSMutableAttributedString *nString = [[NSMutableAttributedString alloc] initWithString:@"请输入新密码(最少6位)" attributes:@{NSForegroundColorAttributeName:WhiteColor,
                                                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                                                                                  
                                                                                                                                  
                                                                                                                                  }];
        _pwdTextField.attributedPlaceholder = nString;
        _pwdTextField.secureTextEntry = YES;
        
    }
    return _pwdTextField;
}

- (UIView *)lineThree{
    if (_lineThree == nil) {
        _lineThree = [[UIView alloc] init];
        _lineThree.backgroundColor = WhiteColor;
    }
    return _lineThree;
}

- (FButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [FButton fbtnWithFBLayout:FBLayoutTypeNone andPadding:0];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:UIColorWithRGB(70,210,70) forState:UIControlStateNormal];
        _submitBtn.backgroundColor = WhiteColor;
        _submitBtn.layer.cornerRadius = 6;
        [_submitBtn addTarget:self action:@selector(clickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UIImageView *)pwdIconTwo{
    if (_pwdIconTwo == nil) {
        _pwdIconTwo = [[UIImageView alloc] init];
        _pwdIconTwo.image = [UIImage imageNamed:@"pwdIcon"];
    }
    return _pwdIconTwo;
}

- (UITextField *)pwdTextFieldTwo{
    if (_pwdTextFieldTwo == nil) {
        _pwdTextFieldTwo = [[UITextField alloc] init];
        _pwdTextFieldTwo.textColor = WhiteColor;
        NSMutableAttributedString *nString = [[NSMutableAttributedString alloc] initWithString:@"请输入新密码(最少6位)" attributes:@{NSForegroundColorAttributeName:WhiteColor,
                                                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]
                                                                                                                                  
                                                                                                                                  
                                                                                                                                  }];
        _pwdTextFieldTwo.attributedPlaceholder = nString;
        _pwdTextFieldTwo.secureTextEntry = YES;
        
    }
    return _pwdTextFieldTwo;
}

- (UIView *)lineFour{
    if (_lineFour == nil) {
        _lineFour = [[UIView alloc] init];
        _lineFour.backgroundColor = WhiteColor;
    }
    return _lineFour;
}


@end
