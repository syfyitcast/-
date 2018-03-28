//
//  HomeHeaderView.m
//  ZXProject
//
//  Created by Me on 2018/2/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeHeaderView.h"
#import "UserManager.h"
#import "NSString+boundSize.h"
#import <Masonry.h>

@interface HomeHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconView;
@property (weak, nonatomic) IBOutlet UIImageView *personIcon;

@property (weak, nonatomic) IBOutlet UILabel *personName;

@property (weak, nonatomic) IBOutlet UILabel *userrank;

@property (weak, nonatomic) IBOutlet UILabel *projectName;

@end

@implementation HomeHeaderView

- (IBAction)clickLeftBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeHeaderViewDidClickLeftBtn)]) {
        [self.delegate homeHeaderViewDidClickLeftBtn];
    }
}

- (IBAction)clickRightBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeHeaderViewDidClickRightBtn)]) {
        [self.delegate homeHeaderViewDidClickRightBtn];
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.categoryLabel.layer.cornerRadius = 7.5;
    self.categoryLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.categoryLabel.layer.borderWidth = 1;
    self.personIcon.userInteractionEnabled = YES;
    self.headerIconView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(clickIconView)];
    UITapGestureRecognizer *tap_0 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(clickIconView)];
    
    [self.personIcon addGestureRecognizer:tap_0];
    [self.headerIconView addGestureRecognizer:tap];
    User *user = [UserManager sharedUserManager].user;
    self.personName.text = [NSString stringWithFormat:@"%@ 欢迎你",user.employername];
    self.userrank.text = user.userrank;
    CGFloat width = [self.userrank.text boundSizeWithFont:self.userrank.font].width + 20;
    [self.userrank mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
}

- (void)clickIconView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeHeadeerViewDidClickIconView)]) {
        [self.delegate homeHeadeerViewDidClickIconView];
    }
}

+ (instancetype)homeHeaderView{
    HomeHeaderView *view = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil].lastObject;
    return view;
}

- (void)setProjectLabelName:(NSString *)projectName{
    self.projectName.text = projectName;
}

@end
