//
//  AttendanceController.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttendanceController.h"
#import "AttenceHeaderView.h"
#import "GobHeaderFile.h"
#import "FButton.h"
#import <Masonry.h>
#import "AttenceTimeView.h"
#import "AttenceDKController.h"
#import "HttpClient+DutyEvents.h"
#import "AttDutySettingModel.h"
#import "UserLocationManager.h"
#import "AttDutyCheckModel.h"
#import "AttenceCheckView.h"
#import "AttenceRecoderController.h"
#import "HttpClient+UploadFile.h"

@interface AttendanceController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) AttenceHeaderView *headerView;
@property (nonatomic, strong) FButton *workBtn;
@property (nonatomic, strong) FButton *offBtn;
@property (nonatomic, strong) UIView *oneLineView;

@property (nonatomic, assign) int clickTag;

@property (nonatomic, strong) UITableView *recoderTable;

@property (nonatomic, strong) NSArray *attDutySettingModels;
@property (nonatomic, strong) NSArray *attDutyCheckModels;

@end

@implementation AttendanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考勤打卡";
    self.clickTag = -1;
    [self setNetworkRequest];
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSString *dateString = [formatter stringFromDate:date];
        [HttpClient zx_httpClientToQueryDutyRuleWithWorkDateFormatter:dateString andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"dutysetting"];
                self.attDutySettingModels = [AttDutySettingModel attDutySettingModelsWithSource_arr:datas];
            }
             dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *now = [NSDate date];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
        NSDate *startDate = [calendar dateFromComponents:components];
        NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
        [HttpClient zx_httpClientToQueryProjectDutyWithBeginTime:[startDate timeIntervalSince1970] * 1000.0 andEndTime:[endDate timeIntervalSince1970] * 1000.0 andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"dutystatis"];
                self.attDutyCheckModels = [AttDutyCheckModel attdutyCheckModelsWithSource_arr:datas];
                AttDutyCheckModel *model = self.attDutyCheckModels.lastObject;
                NSLog(@"model.SettingName = %@",model.settingname);
            }
            dispatch_group_leave(group);
        }];
    });
    // 异步 : 调度组中的所有异步任务执行结束之后,在这里得到统一的通知
    dispatch_queue_t mQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mQueue, ^{
        ZXHIDE_LOADING;
        [self setUpSubViews];
    });
}

- (void)setUpSubViews{
    __weak typeof(self) weakself = self;
    [self.view addSubview:self.headerView];
    CGFloat height = CGRectGetMaxY(self.headerView.frame);
    int i = 0;
    CGFloat mpadding = 12;
    for (AttDutySettingModel *model in self.attDutySettingModels) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%@: %@-%@",model.settingname,model.begintimeString,model.endtimeString];
        label.textColor = UIColorWithFloat(110);
        label.font = [UIFont systemFontOfSize:13];
        label.x = 15;
        label.width = self.view.width - 30;
        label.height = 18;
        label.y = height + mpadding + i * (label.height + 2 * mpadding - 2);
        [self.view addSubview:label];
        i ++;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorWithFloat(239);
        lineView.frame = CGRectMake(0, CGRectGetMaxY(label.frame) + mpadding - 1, self.view.width, 1);
        [self.view addSubview:lineView];
    }
    [self.view addSubview:self.workBtn];
    [self.view addSubview:self.offBtn];
    [self.view addSubview:self.oneLineView];
    [self.view addSubview:self.recoderTable];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.view.mas_top);
        make.height.mas_equalTo(130);
    }];
    CGFloat width = 85;
    CGFloat padding = (self.view.width - width * 2 - 45)*0.5;
    [self.workBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(padding);
        make.top.equalTo(weakself.headerView.mas_bottom).offset(self.attDutySettingModels.count * 42 + 20);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    [self.offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-padding);
        make.top.equalTo(weakself.headerView.mas_bottom).offset(self.attDutySettingModels.count * 42 + 20);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    [self.oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.workBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(1);
    }];
    CGFloat tableHeight = self.attDutyCheckModels.count * 70;
    if (tableHeight > 210) {
        tableHeight = 210;
    }
    [self.recoderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.oneLineView.mas_bottom);
        make.height.mas_equalTo(tableHeight);
    }];
}

- (void)refreshCheckData{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    [HttpClient zx_httpClientToQueryProjectDutyWithBeginTime:[startDate timeIntervalSince1970] * 1000.0 andEndTime:[endDate timeIntervalSince1970] * 1000.0 andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"dutystatis"];
            self.attDutyCheckModels = [AttDutyCheckModel attdutyCheckModelsWithSource_arr:datas];
            [self.recoderTable reloadData];
        }else{
            if (message.length != 0) {
                [MBProgressHUD showError:message toView:self.view];
            }
        }
    }];
}

