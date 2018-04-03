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
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * 58.5 ) / 3.0;
    CGFloat height = 100;
    item_0.x = 0;
    item_0.y = 0;
    item_0.width = width;
    item_0.height = height;
    [self.myScrollView addSubview:item_0];
    UIImageView *imageView_0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apprvoFlowAworr"]];
    imageView_0.x = CGRectGetMaxX(item_0.frame);
    imageView_0.width = 58.5;
    imageView_0.height = 28.5;
    imageView_0.y = (self.myScrollView.height - imageView_0.height) * 0.5;
    [self.myScrollView addSubview:imageView_0];
    for (int i = 1; i <= self.models.count; i ++) {
        if (i == self.models.count) {
            WorkFlowDetailItemView *item = [WorkFlowDetailItemView workFlowDetailEndItemView];
            item.x = CGRectGetMaxX(imageView_0.frame) + (i - 1) * (width + 58.5);
            item.y = 0;
            item.height = height;
            item.width = width;
            [self.myScrollView addSubview:item];
            self.myScrollView.contentSize = CGSizeMake(CGRectGetMaxX(item.frame), 0);
            if (self.isFnished) {
                [item statusSelected];
                self.myScrollView.contentOffset = CGPointMake(item.x -  2 * (width + 58.5)  , 0);
            }
            break;
        }
        WorkFlowApprovModel *model = self.models[i];
        WorkFlowDetailItemView *item = [WorkFlowDetailItemView workFlowDetailItemView];
        item.model = model;
        item.x = CGRectGetMaxX(imageView_0.frame) + (i - 1) * (width + 58.5);
        if (model.isCurrentModel) {
            self.myScrollView.contentOffset = CGPointMake(item.x - self.width * 0.5 + width * 0.5  , 0);
        }
        item.y = 0;
        item.height = height;
        item.width = width;
        item.delegate = self;
        item.index = i;
        [self.myScrollView addSubview:item];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apprvoFlowAworr"]];
        imageView.x = CGRectGetMaxX(item.frame);
        imageView.y = (self.myScrollView.height - imageView_0.height) * 0.5;
        imageView.width = 58.5;
        imageView.height = 28.5;
        [self.myScrollView addSubview:imageView];
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
