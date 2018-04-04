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
#import "EvectionView.h"
#import "ReimbursementView.h"
#import "ReportView.h"
#import <Masonry.h>
#import "HttpClient+DutyEvents.h"
#import "CGXPickerView.h"
#import "CGXStringPickerView.h"
#import "NextStepModel.h"
#import "HttpClient+UploadFile.h"


@interface WorkFlowAddController ()<NotificationBarDelegate,LeaveViewDelegate,EvectionViewDelegate,ReimbursementViewDelegate,ReportViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)  NotificationBar *topBar;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) NSMutableArray *chidViews;

@property (nonatomic, strong) NSDictionary *qjDict;
@property (nonatomic, strong) NSMutableDictionary *apprvoIdCache;
@property (nonatomic, strong) NSMutableDictionary *stepNameCache;
@property (nonatomic, strong) NSMutableDictionary *eventIdCache;
@property (nonatomic, strong) NSMutableDictionary *startTimeCache;
@property (nonatomic, strong) NSMutableDictionary *endTimeCache;


@property (nonatomic, assign) int currentIndex;//当前view标志

@property (nonatomic, strong) NSArray *transTools;//交通工具
@property (nonatomic, copy) NSString *transModeId;//交通工具id


@property (nonatomic, strong) NSArray *fees;//报销费用类型
@property (nonatomic, copy) NSString *feeTypeid;//报销类型id

@property (nonatomic, strong) NSArray *reports;//报告类型
@property (nonatomic, copy) NSString *reportTypeid;//报告类型id

@end

@implementation WorkFlowAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起流程";
    self.currentIndex = 0;
    [self.view addSubview:self.topBar];
    [self setNetWorkRequest];
    [self setChidViews];
    [self setupSubViews];
}


- (void)setChidViews{
    LeaveView *leaveView =  [LeaveView leaveView];
    leaveView.delegate = self;
    self.currentView = leaveView;
    [self.chidViews addObject:leaveView];
    EvectionView *evectionView = [EvectionView evectionView];
    evectionView.delegate = self;
    [self.chidViews addObject:evectionView];
    ReimbursementView *reimbursementView =  [ReimbursementView reimbursementView];
    reimbursementView.delegate = self;
    [self.chidViews addObject:reimbursementView];
    ReportView *reportView= [ReportView reportView];
    reportView.delegate = self;
    [self.chidViews addObject:reportView];
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
    [HttpClient zx_httpClientToQueryDictWithDataType:BUSITRAVEL_TRANSMODE andDataCode:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            self.transTools = data[@"getdictionarydata"];
            NSLog(@"transTool = %@",self.transTools);
        }
    }];
    [HttpClient zx_httpClientToQueryDictWithDataType:FEE_TYPE andDataCode:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            self.fees = data[@"getdictionarydata"];
            for (NSDictionary *dict in self.fees) {
                NSLog(@"feeName = %@",dict[@"dataname"]);
            }
        }
    }];
    [HttpClient zx_httpClientToQueryDictWithDataType:REPORT_TYPE andDataCode:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            self.reports = data[@"getdictionarydata"];
            for (NSDictionary *dict in self.reports) {
                NSLog(@"reportTypename = %@",dict[@"dataname"]);
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
     __weak typeof(self)  weakself = self;
    if (index == self.currentIndex) {
        return;
    }
    self.currentIndex = (int)index;
    [self.currentView removeFromSuperview];
    self.currentView = self.chidViews[index];
    [self.view addSubview:self.currentView];
    [self.currentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
}

- (void)leaveViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn{
    LeaveView *leaveView = (LeaveView *)view;
    [leaveView.timeField resignFirstResponder];
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
        case 5://保存
            [self saveData];
            break;
        case 6://提交审核
            [self submitApprvo];
            break;
        default:
            
            break;
    }
}

//出差
- (void)evectionViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn{
    EvectionView *evctionView = (EvectionView *)view;
    [evctionView.desPlaceField resignFirstResponder];
    [evctionView.placeField resignFirstResponder];
    [evctionView.reasonLabel resignFirstResponder];
    switch (index) {
        case 1://开始时间
            [self showDateStringPickViewWithFbBtn:btn];
            break;
        case 2://结束时间
            [self showDateStringPickViewWithFbBtn:btn];
            break;
        case 3://交通工具
            [self businessTransModeWithBtn:btn];
            break;
        case 4://流程
            [self showFlowStepPickerViewWithBtn:btn];
            break;
        case 5://审核人
            [self showApprovStepAndPersonNameWithBtn:btn];
            break;
        case 6:
            [self saveData];
            break;
        case 7://提交
            [self submitApprvo];
        default:
            break;
    }
}

- (void)reimbursementViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn{
    ReimbursementView *reimView = (ReimbursementView *)view;
    [reimView.payCountField resignFirstResponder];
    [reimView.resonTextView resignFirstResponder];
    switch (index) {
        case 0://报销类型
            [self feetypeWithBtn:btn];
            break;
        case 3://流程
            [self showFlowStepPickerViewWithBtn:btn];
            break;
        case 4://审核人
            [self showApprovStepAndPersonNameWithBtn:btn];
            break;
        case 6:
            [self saveData];
            break;
        case 7://提交
            [self submitApprvo];
            break;
        default:
            break;
    }
}

- (void)reportViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn{
    ReportView *reportView = (ReportView *)view;
    [reportView.contentTextView resignFirstResponder];
    switch (index) {
        case 0://报销类型
            [self reportTypeWithBtn:btn];
            break;
        case 3://流程
            [self showFlowStepPickerViewWithBtn:btn];
            break;
        case 4://审核人
            [self showApprovStepAndPersonNameWithBtn:btn];
            break;
        case 6:
            [self saveData];
            break;
        case 7://提交
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
        [self.eventIdCache setObject:[NSString stringWithFormat:@"%d",[selectRow intValue]] forKey:@(self.currentIndex)];
        [btn setTitle:selectString forState:UIControlStateNormal];
    }];
}

