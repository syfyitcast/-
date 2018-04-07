//
//  AttenceHeaderView.m
//  ZXProject
//
//  Created by Me on 2018/2/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttenceHeaderView.h"
#import "GobHeaderFile.h"


@interface AttenceHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *userrank;
@property (weak, nonatomic) IBOutlet UILabel *companyName;


@end

@implementation AttenceHeaderView


- (IBAction)ClickDkBtn {
    if (self.clickDKBtnBlock) {
        self.clickDKBtnBlock();
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconBgView.layer.cornerRadius = 25;
    self.iconBgView.layer.borderColor = UIColorWithRGB(200, 200, 200).CGColor;
    self.iconBgView.layer.borderWidth = 1;
    self.dkBtn.layer.cornerRadius = 6;
    User *user = [UserManager sharedUserManager].user;
    self.personName.text = [NSString stringWithFormat:@"姓名:%@", user.employername];
    self.userrank.text = [NSString stringWithFormat:@"职务:%@",user.userrank];
}

+ (instancetype)attenceHeaderView{
    AttenceHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"AttenceHeaderView" owner:nil options:nil].lastObject;
    return headerView;
   
}

@end