- (void)clickDutyBtn:(UIButton *)btn{
    //是否上传照片;
    self.clickTag = (int)btn.tag;
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"拍照" message:@"是否上传照片" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alterAction_0 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
            pickVc.delegate = self;
            pickVc.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickVc animated:YES completion:nil];
        }
    }];
    UIAlertAction *alterAction_1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZXSHOW_LOADING(self.view, @"获取位置中...");
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            NSString *positionAdress = [NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street];
            [HttpClient zx_httpClientToDutyCheckWithDutytype:[NSString stringWithFormat:@"%zd",btn.tag] andPositionAdress:positionAdress  andPosition:[UserLocationManager sharedUserLocationManager].position andPhotoUrl:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                ZXHIDE_LOADING;
                if (code == 0) {
                    [MBProgressHUD showError:@"打卡成功" toView:self.view];
                    [self refreshCheckData];
                }else{
                    if (message.length != 0) {
                        [MBProgressHUD showError:message toView:self.view];
                    }else{
                        [MBProgressHUD showError:@"请求出错" toView:self.view];
                    }
                }
            }];
        }];
        
    }];
    [alterController addAction:alterAction_0];
    [alterController addAction:alterAction_1];
    [self presentViewController:alterController animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data =  UIImageJPEGRepresentation(image, 1);
    ZXSHOW_LOADING(self.view, @"上传照片...");
    [HttpClient zx_httpClientToUploadFileWithData:data andType:UploadFileTypePhoto andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        ZXHIDE_LOADING;
        if (code == 0) {
            NSDictionary *dict = (NSDictionary *)data;
            NSString *url = dict[@"url"];
            ZXSHOW_LOADING(self.view, @"获取位置中...");
            [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
                NSString *state=[addressDic objectForKey:@"State"];
                NSString *city=[addressDic objectForKey:@"City"];
                NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
                NSString *street=[addressDic objectForKey:@"Street"];
                NSString *positionAdress = [NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street];
                [HttpClient zx_httpClientToDutyCheckWithDutytype:[NSString stringWithFormat:@"%zd",self.clickTag] andPositionAdress:positionAdress  andPosition:[UserLocationManager sharedUserLocationManager].position andPhotoUrl:url andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                    ZXHIDE_LOADING;
                    if (code == 0) {
                        [MBProgressHUD showError:@"打卡成功" toView:self.view];
                        [self refreshCheckData];
                    }else{
                        if (message.length != 0) {
                            [MBProgressHUD showError:message toView:self.view];
                        }else{
                            [MBProgressHUD showError:@"请求出错" toView:self.view];
                        }
                    }
                }];
            }];
        }
    }];
}


#pragma mark - UITableViewDelegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.attDutyCheckModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttenceCheckView *cell = [AttenceCheckView attenceCheckCellWithTableView:tableView];
    cell.model = self.attDutyCheckModels[self.attDutyCheckModels.count -  indexPath.row - 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AttenceRecoderController *vc = [[AttenceRecoderController alloc] init];
    vc.model = self.attDutyCheckModels[self.attDutyCheckModels.count -  indexPath.row - 1];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter && getter

- (AttenceHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [AttenceHeaderView attenceHeaderView];
        __weak typeof(self) weakself = self;
        [_headerView setClickDKBtnBlock:^{
            AttenceDKController *vc = [[AttenceDKController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headerView;
}

- (FButton *)workBtn{
    if (_workBtn == nil) {
        _workBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        _workBtn.backgroundColor = UIColorWithRGB(120, 200, 55);
        [_workBtn setTitle:@"上班" forState:UIControlStateNormal];
        [_workBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _workBtn.layer.cornerRadius = 85*0.5;
        _workBtn.tag = 0;
        [_workBtn addTarget:self action:@selector(clickDutyBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _workBtn;
}

- (FButton *)offBtn{
    if (_offBtn == nil) {
        _offBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_offBtn  setTitle:@"下班" forState:UIControlStateNormal];
        [_offBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _offBtn.backgroundColor =  UIColorWithRGB(120, 200, 55);
        _offBtn.layer.cornerRadius = 85 *0.5;
        _offBtn.tag = 1;
        [_offBtn addTarget:self action:@selector(clickDutyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _offBtn;
}

- (UIView *)oneLineView{
    if (_oneLineView == nil) {
        _oneLineView = [[UIView alloc] init];
        _oneLineView.backgroundColor = UIColorWithRGB(239, 239, 239);
    }
    return _oneLineView;
}

- (UITableView *)recoderTable{
    if (_recoderTable == nil) {
        _recoderTable = [[UITableView alloc] init];
        _recoderTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _recoderTable.backgroundColor = WhiteColor;
        _recoderTable.delegate = self;
        _recoderTable.dataSource = self;
    }
    return _recoderTable;
}


@end