- (void)showFlowStepPickerViewWithBtn:(FButton *)btn{
    [self.apprvoIdCache setObject:@"" forKey:@(self.currentIndex)];
    [CGXPickerView showStringPickerWithTitle:@"流程" DataSource: self.qjDict.allKeys DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        [self.stepNameCache setObject:selectValue forKey:@(self.currentIndex)];
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
            [self.startTimeCache setObject:@(time) forKey:@(self.currentIndex)];
            NSTimeInterval endTime = [[self.endTimeCache objectForKey:@(self.currentIndex)] longLongValue];
            if (endTime == 0) {
                endTime = [[NSDate date] timeIntervalSince1970];
            }
            if (time > endTime) {
                [MBProgressHUD showError:@"结束时间不能小于开始时间" toView:self.view];
            }else{
                long chaTime = endTime - time;
                float h = chaTime /  3600.0;
                if (self.currentIndex == 0) {
                    LeaveView *view = (LeaveView *)self.currentView;
                    view.timeField.text = [NSString stringWithFormat:@"%.1f",h];
                }
            }
            [self.startTimeCache setObject:@(time) forKey:@(self.currentIndex)];
        }else if (btn.tag == 2){
            NSTimeInterval startTime = [[self.startTimeCache objectForKey:@(self.currentIndex)] longLongValue];
            if (startTime == 0) {
                startTime = [[NSDate date] timeIntervalSince1970];
            }
            if (time < startTime) {
                [MBProgressHUD showError:@"结束时间不能小于开始时间" toView:self.view];
            }else{
                long chaTime = time - startTime;
                float h = chaTime /  3600.0;
                if (self.currentIndex == 0) {
                    LeaveView *view = (LeaveView *)self.currentView;
                    view.timeField.text = [NSString stringWithFormat:@"%.1f",h];
                }
            }
            [self.endTimeCache setObject:@(time) forKey:@(self.currentIndex)];
        }
    }];
}

