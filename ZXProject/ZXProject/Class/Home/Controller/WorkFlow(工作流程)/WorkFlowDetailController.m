//
//  WorkFlowDetailController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/29.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailController.h"
#import <Masonry.h>
#import "GobHeaderFile.h"
#import "WorkFlowDetailFooterView.h"
#import "HttpClient+DutyEvents.h"
#import "WorkFlowDetailModel.h"
#import "WorkFlowApprovModel.h"
#import <UIImageView+WebCache.h>

@interface WorkFlowDetailController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) WorkFlowDetailFooterView *footerView;
@property (nonatomic, strong) WorkFlowDetailModel *detailModel;
@property (nonatomic, strong) NSArray *approvModels;

@end

@implementation WorkFlowDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流程详情";
    [self setRequestNetWork];
}

- (void)setRequestNetWork{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToQueryDutyEventsWithEventId:self.model.eventid andFlowType:self.model.flowtype andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            self.detailModel = [WorkFlowDetailModel workFlowDetailModelWithDict:data];
            [HttpClient zx_httpClientToQueryEventFlowTasklistWithEventid:self.detailModel.eventid andflowtype:self.detailModel.flowtype andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {//查询审核人
                ZXHIDE_LOADING;
                if (code == 0) {
                    self.approvModels = [WorkFlowApprovModel workFlowApprovModelsWithSource_arr:data];
                    [self setSubViews];
                }else{
                    if (message.length != 0) {
                        [MBProgressHUD showError:message toView:self.view];
                    }
                }
            }];
            
        }else{
            if (message.length != 0) {
                [MBProgressHUD showError:message toView:self.view];
            }
        }
    }];
}

