//
//  WorkFlowAddController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/22.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowAddController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"
#import "LeaveView.h"
#import <Masonry.h>
#import "HttpClient+DutyEvents.h"
#import "CGXPickerView.h"
#import "CGXStringPickerView.h"
#import "NextStepModel.h"

@interface WorkFlowAddController ()<NotificationBarDelegate,LeaveViewDelegate>

@property (nonatomic, strong)  NotificationBar *topBar;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) NSArray *chidViews;

@property (nonatomic, strong) NSDictionary *qjDict;
@property (nonatomic, copy) NSString *currentApprvoId;
@property (nonatomic, copy) NSString *stepName;
@property (nonatomic, assign) NSString *eventId;
@property (nonatomic, assign) long long startTime;
@property (nonatomic, assign) long long endTime;

@end

@implementation WorkFlowAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起流程";
    [self.view addSubview:self.topBar];
    LeaveView *leaveView = [LeaveView leaveView];
    leaveView.delegate = self;
    self.currentView = leaveView;
    [self setNetWorkRequest];
    [self setupSubViews];
}

- (void)setNetWorkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToQueryNextStepApprvoPersonWithFlowType:@"1" andEventId:@"0" andFlowTaskId:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        ZXHIDE_LOADING;
        if (code == 0) {
            NSArray *datas = data[@"eventflownextstep"];
            self.qjDict = [NextStepModel nextStepDictWithSource_arr:datas];
        }else{
            if (message.length != 0) {
                [MBProgressHUD showError:message];
            }else{
                [MBProgressHUD showError:@"请求异常，请稍后再试"];
            }
        }
    }];
}

- (void)setupSubViews{
     __weak typeof(self)  weakself = self;
    [self.view addSubview:self.currentView];
    [self.currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
}

#pragma mark - delegateMethod

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    
}

- (void)leaveViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn{
    switch (index) {
        case 0://点击类型按钮
            [self showStringPickViewWithFbtn:btn];
            break;
        case 1://选择开始时间
            [self showDateStringPickViewWithFbBtn:btn];
            break;
        case 2://选择结束时间
            [self showDateStringPickViewWithFbBtn:btn];
            break;
        case 3://审批人
            [self showApprovStepAndPersonNameWithBtn:btn];
            break;
        case 4://流程
            [self showFlowStepPickerViewWithBtn:btn];
            break;
        case 6://提交审核
            [self submitApprvo];
            break;
        default:
            
            break;
    }
}

- (void)showStringPickViewWithFbtn:(FButton *)btn{
    NSArray *dataSource = @[@"事假",@"病假",@"带薪假"];
    [CGXPickerView showStringPickerWithTitle:@"请假类型" DataSource:dataSource DefaultSelValue:@"事假" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSString *selectString = (NSString *)selectValue;
        self.eventId = [NSString stringWithFormat:@"%d",[selectRow intValue]];
        [btn setTitle:selectString forState:UIControlStateNormal];
    }];
}

- (void)showFlowStepPickerViewWithBtn:(FButton *)btn{
    self.currentApprvoId = nil;
    [CGXPickerView showStringPickerWithTitle:@"流程" DataSource: self.qjDict.allKeys DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        self.stepName = selectValue;
        [btn setTitle:selectValue forState:UIControlStateNormal];
    }];
}

- (void)showDateStringPickViewWithFbBtn:(FButton *)btn{
    NSString *title = btn.tag == 1?@"开始时间":@"结束时间";
    [CGXPickerView showDatePickerWithTitle:title DateType:UIDatePickerModeDateAndTime DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
        [btn setTitle:selectValue forState:UIControlStateNormal];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date = [formatter dateFromString:selectValue];
        NSTimeInterval time = [date timeIntervalSince1970];
        if (btn.tag == 1) {
            self.startTime = time;
        }else if (btn.tag == 2){
            self.endTime = time;
        }
    }];
}

-  (void)showApprovStepAndPersonNameWithBtn:(FButton *)btn{
    if (self.stepName == nil) {
        [MBProgressHUD showError:@"请先选择流程" toView:self.currentView];
        return;
    }
    NSMutableArray *dataSource = [NSMutableArray array];
    NSArray *arr = self.qjDict[self.stepName];
    for (NextStepModel *model in arr) {
        [dataSource addObject:model.employername];
    }
    [CGXPickerView showStringPickerWithTitle:@"审核人" DataSource:dataSource DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        int index = [selectRow intValue];
        [btn setTitle:selectValue forState:UIControlStateNormal];
        NextStepModel *model = arr[index];
        self.currentApprvoId = [NSString stringWithFormat:@"%d",model.employerid];
    }];
}

- (void)submitApprvo{
    if (self.eventId == nil) {
        [MBProgressHUD showError:@"请选择请假类型" toView:self.currentView];
        return;
    }
    if (self.startTime == 0) {
        [MBProgressHUD showError:@"请选择请开始时间" toView:self.currentView];
        return;
    }
    if (self.endTime == 0) {
        [MBProgressHUD showError:@"请选择结束时间" toView:self.currentView];
        return;
    }
    if (self.endTime < self.startTime) {
        [MBProgressHUD showError:@"结束时间不能早于开始时间" toView:self.currentView];
        return;
    }
    if (self.currentApprvoId == nil) {
        [MBProgressHUD showError:@"请选择审核人" toView:self.currentView];
        return;
    }
    LeaveView *view = (LeaveView *)self.currentView;
    [HttpClient zx_httpClientToSubmitDutyEventWithEventType:self.eventId andBeginTime:self.startTime andEndTime:self.endTime andEventName:@"" andEventMark:view.reasonTextView.text andPhotoUrl:nil andSubmitto:self.currentApprvoId andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
        
        }
    }];
    
}

#pragma mark - setter & getter
- (NotificationBar *)topBar{
    if (_topBar == nil) {
        _topBar = [NotificationBar notificationBarWithItems:@[@"请假",@"出差",@"报销",@"呈报"] andFrame: CGRectMake(0, 0, self.view.width, 50)];
        _topBar.delegate = self;
    }
    return _topBar;
}

@end