-  (void)showApprovStepAndPersonNameWithBtn:(FButton *)btn{
    if ([[self.stepNameCache objectForKey:@(self.currentIndex)] isEqualToString:@""] || [self.stepNameCache objectForKey:@(self.currentIndex)] == nil) {
        [MBProgressHUD showError:@"请先选择流程" toView:self.currentView];
        return;
    }
    NSMutableArray *dataSource = [NSMutableArray array];
    NSString *stepName = [self.stepNameCache objectForKey:@(self.currentIndex)];
    NSArray *arr = self.qjDict[stepName];
    for (NextStepModel *model in arr) {
        [dataSource addObject:model.employername];
    }
    [CGXPickerView showStringPickerWithTitle:@"审核人" DataSource:dataSource DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        int index = [selectRow intValue];
        [btn setTitle:selectValue forState:UIControlStateNormal];
        NextStepModel *model = arr[index];
        [self.apprvoIdCache setObject:[NSString stringWithFormat:@"%d",model.employerid] forKey:@(self.currentIndex)];
    }];
}

- (void)businessTransModeWithBtn:(FButton *)btn{
    NSMutableArray *dataSource_tem = [NSMutableArray array];
    for (NSDictionary *dict in self.transTools) {
        NSString *transName = dict[@"dataname"];
        [dataSource_tem addObject:transName];
    }
    [CGXPickerView showStringPickerWithTitle:@"交通工具" DataSource:dataSource_tem DefaultSelValue:@"事假" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSString *selectString = (NSString *)selectValue;
        int index = [selectRow intValue];
        NSDictionary *dict = self.transTools[index];
        self.transModeId =  dict[@"datacode"];
        [btn setTitle:selectString forState:UIControlStateNormal];
    }];
}

- (void)feetypeWithBtn:(FButton *)btn{
    NSMutableArray *dataSource_tem = [NSMutableArray array];
    for (NSDictionary *dict in self.fees) {
        NSString *transName = dict[@"dataname"];
        [dataSource_tem addObject:transName];
    }
    [CGXPickerView showStringPickerWithTitle:@"费用类型" DataSource:dataSource_tem DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSString *selectString = (NSString *)selectValue;
        int index = [selectRow intValue];
        NSDictionary *dict = self.transTools[index];
        self.feeTypeid =  dict[@"datacode"];
        [btn setTitle:selectString forState:UIControlStateNormal];
    }];
}

- (void)reportTypeWithBtn:(FButton *)btn{
    NSMutableArray *dataSource_tem = [NSMutableArray array];
    for (NSDictionary *dict in self.reports) {
        NSString *transName = dict[@"dataname"];
        [dataSource_tem addObject:transName];
    }
    [CGXPickerView showStringPickerWithTitle:@"呈报类型" DataSource:dataSource_tem DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSString *selectString = (NSString *)selectValue;
        int index = [selectRow intValue];
        NSDictionary *dict = self.reports[index];
        self.reportTypeid =  dict[@"datacode"];
        [btn setTitle:selectString forState:UIControlStateNormal];
    }];
}

