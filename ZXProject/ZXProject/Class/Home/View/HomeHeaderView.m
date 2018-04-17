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
#import "UserLocationManager.h"
#import "ProjectManager.h"

@interface HomeHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconView;
@property (weak, nonatomic) IBOutlet UIImageView *personIcon;

@property (weak, nonatomic) IBOutlet UILabel *personName;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userrankW;


@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *positionCity;
@property (weak, nonatomic) IBOutlet UILabel *temptureLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmLabel;
@property (weak, nonatomic) IBOutlet UILabel *wrLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

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
    self.categoryLabel.text = user.userrank;
    if ([user.userrank isEqualToString:@""]||user.userrank == nil) {
        self.categoryLabel.hidden = YES;
    }
    CGFloat width = [self.categoryLabel.text boundSizeWithFont:self.categoryLabel.font].width + 20;
    self.userrankW.constant = width;
    
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

- (void)setWeatherDict:(NSDictionary *)weatherDict{
    _weatherDict = weatherDict;
    NSString *highDes = weatherDict[@"high"];
    NSString *lowDes = weatherDict[@"low"];
    if (highDes.length > 3 && lowDes.length > 3) {
        NSString *high = [highDes substringWithRange:NSMakeRange(3, highDes.length - 3)];
        NSString *low = [lowDes substringWithRange:NSMakeRange(3, lowDes.length - 3)];
        self.temptureLabel.text = [NSString stringWithFormat:@"%@~%@",low,high];
    }
    self.dateLabel.text = weatherDict[@"date"];
    self.positionCity.text = [ProjectManager sharedProjectManager].currentModel.cityname;
}

@end
