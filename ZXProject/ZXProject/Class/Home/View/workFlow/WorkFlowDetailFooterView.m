//
//  WorkFlowDetailFooterView.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/30.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailFooterView.h"
#import "GobHeaderFile.h"
#import "WorkFlowDetailItemView.h"
#import <Masonry.h>

@interface WorkFlowDetailFooterView()<WorkFlowApprovItemViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (weak, nonatomic) IBOutlet UILabel *approvLabel;
@property (weak, nonatomic) IBOutlet UILabel *apprvoStatusLabel;
@property (weak, nonatomic) IBOutlet UITextView *apprvoResonTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation WorkFlowDetailFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.apprvoResonTextView.layer.borderWidth = 1;
    self.apprvoResonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.apprvoResonTextView.editable = NO;
}

+ (instancetype)workFlowDetailFooterView{
    return [[NSBundle mainBundle] loadNibNamed:@"WorkFlowDetailFooterView" owner:nil options:nil].lastObject;
}

- (void)setApprovItem{
    //第一个item是申请人
    WorkFlowDetailItemView *item_0 = [WorkFlowDetailItemView workFlowDetailItemView];
    item_0.model = self.submitModel;
    CGFloat width = (self.width - 2 * 58.5 ) / 3.0;
    CGFloat height = 100;
    [self.myScrollView addSubview:item_0];
     __weak typeof(self)  weakself = self;
    [item_0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.top.equalTo(weakself.myScrollView.mas_top);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    UIImageView *imageView_0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apprvoFlowAworr"]];
    [self.myScrollView addSubview:imageView_0];
    [imageView_0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item_0.mas_right);
        make.centerY.equalTo(weakself.myScrollView.mas_centerY);
        make.width.mas_equalTo(58.5);
        make.height.mas_equalTo(28.5);
    }];
    for (int i = 1; i <= self.models.count; i ++) {
        if (i == self.models.count) {
            WorkFlowDetailItemView *item = [WorkFlowDetailItemView workFlowDetailEndItemView];
            [self.myScrollView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView_0.mas_right).offset((i - 1) * (width + 58.5));
                make.top.equalTo(weakself.myScrollView.mas_top);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(height);
            }];
//            self.myScrollView.contentSize = CGSizeMake(1000, 0);
            break;
        }
        WorkFlowApprovModel *model = self.models[i];
        WorkFlowDetailItemView *item = [WorkFlowDetailItemView workFlowDetailItemView];
        [self.myScrollView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView_0.mas_right).offset((i - 1) * (width + 58.5));
            make.top.equalTo(weakself.myScrollView.mas_top);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        item.model = model;
        if (model.isCurrentModel) {
            self.myScrollView.contentOffset = CGPointMake(item.x - self.width * 0.5 + width * 0.5  , 0);
        }
        item.index = i;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apprvoFlowAworr"]];
        [self.myScrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(item.mas_right);
            make.centerY.equalTo(weakself.myScrollView.mas_centerY);
            make.width.mas_equalTo(58.5);
            make.height.mas_equalTo(28.5);
        }];
    }
}

- (void)setModels:(NSArray *)models{
    _models = models;
    self.submitModel = models.firstObject;
    for (WorkFlowApprovModel *model in _models) {
        if (model.submittime == 0 || model.submittimeStrin == nil) {
            self.currentModel = model;
            if (self.isFnished == NO) {
                self.currentModel.isCurrentModel = YES;
            }
        }
    }
    if (self.currentModel.opinion != nil) {
        self.apprvoResonTextView.text = self.currentModel.opinion;
    }
    if (self.currentModel.submittime == 0) {
        self.apprvoStatusLabel.text = @"未审核";
    }else{
        self.apprvoStatusLabel.text = @"已审核";
    }
    self.approvLabel.text = self.currentModel.employername;
    [self setApprovItem];
}

- (void)workFlowApprovItemViewDidTapItem:(WorkFlowDetailItemView *)item{
    [UIView animateWithDuration:0.35 animations:^{
         self.myScrollView.contentOffset = CGPointMake(item.x - self.width * 0.5 + item.width * 0.5   , 0);
    }];
    self.apprvoResonTextView.text = item.model.opinion;
    if (item.model.submittime == 0) {
        self.apprvoStatusLabel.text = @"未审核";
    }else{
         self.apprvoStatusLabel.text = @"已审核";
    }
    self.approvLabel.text = item.model.employername;
    if (item.model.isCurrentModel) {
        self.timeLabel.text = item.model.receiveTimeString;
    }else{
        self.timeLabel.text = item.model.submittimeStrin;
    }
    
}

@end