- (void)saveData{
    if (self.currentIndex == 0) {
        LeaveView *view = (LeaveView *)self.currentView;
        [HttpClient zx_httpClientToSubmitDutyEventWithEventType:[self.eventIdCache objectForKey:@(self.currentIndex)]    andBeginTime:[[self.startTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0  andEndTime:[[self.endTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0  andEventName:@"请假" andEventMark:view.reasonTextView.text andPhotoUrl:@"" andSubmitto:@""  andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                [MBProgressHUD showError:@"保存成功" toView:self.view];
               [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }else{
                    [MBProgressHUD showError:@"请求出错" toView:self.view];
                }
            }
        }];
    }else if (self.currentIndex == 1){
        EvectionView *view = (EvectionView *)self.currentView;
        [HttpClient zx_httpClientToSubmitEvectionEventWithEventName:@"出差" andEventMark:view.reasonLabel.text andFromcity:view.placeField.text andToCity:view.desPlaceField.text andBeginTime:[[self.startTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0   andEndTime:[[self.endTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0 andTransmode:self.transModeId andSubmitto:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                [MBProgressHUD showError:@"保存成功" toView:self.view];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }else{
                    [MBProgressHUD showError:@"请求出错" toView:self.view];
                }
            }
        }];
    }else if (self.currentIndex == 2){
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *now = [NSDate date];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
        NSDate *startDate = [calendar dateFromComponents:components];
        NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
        ReimbursementView *view = (ReimbursementView *)self.currentView;
        [HttpClient zx_httpClientToSubmitReimentEventWithFeetype:self.feeTypeid andBeginTime:[startDate timeIntervalSince1970]*1000 andEndTime:[endDate timeIntervalSince1970]*1000 andFeemoney:view.payCountField.text andEventName:@"报销" andEventMark:view.resonTextView.text andPhotoUrl:@"" andSubmitto:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            ZXHIDE_LOADING;
            if (code == 0) {
                [MBProgressHUD showError:@"提交成功" toView:self.view];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }else{
                    [MBProgressHUD showError:@"请求出错" toView:self.view];
                }
            }
        }];
        
    }else if (self.currentIndex == 3){
        ReportView *view = (ReportView *)self.currentView;
        [HttpClient zx_httpClientToSubmitReportWithReportType:self.reportTypeid andEventName:@"" andEventMark:view.contentTextView.text andPhotoUrl:@"" andSubmitto:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            ZXHIDE_LOADING;
            if (code == 0) {
                [MBProgressHUD showError:@"提交成功" toView:self.view];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }else{
                    [MBProgressHUD showError:@"请求出错" toView:self.view];
                }
            }
        }];
    }
}