- (void)setSubViews{
    self.mainScrollView.frame = self.view.bounds;
    [self.view addSubview:self.mainScrollView];
    UIImageView *contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"approFlowRect"]];
    contentImageView.x = 15;
    contentImageView.y = 15;
    contentImageView.size = CGSizeMake(14, 16);
    [self.mainScrollView addSubview:contentImageView];
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"内容";
    contentLabel.textColor = UIColorWithFloat(33);
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.x = CGRectGetMaxX(contentImageView.frame) + 10;
    contentLabel.height = 15;
    contentLabel.centerY = contentImageView.centerY;
    contentLabel.width  = 100;
    [self.mainScrollView addSubview:contentLabel];
    UIView *lineOne = [[UIView alloc] init];
    lineOne.backgroundColor = UIColorWithFloat(239);
    [self.mainScrollView addSubview:lineOne];
    lineOne.x = 0;
    lineOne.y = CGRectGetMaxY(contentLabel.frame) + 15;
    lineOne.height = 1;
    lineOne.width = self.view.width;
    [self.mainScrollView addSubview:lineOne];
    self.footerView.x = 0;
    self.footerView.height = 420;
    self.footerView.width = self.view.width;
    [self.mainScrollView addSubview:self.footerView];
    if (self.model.flowtype == 1) {//请假
        UILabel *eventTypeLabel = [[UILabel alloc] init];
        eventTypeLabel.textColor = UIColorWithFloat(49);
        eventTypeLabel.font = [UIFont systemFontOfSize:13];
        NSString *evetTypeStr = nil;
        switch (self.detailModel.dutytype) {
            case 0:
                evetTypeStr = @"放假";
                break;
            case 1:
                evetTypeStr = @"事假";
                break;
            case 2:
                evetTypeStr = @"病假";
                break;
            case 3:
                evetTypeStr = @"带薪假";
                break;
            default:
                break;
        }
        eventTypeLabel.text = [NSString stringWithFormat:@"请假类型:  %@",evetTypeStr];
        eventTypeLabel.x = 15;
        eventTypeLabel.y = CGRectGetMaxY(lineOne.frame) + 15;
        eventTypeLabel.height = 15;
        eventTypeLabel.width = 150;
        [self.mainScrollView addSubview:eventTypeLabel];
        UIView *lineTwo = [[UIView alloc] init];
        lineTwo.backgroundColor = UIColorWithFloat(239);
        lineTwo.x = 0;
        lineTwo.y = CGRectGetMaxY(eventTypeLabel.frame) + 15;
        lineTwo.height = 1;
        lineTwo.width = self.view.width;
        [self.mainScrollView addSubview:lineTwo];
        UILabel *beginLabel = [[UILabel alloc] init];
        beginLabel.textColor = UIColorWithFloat(49);
        beginLabel.font = [UIFont systemFontOfSize:13];
        beginLabel.text = [NSString stringWithFormat:@"开始时间:  %@",self.detailModel.beginTimeString];
        beginLabel.x  = 15;
        beginLabel.y  = CGRectGetMaxY(lineTwo.frame) + 15;
        beginLabel.height = 15;
        beginLabel.width = 200;
        [self.mainScrollView addSubview:beginLabel];
        UIView *lineThree = [[UIView alloc] init];
        lineThree.backgroundColor = UIColorWithFloat(239);
        lineThree.x = 0;
        lineThree.y = CGRectGetMaxY(beginLabel.frame) + 15;
        lineThree.width = self.view.width;
        lineThree.height = 1;
        [self.mainScrollView addSubview:lineThree];
        UILabel *endLabel = [[UILabel alloc] init];
        endLabel.textColor = UIColorWithFloat(49);
        endLabel.font = [UIFont systemFontOfSize:13];
        endLabel.text = [NSString stringWithFormat:@"结束时间:  %@",self.detailModel.endTimeString];
        endLabel.x = 15;
        endLabel.y = CGRectGetMaxY(lineThree.frame) + 15;
        endLabel.height = 15;
        endLabel.width = 200;
        [self.mainScrollView addSubview:endLabel];
        UIView *lineFour = [[UIView alloc] init];
        lineFour.backgroundColor = UIColorWithFloat(239);
        lineFour.x = 0;
        lineFour.y = CGRectGetMaxY(endLabel.frame) + 15;
        lineFour.height = 1;
        lineFour.width = self.view.width;
        [self.mainScrollView addSubview:lineFour];
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = UIColorWithFloat(49);
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.text = [NSString stringWithFormat:@"时长:     %@",self.detailModel.timeString];
        timeLabel.x = 15;
        timeLabel.y = CGRectGetMaxY(lineFour.frame) + 15;
        timeLabel.height = 15;
        timeLabel.width = 200;
        [self.mainScrollView addSubview:timeLabel];
        UIView *lineFive = [[UIView alloc] init];
        lineFive.backgroundColor = UIColorWithFloat(239);
        lineFive.x = 0;
        lineFive.y = CGRectGetMaxY(timeLabel.frame) + 15;
        lineFive.height = 1;
        lineFive.width = self.view.width;
        [self.mainScrollView addSubview:lineFive];
        UILabel *reasonDesLabel = [[UILabel alloc] init];
        reasonDesLabel.textColor = UIColorWithFloat(49);
        reasonDesLabel.font = [UIFont systemFontOfSize:13];
        reasonDesLabel.text = @"事由:";
        reasonDesLabel.x = 15;
        reasonDesLabel.y = CGRectGetMaxY(lineFive.frame) + 15;
        reasonDesLabel.height = 15;
        reasonDesLabel.width = 100;
        [self.mainScrollView addSubview:reasonDesLabel];
        UITextView *reasonTextView = [[UITextView alloc] init];
        reasonTextView.editable = NO;
        reasonTextView.font = [UIFont systemFontOfSize:13];
        reasonTextView.textColor = UIColorWithFloat(119);
        reasonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
        reasonTextView.layer.borderWidth = 1;
        reasonTextView.text = self.detailModel.eventremark;
        reasonTextView.x = 15;
        reasonTextView.y = CGRectGetMaxY(reasonDesLabel.frame) + 10;
        reasonTextView.width = self.view.width - 30;
        reasonTextView.height = 80;
        [self.mainScrollView addSubview:reasonTextView];
        UIView *lineSix= [[UIView alloc] init];
        lineSix.backgroundColor = UIColorWithFloat(239);
        lineSix.x = 0;
        lineSix.y = CGRectGetMaxY(reasonTextView.frame) + 10;
        lineSix.height = 1;
        lineSix.width = self.view.width;
        [self.mainScrollView addSubview:lineSix];
        self.footerView.y = CGRectGetMaxY(lineSix.frame);
    }else if (self.model.flowtype ==4){//出差
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.text = [NSString stringWithFormat:@"出发地:  %@",self.detailModel.fromcity];
        placeLabel.textColor = UIColorWithFloat(49);
        placeLabel.font = [UIFont systemFontOfSize:13];
        placeLabel.x = 15;
        placeLabel.y = CGRectGetMaxY(lineOne.frame) + 15;
        placeLabel.height = 15;
        placeLabel.width = 150;
        [self.mainScrollView addSubview:placeLabel];
        UIView *lineTwo = [[UIView alloc] init];
        lineTwo.backgroundColor = UIColorWithFloat(239);
        lineTwo.x = 0;
        lineTwo.y = CGRectGetMaxY(placeLabel.frame) + 15;
        lineTwo.height = 1;
        lineTwo.width = self.view.width;
        [self.mainScrollView addSubview:lineTwo];
        UILabel *desPlaceLabel = [[UILabel alloc] init];
        desPlaceLabel.text = [NSString stringWithFormat:@"目的地:  %@",self.detailModel.tocity];
        desPlaceLabel.textColor = UIColorWithFloat(49);
        desPlaceLabel.font = [UIFont systemFontOfSize:13];
        desPlaceLabel.x = 15;
        desPlaceLabel.y = CGRectGetMaxY(lineTwo.frame) + 15;
        desPlaceLabel.height = 15;
        desPlaceLabel.width = 150;
        [self.mainScrollView addSubview:desPlaceLabel];
        UIView *lineThree = [[UIView alloc] init];
        lineThree.backgroundColor = UIColorWithFloat(239);
        lineThree.x = 0;
        lineThree.y = CGRectGetMaxY(desPlaceLabel.frame) + 15;
        lineThree.width = self.view.width;
        lineThree.height = 1;
        [self.mainScrollView addSubview:lineThree];
        UILabel *beginLabel = [[UILabel alloc] init];
        beginLabel.textColor = UIColorWithFloat(49);
        beginLabel.font = [UIFont systemFontOfSize:13];
        beginLabel.text = [NSString stringWithFormat:@"开始时间:  %@",self.detailModel.beginTimeString];
        beginLabel.x  = 15;
        beginLabel.y  = CGRectGetMaxY(lineThree.frame) + 15;
        beginLabel.height = 15;
        beginLabel.width = 200;
        [self.mainScrollView addSubview:beginLabel];
        UIView *lineFour = [[UIView alloc] init];
        lineFour.backgroundColor = UIColorWithFloat(239);
        lineFour.x = 0;
        lineFour.y = CGRectGetMaxY(beginLabel.frame) + 15;
        lineFour.width = self.view.width;
        lineFour.height = 1;
        [self.mainScrollView addSubview:lineFour];
        UILabel *endLabel = [[UILabel alloc] init];
        endLabel.textColor = UIColorWithFloat(49);
        endLabel.font = [UIFont systemFontOfSize:13];
        endLabel.text = [NSString stringWithFormat:@"结束时间:  %@",self.detailModel.endTimeString];
        endLabel.x = 15;
        endLabel.y = CGRectGetMaxY(lineFour.frame) + 15;
        endLabel.height = 15;
        endLabel.width = 200;
        [self.mainScrollView addSubview:endLabel];
        UIView *lineFive = [[UIView alloc] init];
        lineFive.backgroundColor = UIColorWithFloat(239);
        lineFive.x = 0;
        lineFive.y = CGRectGetMaxY(endLabel.frame) + 15;
        lineFive.width = self.view.width;
        lineFive .height = 1;
        [self.mainScrollView addSubview:lineFive];
        UILabel *tranModeLabel = [[UILabel alloc] init];
        tranModeLabel.text = [NSString stringWithFormat:@"交通工具:  %@",self.detailModel.transmodename];
        tranModeLabel.textColor = UIColorWithFloat(49);
        tranModeLabel.font = [UIFont systemFontOfSize:13];
        tranModeLabel.x = 15;
        tranModeLabel.y = CGRectGetMaxY(lineFive.frame) + 15;
        tranModeLabel.height = 15;
        tranModeLabel.width = 150;
        [self.mainScrollView addSubview:tranModeLabel];
        UIView *lineSix = [[UIView alloc] init];
        lineSix.backgroundColor = UIColorWithFloat(239);
        lineSix.x = 0;
        lineSix.y = CGRectGetMaxY(tranModeLabel.frame) + 15;
        lineSix.width = self.view.width;
        lineSix.height = 1;
        [self.mainScrollView addSubview:lineSix];
        UILabel *reasonDesLabel = [[UILabel alloc] init];
        reasonDesLabel.textColor = UIColorWithFloat(49);
        reasonDesLabel.font = [UIFont systemFontOfSize:13];
        reasonDesLabel.text = @"事由:";
        reasonDesLabel.x = 15;
        reasonDesLabel.y = CGRectGetMaxY(lineSix.frame) + 15;
        reasonDesLabel.height = 15;
        reasonDesLabel.width = 100;
        [self.mainScrollView addSubview:reasonDesLabel];
        UITextView *reasonTextView = [[UITextView alloc] init];
        reasonTextView.editable = NO;
        reasonTextView.font = [UIFont systemFontOfSize:13];
        reasonTextView.textColor = UIColorWithFloat(119);
        reasonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
        reasonTextView.layer.borderWidth = 1;
        reasonTextView.text = self.detailModel.eventremark;
        reasonTextView.x = 15;
        reasonTextView.y = CGRectGetMaxY(reasonDesLabel.frame) + 10;
        reasonTextView.width = self.view.width - 30;
        reasonTextView.height = 80;
        [self.mainScrollView addSubview:reasonTextView];
        UIView *lineSeven = [[UIView alloc] init];
        lineSeven.backgroundColor = UIColorWithFloat(239);
        lineSeven.x = 0;
        lineSeven.y = CGRectGetMaxY(reasonTextView.frame) + 10;
        lineSeven.width = self.view.width;
        lineSeven.height = 1;
        [self.mainScrollView addSubview:lineSeven];
        self.footerView.y = CGRectGetMaxY(lineSeven.frame);
    }else if (self.model.flowtype == 2){//报销
        UILabel *feeMoneyLabel = [[UILabel alloc] init];
        feeMoneyLabel.text = [NSString stringWithFormat:@"报销金额（元）:   %.f",self.detailModel.feemoney];
        feeMoneyLabel.textColor = UIColorWithFloat(49);
        feeMoneyLabel.font = [UIFont systemFontOfSize:13];
        feeMoneyLabel.x = 15;
        feeMoneyLabel.y = CGRectGetMaxY(lineOne.frame) + 15;
        feeMoneyLabel.height = 15;
        feeMoneyLabel.width = 150;
        [self.mainScrollView addSubview:feeMoneyLabel];
        UIView *lineTwo = [[UIView alloc] init];
        lineTwo.backgroundColor = UIColorWithFloat(239);
        lineTwo.x = 0;
        lineTwo.y = CGRectGetMaxY(feeMoneyLabel.frame) + 15;
        lineTwo.height = 1;
        lineTwo.width = self.view.width;
        [self.mainScrollView addSubview:lineTwo];
        UILabel *remimentTypeLael = [[UILabel alloc] init];
        remimentTypeLael.textColor = UIColorWithFloat(49);
        remimentTypeLael.font = [UIFont systemFontOfSize:13];
        remimentTypeLael.text = [NSString stringWithFormat:@"报销类别:   %@",self.detailModel.feetypename];
        remimentTypeLael.x  = 15;
        remimentTypeLael.y  = CGRectGetMaxY(lineTwo.frame) + 15;
        remimentTypeLael.height = 15;
        remimentTypeLael.width = 200;
        [self.mainScrollView addSubview:remimentTypeLael];
        UIView *lineThree = [[UIView alloc] init];
        lineThree.backgroundColor = UIColorWithFloat(239);
        lineThree.x = 0;
        lineThree.y = CGRectGetMaxY(remimentTypeLael.frame) + 15;
        lineThree.width = self.view.width;
        lineThree.height = 1;
        [self.mainScrollView addSubview:lineThree];
        UILabel *reasonDesLabel = [[UILabel alloc] init];
        reasonDesLabel.textColor = UIColorWithFloat(49);
        reasonDesLabel.font = [UIFont systemFontOfSize:13];
        reasonDesLabel.text = @"事由:";
        reasonDesLabel.x = 15;
        reasonDesLabel.y = CGRectGetMaxY(lineThree.frame) + 15;
        reasonDesLabel.height = 15;
        reasonDesLabel.width = 100;
        [self.mainScrollView addSubview:reasonDesLabel];
        UITextView *reasonTextView = [[UITextView alloc] init];
        reasonTextView.editable = NO;
        reasonTextView.font = [UIFont systemFontOfSize:13];
        reasonTextView.textColor = UIColorWithFloat(119);
        reasonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
        reasonTextView.layer.borderWidth = 1;
        reasonTextView.text = self.detailModel.eventremark;
        reasonTextView.x = 15;
        reasonTextView.y = CGRectGetMaxY(reasonDesLabel.frame) + 10;
        reasonTextView.width = self.view.width - 30;
        reasonTextView.height = 80;
        [self.mainScrollView addSubview:reasonTextView];
        UIView *lineFour = [[UIView alloc] init];
        lineFour.backgroundColor = UIColorWithFloat(239);
        lineFour.x = 0;
        lineFour.y = CGRectGetMaxY(reasonTextView.frame) + 10;
        lineFour.height = 1;
        lineFour.width = self.view.width;
        [self.mainScrollView addSubview:lineFour];
        UILabel *picDesLabel = [[UILabel alloc] init];
        picDesLabel.textColor = UIColorWithFloat(49);
        picDesLabel.font = [UIFont systemFontOfSize:13];
        picDesLabel.text = @"图片:";
        picDesLabel.x = 15;
        picDesLabel.y = CGRectGetMaxY(lineFour.frame) + 15;
        picDesLabel.height = 15;
        picDesLabel.width = 100;
        [self.mainScrollView addSubview:picDesLabel];
        CGFloat padding = 15;
        int i = 0;
        CGFloat width = (self.view.width - 5 * padding) / 4;
        CGFloat height = 100;
        for (NSString *picUrl in self.detailModel.photoUrls) {
            UIImageView *picImagView = [[UIImageView alloc] init];
            [picImagView sd_setImageWithURL:[NSURL URLWithString:picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (image == nil) {
                    [MBProgressHUD showError:@"加载图片失败" toView:self.mainScrollView];
                }
            }];//加载图片
            picImagView.x = padding + (padding + width) * i;
            picImagView.y = CGRectGetMaxY(picDesLabel.frame) + 10;
            picImagView.width = width;
            picImagView.height = height;
            [self.mainScrollView addSubview:picImagView];
            i ++;
        }
        UIView *lineFive = [[UIView alloc] init];
        lineFive.backgroundColor = UIColorWithFloat(239);
        lineFive.x = 0;
        lineFive.y = CGRectGetMaxY(reasonTextView.frame) + 10;
        lineFive.height = 1;
        lineFive.width = self.view.width;
        [self.mainScrollView addSubview:lineFive];
        if (self.detailModel.photoUrls.count == 0) {
            lineFive.y = CGRectGetMaxY(picDesLabel.frame) + 15;
        }else{
            lineFive.y = CGRectGetMaxY(picDesLabel.frame) + height + 10 + padding;
        }
        self.footerView.y = CGRectGetMaxY(lineFive.frame) + 15;
    }else if (self.model.flowtype == 3){//呈报
        UILabel *reportTypeLabel = [[UILabel alloc] init];
        reportTypeLabel.text = [NSString stringWithFormat:@":呈报类型   %@",self.detailModel.reportname];
        reportTypeLabel.textColor = UIColorWithFloat(49);
        reportTypeLabel.font = [UIFont systemFontOfSize:13];
        reportTypeLabel.x = 15;
        reportTypeLabel.y = CGRectGetMaxY(lineOne.frame) + 15;
        reportTypeLabel.height = 15;
        reportTypeLabel.width = 150;
        [self.mainScrollView addSubview:reportTypeLabel];
        UIView *lineTwo = [[UIView alloc] init];
        lineTwo.backgroundColor = UIColorWithFloat(239);
        lineTwo.x = 0;
        lineTwo.y = CGRectGetMaxY(reportTypeLabel.frame) + 15;
        lineTwo.height = 1;
        lineTwo.width = self.view.width;
        [self.mainScrollView addSubview:lineTwo];
        UILabel *reasonDesLabel = [[UILabel alloc] init];
        reasonDesLabel.textColor = UIColorWithFloat(49);
        reasonDesLabel.font = [UIFont systemFontOfSize:13];
        reasonDesLabel.text = @"呈报内容:";
        reasonDesLabel.x = 15;
        reasonDesLabel.y = CGRectGetMaxY(lineTwo.frame) + 15;
        reasonDesLabel.height = 15;
        reasonDesLabel.width = 100;
        [self.mainScrollView addSubview:reasonDesLabel];
        UITextView *reasonTextView = [[UITextView alloc] init];
        reasonTextView.editable = NO;
        reasonTextView.font = [UIFont systemFontOfSize:13];
        reasonTextView.textColor = UIColorWithFloat(119);
        reasonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
        reasonTextView.layer.borderWidth = 1;
        reasonTextView.text = self.detailModel.eventremark;
        reasonTextView.x = 15;
        reasonTextView.y = CGRectGetMaxY(reasonDesLabel.frame) + 10;
        reasonTextView.width = self.view.width - 30;
        reasonTextView.height = 80;
        [self.mainScrollView addSubview:reasonTextView];
        UIView *lineThree = [[UIView alloc] init];
        lineThree.backgroundColor = UIColorWithFloat(239);
        lineThree.x = 0;
        lineThree.y = CGRectGetMaxY(reasonTextView.frame) + 15;
        lineThree.width = self.view.width;
        lineThree.height = 1;
        [self.mainScrollView addSubview:lineThree];
        UILabel *picDesLabel = [[UILabel alloc] init];
        picDesLabel.textColor = UIColorWithFloat(49);
        picDesLabel.font = [UIFont systemFontOfSize:13];
        picDesLabel.text = @"图片:";
        picDesLabel.x = 15;
        picDesLabel.y = CGRectGetMaxY(lineThree.frame) + 15;
        picDesLabel.height = 15;
        picDesLabel.width = 100;
        [self.mainScrollView addSubview:picDesLabel];
        CGFloat padding = 15;
        int i = 0;
        CGFloat width = (self.view.width - 5 * padding) / 4;
        CGFloat height = 100;
        for (NSString *picUrl in self.detailModel.photoUrls) {
            UIImageView *picImagView = [[UIImageView alloc] init];
            [picImagView sd_setImageWithURL:[NSURL URLWithString:picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (image == nil) {
                    [MBProgressHUD showError:@"加载图片失败" toView:self.mainScrollView];
                }
            }];//加载图片
            picImagView.x = padding + (padding + width) * i;
            picImagView.y = CGRectGetMaxY(picDesLabel.frame) + 10;
            picImagView.width = width;
            picImagView.height = height;
            [self.mainScrollView addSubview:picImagView];
            i ++;
        }
        UIView *lineFour = [[UIView alloc] init];
        lineFour.backgroundColor = UIColorWithFloat(239);
        lineFour.x = 0;
        lineFour.height = 1;
        lineFour.width = self.view.width;
        if (self.detailModel.photoUrls.count == 0) {
            lineFour.y = CGRectGetMaxY(picDesLabel.frame) + 15;
        }else{
            lineFour.y = CGRectGetMaxY(picDesLabel.frame) + height + 10 + padding;
        }
        [self.mainScrollView addSubview:lineFour];
        UILabel *submitTimeLabel = [[UILabel alloc] init];
        submitTimeLabel.textColor = UIColorWithFloat(49);
        submitTimeLabel.font = [UIFont systemFontOfSize:13];
        WorkFlowApprovModel *model = self.approvModels.firstObject;
        submitTimeLabel.text = [NSString stringWithFormat:@"时间:  %@",model.submittimeStrin];
        submitTimeLabel.x = 15;
        submitTimeLabel.y = CGRectGetMaxY(lineFour.frame) + 15;
        submitTimeLabel.height = 15;
        submitTimeLabel.width = 200;
        [self.mainScrollView addSubview:submitTimeLabel];
        UIView *lineFive = [[UIView alloc] init];
        lineFive.backgroundColor = UIColorWithFloat(239);
        lineFive.x = 0;
        lineFive.height = 1;
        lineFive.width = self.view.width;
        lineFive.y = CGRectGetMaxY(submitTimeLabel.frame) + 15;
        [self.mainScrollView addSubview:lineFive];
        
        self.footerView.y = CGRectGetMaxY(lineFive.frame);
    }
    self.footerView.models = self.approvModels;
    self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.footerView.frame) + 30);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - setter && getter

- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.backgroundColor = WhiteColor;
        _mainScrollView.showsVerticalScrollIndicator = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _mainScrollView;
}

- (WorkFlowDetailFooterView *)footerView{
    if (_footerView == nil) {
        _footerView = [WorkFlowDetailFooterView workFlowDetailFooterView];
    }
    return _footerView;
}


@end
