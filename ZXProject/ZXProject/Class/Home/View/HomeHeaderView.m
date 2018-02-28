//
//  HomeHeaderView.m
//  ZXProject
//
//  Created by Me on 2018/2/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconView;
@property (weak, nonatomic) IBOutlet UIImageView *personIcon;

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

@end