- (void)submitApprvo{
    if (self.currentIndex == 0) {//请假
        if ([self.eventIdCache objectForKey:@(self.currentIndex)] == nil || [[self.eventIdCache objectForKey:@(self.currentIndex)]  isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择请假类型" toView:self.currentView];
            return;
        }
        if ([[self.startTimeCache objectForKey:@(self.currentIndex)] intValue] == 0 || [self.startTimeCache objectForKey:@(self.currentIndex)] == nil) {
            [MBProgressHUD showError:@"请选择请开始时间" toView:self.currentView];
            return;
        }
        if ([[self.endTimeCache objectForKey:@(self.currentIndex)] intValue] == 0 || [self.endTimeCache objectForKey:@(self.currentIndex)] == nil) {
            [MBProgressHUD showError:@"请选择结束时间" toView:self.currentView];
            return;
        }
        if ([[self.endTimeCache objectForKey:@(self.currentIndex)] intValue] < [[self.startTimeCache objectForKey:@(self.currentIndex)] intValue] ) {
            [MBProgressHUD showError:@"结束时间不能早于开始时间" toView:self.currentView];
            return;
        }
        if ([self.apprvoIdCache objectForKey:@(self.currentIndex)] == nil || [[self.apprvoIdCache objectForKey:@(self.currentIndex)]  isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择审核人" toView:self.currentView];
            return;
        }
        LeaveView *view = (LeaveView *)self.currentView;
        [HttpClient zx_httpClientToSubmitDutyEventWithEventType:[self.eventIdCache objectForKey:@(self.currentIndex)]    andBeginTime:[[self.startTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0  andEndTime:[[self.endTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0  andEventName:@"请假" andEventMark:view.reasonTextView.text andPhotoUrl:@"" andSubmitto:[self.apprvoIdCache objectForKey:@(self.currentIndex)]  andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                [MBProgressHUD showError:@"提交成功" toView:self.view];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }else{
                    [MBProgressHUD showError:@"请求出错" toView:self.view];
                }
            }
        }];
    }else if (self.currentIndex == 1){//出差
        EvectionView *view = (EvectionView *)self.currentView;
        if (view.placeField.text.length == 0) {
            [MBProgressHUD showError:@"请填写出发地" toView:self.currentView];
            return;
        }
        if (view.desPlaceLabel.text.length == 0) {
            [MBProgressHUD showError:@"请填写目的地" toView:self.currentView];
            return;
        }
        if ([[self.startTimeCache objectForKey:@(self.currentIndex)] intValue] == 0 || [self.startTimeCache objectForKey:@(self.currentIndex)] == nil) {
            [MBProgressHUD showError:@"请选择请开始时间" toView:self.currentView];
            return;
        }
        if ([[self.endTimeCache objectForKey:@(self.currentIndex)] intValue] == 0 || [self.endTimeCache objectForKey:@(self.currentIndex)] == nil) {
            [MBProgressHUD showError:@"请选择结束时间" toView:self.currentView];
            return;
        }
        if ([[self.endTimeCache objectForKey:@(self.currentIndex)] intValue] < [[self.startTimeCache objectForKey:@(self.currentIndex)] intValue] ) {
            [MBProgressHUD showError:@"结束时间不能早于开始时间" toView:self.currentView];
            return;
        }
        if (self.transModeId == nil || [self.transModeId isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择交通工具" toView:self.currentView];
            return;
        }
        if ([self.apprvoIdCache objectForKey:@(self.currentIndex)] == nil || [[self.apprvoIdCache objectForKey:@(self.currentIndex)]  isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择审核人" toView:self.currentView];
            return;
        }
        [HttpClient zx_httpClientToSubmitEvectionEventWithEventName:@"出差" andEventMark:view.reasonLabel.text andFromcity:view.placeField.text andToCity:view.desPlaceField.text andBeginTime:[[self.startTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0   andEndTime:[[self.endTimeCache objectForKey:@(self.currentIndex)] longLongValue]*1000.0 andTransmode:self.transModeId andSubmitto:[self.apprvoIdCache objectForKey:@(self.currentIndex)] andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                [MBProgressHUD showError:@"提交成功" toView:self.view];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }else{
                    [MBProgressHUD showError:@"请求出错" toView:self.view];
                }
            }
        }];
    }else if (self.currentIndex == 2){//报销
        ReimbursementView *view = (ReimbursementView *)self.currentView;
        if (view.payCountField.text == 0) {
            [MBProgressHUD showError:@"请填写报销金额" toView:self.view];
            return;
        }
        if (self.feeTypeid == nil || [self.feeTypeid isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择报销类别" toView:self.view];
            return;
        }
        if ([self.apprvoIdCache objectForKey:@(self.currentIndex)] == nil || [[self.apprvoIdCache objectForKey:@(self.currentIndex)]  isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择审核人" toView:self.currentView];
            return;
        }
        NSArray *pickImages = [view returnPickImages];
        // 调度组
        dispatch_group_t group = dispatch_group_create();
        // 队列
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        if (pickImages.count != 0) {
            ZXSHOW_LOADING(self.view, @"上传图片...")
        }
        NSMutableString *temStr = [NSMutableString string];//拼接照片url
        for (UIImage *image in pickImages) {
            dispatch_group_enter(group);
            NSData *data =  UIImageJPEGRepresentation(image, 1);
            dispatch_group_async(group, queue, ^{
                [HttpClient zx_httpClientToUploadFileWithData:data andType:UploadFileTypePhoto andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                    if (code == 0) {
                        NSDictionary *dict = (NSDictionary *)data;
                        NSString *url = dict[@"url"];
                        [temStr appendString:[NSString stringWithFormat:@"%@|",url]];
                    }
                    dispatch_group_leave(group);
                }];
            });
        }
        dispatch_queue_t mQueue = dispatch_get_main_queue();
        dispatch_group_notify(group, mQueue, ^{//照片上传完提交审核
            ZXHIDE_LOADING;
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *now = [NSDate date];
            NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
            NSDate *startDate = [calendar dateFromComponents:components];
            NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
            ZXSHOW_LOADING(self.view, @"提交中...");
            if (temStr.length != 0) {
                [temStr replaceCharactersInRange:NSMakeRange(temStr.length - 1, 1) withString:@""];//去掉最后一个|符号
            }
            [HttpClient zx_httpClientToSubmitReimentEventWithFeetype:self.feeTypeid andBeginTime:[startDate timeIntervalSince1970]*1000 andEndTime:[endDate timeIntervalSince1970]*1000 andFeemoney:view.payCountField.text andEventName:@"报销" andEventMark:view.resonTextView.text andPhotoUrl:temStr andSubmitto:[self.apprvoIdCache objectForKey:@(self.currentIndex)] andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                ZXHIDE_LOADING;
                if (code == 0) {
                    [MBProgressHUD showError:@"提交成功" toView:self.view];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
                }else{
                    if (message.length != 0) {
                        [MBProgressHUD showError:message toView:self.view];
                    }else{
                        [MBProgressHUD showError:@"请求出错" toView:self.view];
                    }
                }
            }];
        });
    }else if (self.currentIndex == 3){//呈报
        ReportView *view = (ReportView *)self.currentView;
        if (self.reportTypeid == nil || [self.reportTypeid isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择呈报类型" toView:self.view];
            return;
        }
        if (view.contentTextView.text.length == 0) {
            [MBProgressHUD showError:@"请填写呈报内容" toView:self.view];
            return;
        }
        if ([self.apprvoIdCache objectForKey:@(self.currentIndex)] == nil || [[self.apprvoIdCache objectForKey:@(self.currentIndex)]  isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择审核人" toView:self.currentView];
            return;
        }
        NSArray *pickImages = [view returnPickImages];
        // 调度组
        dispatch_group_t group = dispatch_group_create();
        // 队列
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        if (pickImages.count != 0) {
            ZXSHOW_LOADING(self.view, @"上传图片...")
        }
        NSMutableString *temStr = [NSMutableString string];//拼接照片url
        for (UIImage *image in pickImages) {
            dispatch_group_enter(group);
            NSData *data =  UIImageJPEGRepresentation(image, 1);
            dispatch_group_async(group, queue, ^{
                [HttpClient zx_httpClientToUploadFileWithData:data andType:UploadFileTypePhoto andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                    if (code == 0) {
                        NSDictionary *dict = (NSDictionary *)data;
                        NSString *url = dict[@"url"];
                        [temStr appendString:[NSString stringWithFormat:@"%@|",url]];
                    }
                    dispatch_group_leave(group);
                }];
            });
        }
        dispatch_queue_t mQueue = dispatch_get_main_queue();
        dispatch_group_notify(group, mQueue, ^{//照片上传完提交审核
            ZXHIDE_LOADING;
            ZXSHOW_LOADING(self.view, @"提交中...");
            if (temStr.length != 0) {
                [temStr replaceCharactersInRange:NSMakeRange(temStr.length - 1, 1) withString:@""];//去掉最后一个|符号
            }
            [HttpClient zx_httpClientToSubmitReportWithReportType:self.reportTypeid andEventName:@"" andEventMark:view.contentTextView.text andPhotoUrl:temStr andSubmitto:[self.apprvoIdCache objectForKey:@(self.currentIndex)]  andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                ZXHIDE_LOADING;
                if (code == 0) {
                    [MBProgressHUD showError:@"提交成功" toView:self.view];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKFLOWRELOADDATA object:nil];
                    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
                }else{
                    if (message.length != 0) {
                        [MBProgressHUD showError:message toView:self.view];
                    }else{
                        [MBProgressHUD showError:@"请求出错" toView:self.view];
                    }
                }

            }];
        });
       
    }
}

- (void)remibursementPickImage{
    UIAlertController *alterVc = [UIAlertController alertControllerWithTitle:@"选择" message:@"请选择获取照片的方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
    pickVc.delegate = self;
    UIAlertAction *alterAction_0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickVc.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickVc animated:YES completion:nil];
        }
    }];
    UIAlertAction *alterAction_1 = [UIAlertAction actionWithTitle:@"从相册中获取照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:pickVc animated:YES completion:nil];
        }
    }];
    UIAlertAction *alterAction_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alterVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [alterVc addAction:alterAction_0];
    [alterVc addAction:alterAction_1];
    [alterVc addAction:alterAction_2];
    [self presentViewController:alterVc animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.currentIndex == 2) {//报销照片
        ReimbursementView *view = (ReimbursementView *)self.currentView;
        [view getPickImage:image];
    }else if (self.currentIndex == 3){
        ReportView *view = (ReportView *)self.currentView;
        [view getPickImage:image];
    }
}

#pragma mark - setter & getter
- (NotificationBar *)topBar{
    if (_topBar == nil) {
        _topBar = [NotificationBar notificationBarWithItems:@[@"请假",@"出差",@"报销",@"呈报"] andFrame: CGRectMake(0, 0, self.view.width, 50)];
        _topBar.delegate = self;
    }
    return _topBar;
}

- (NSMutableArray *)chidViews{
    if (_chidViews == nil) {
        _chidViews = [NSMutableArray array];
    }
    return _chidViews;
}

- (NSArray *)transTools{
    if (_transTools == nil) {
        _transTools = @[@{
                            @"dataname":@"火车",
                            @"datacode":@"1"
                            },
                        @{
                            @"dataname":@"自驾",
                            @"datacode":@"5"
                          },
                        @{
                            @"dataname":@"高铁",
                            @"datacode":@"2"
                            },
                        @{
                            @"dataname":@"飞机",
                            @"datacode":@"3"
                            },
                        @{
                            @"dataname":@"汽车",
                            @"datacode":@"4"
                            }
                        ];
    }
    return _transTools;
}

- (NSArray *)fees{
    if (_fees == nil) {
        _fees = @[@{
                            @"dataname":@"招待费",
                            @"datacode":@"1"
                            },
                        @{
                            @"dataname":@"办公费",
                            @"datacode":@"2"
                            },
                        @{
                            @"dataname":@"防暑降温补贴",
                            @"datacode":@"3"
                            }
                        ];
    }
    return _fees;
}

- (NSArray *)reports{
    if (_reports == nil) {
        _reports = @[@{
                      @"dataname":@"公文呈报",
                      @"datacode":@"1"
                      },
                  @{
                      @"dataname":@"发文呈报",
                      @"datacode":@"2"
                      }
                  ];
    }
    return _reports;
}

- (NSMutableDictionary *)stepNameCache{
    if (_stepNameCache == nil) {
        _stepNameCache = [NSMutableDictionary dictionary];
    }
    return _stepNameCache;
}

- (NSMutableDictionary *)apprvoIdCache{
    if (_apprvoIdCache == nil) {
        _apprvoIdCache = [NSMutableDictionary dictionary];
    }
    return _apprvoIdCache;
}

- (NSMutableDictionary *)eventIdCache{
    if (_eventIdCache == nil) {
        _eventIdCache = [NSMutableDictionary dictionary];
    }
    return _eventIdCache;
}

- (NSMutableDictionary *)startTimeCache{
    if (_startTimeCache == nil) {
        _startTimeCache = [NSMutableDictionary dictionary];
    }
    return _startTimeCache;
}

- (NSMutableDictionary *)endTimeCache{
    if (_endTimeCache == nil) {
        _endTimeCache = [NSMutableDictionary dictionary];
    }
    return _endTimeCache;
}

@end
