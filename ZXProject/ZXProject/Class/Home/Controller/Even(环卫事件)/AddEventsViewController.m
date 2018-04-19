//
//  AddEventsViewController.m
//  ZXProject
//
//  Created by Me on 2018/4/15.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AddEventsViewController.h"
#import "workTaskHeaderView.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import "UserLocationManager.h"
#import "HttpClient+WorkTask.h"
#import "WorkTaskDetailModel.h"
#import "CGXPickerView.h"
#import "ProjectManager.h"
#import "UIAlertAction+Attribute.h"
#import "RecordView.h"
#import "MyPositionViewController.h"
#import "ZXRecoderVideoManager.h"
#import "HttpClient+WorkTask.h"
#import "HttpClient+UploadFile.h"



@interface AddEventsViewController ()<workTaskHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RecordViewDelegate>


@property (nonatomic, strong) NSArray *projectRegions;
@property (nonatomic, strong) workTaskHeaderView *headerView;
@property (nonatomic, strong) WorkTaskDetailModel *currentModel;

@property (nonatomic, strong) UILabel *reslovPersonLabel;
@property (nonatomic, strong) FButton *reslovBtn;
@property (nonatomic, strong) UILabel *dutyRegionLabel;
@property (nonatomic, strong) UILabel *dutyPersonLabel;

@property (nonatomic, strong) UILabel *selectedPersonDesLabel;
@property (nonatomic, strong) FButton *selecetedPersonBtn;

@property (nonatomic, strong) UILabel *urgencyDesLabel;
@property (nonatomic, strong) FButton *urgencyBtn;

@property (nonatomic, strong) UILabel *isNeedIvhLabel;
@property (nonatomic, strong) FButton *isNeedIvhBtn;

@property (nonatomic, strong) FButton *selectApprvoBtn;

@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;

@property (nonatomic, strong) UIButton *coverView;
@property (nonatomic, strong) RecordView *recordView;
@property (nonatomic, assign) BOOL hasRecord;

@property (nonatomic, assign) int urgencyType;
@property (nonatomic, assign) int isNeedCarType;
@property (nonatomic, assign) long reslovid;



@end

@implementation AddEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增事件";
    [self setNetworkRequest];
    [self setupSubViews];
    self.urgencyType = 1;
    self.isNeedCarType = 0;
    self.reslovid = 0;
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToGetProjectRegionListWithSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"projectorgregion"];
            self.projectRegions = [WorkTaskDetailModel workTaskDetailModelsWithSource_arr:datas];
            [HttpClient zx_httpClientToGetWorkTaskPointProjectoRgregionWithPosition:[UserLocationManager sharedUserLocationManager].position andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                if (code == 0) {
                    NSDictionary *dict = data[@"projectorgregion"];
                    for (WorkTaskDetailModel *model in self.projectRegions) {
                        if (model.orgid == [dict[@"orgid"] longValue]) {
                            self.currentModel = model;
                            break;
                        }
                    }
                }
                [self setPositionAdress];
            }];
        }
    }];
}

- (void)setPositionAdress{
    if ([UserLocationManager sharedUserLocationManager].positionAdress != nil) {
        ZXHIDE_LOADING;
        self.headerView.positionAdress =  [UserLocationManager sharedUserLocationManager].positionAdress;
    }else{
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            ZXHIDE_LOADING;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            self.headerView.positionAdress = [NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street];
        }];
    }
}

- (void)setupSubViews{
     __weak typeof(self)  weakself = self;
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.backgroundColor = WhiteColor;
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.bounces = NO;
    mainScrollView.userInteractionEnabled = YES;
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = WhiteColor;
    contentView.userInteractionEnabled = YES;
    [mainScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mainScrollView);
        make.width.equalTo(mainScrollView);
    }];
    [contentView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(contentView.mas_top);
        make.height.mas_equalTo(361);
    }];
    [contentView addSubview:self.reslovBtn];
    [contentView addSubview:self.reslovPersonLabel];
    [self.reslovPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.headerView.mas_bottom).offset(15);
    }];
    [self.reslovBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.reslovPersonLabel.mas_right).offset(10);
        make.centerY.equalTo(weakself.reslovPersonLabel.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    UIView *lineTwo = [[UIView alloc] init];
    lineTwo.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(self.reslovPersonLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.dutyRegionLabel];
    [contentView addSubview:self.dutyPersonLabel];
    [self.dutyRegionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(lineTwo.mas_bottom).offset(15);
    }];
    [self.dutyPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-60);
        make.top.equalTo(lineTwo.mas_bottom).offset(15);
    }];
    UIView *lineThree = [[UIView alloc] init];
    lineThree.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineThree];
    [lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(self.dutyRegionLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.selectedPersonDesLabel];
    [self.selectedPersonDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineThree.mas_top).offset(15);
    }];
    [contentView addSubview:self.selecetedPersonBtn];
    [self.selecetedPersonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.selectedPersonDesLabel.mas_right).offset(10);
        make.centerY.equalTo(weakself.selectedPersonDesLabel.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    [contentView addSubview:self.urgencyDesLabel];
    [self.urgencyDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(self.selectedPersonDesLabel.mas_bottom).offset(30);
    }];
    [contentView addSubview:self.urgencyBtn];
    [self.urgencyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.urgencyDesLabel.mas_right).offset(10);
        make.centerY.equalTo(weakself.urgencyDesLabel.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    UILabel *sendsmsLabel = [[UILabel alloc] init];
    sendsmsLabel.textColor = [UIColor redColor];
    sendsmsLabel.text = @"短信通知";
    sendsmsLabel.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:sendsmsLabel];
    [sendsmsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.urgencyBtn.mas_centerY);
    }];
    [contentView addSubview:self.selectApprvoBtn];
    [self.selectApprvoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sendsmsLabel.mas_left).offset(-5);
        make.centerY.equalTo(weakself.urgencyBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18, 16.5));
    }];
    UIView *lineFive = [[UIView alloc] init];
    lineFive.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineFive];
    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(self.urgencyDesLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.isNeedIvhLabel];
    [self.isNeedIvhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineFive.mas_top).offset(15);
    }];
    [contentView addSubview:self.isNeedIvhBtn];
    [self.isNeedIvhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.isNeedIvhLabel.mas_right).offset(10);
        make.centerY.equalTo(weakself.isNeedIvhLabel.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    UIView *lineSix = [[UIView alloc] init];
    lineSix.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineSix];
    [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(self.isNeedIvhLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.submitBtn];
    [contentView addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(60);
        make.top.equalTo(lineSix.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-60);
        make.top.equalTo(lineSix.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.submitBtn.mas_bottom).offset(30);
    }];
}

#pragma mark - WorkTaskAddImageViewDelegateMethod

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.headerView workTaskHeaderViewGetImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)recordViewDidEndRecord{
    [self.recordView removeFromSuperview];
    [self.coverView removeFromSuperview];
    [self.headerView insertVideoPlayViewWithPlayTime:[ZXRecoderVideoManager sharedRecoderManager].videoTime];
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(431);
    }];
    self.hasRecord = YES;
}

#pragma mark - WorkTaskHeaderViewDelegate Method

- (void)workTaskHeaderViewDidClickAtionWithTag:(int)tag andView:(workTaskHeaderView *)view{
    if (tag == 1006) {//录音
        [self clickVoiceBtn];
    }else if (tag == 1007){//位置
        [self clickMapBtn];
    }
}

- (void)workTaskHeaderViewDidTapImagePickView{
    UIAlertController *alterVc = [UIAlertController alertControllerWithTitle:@"选择" message:@"请选择获取照片的方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
    pickVc.delegate = self;
    UIAlertAction *alterAction_0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickVc.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickVc animated:YES completion:nil];
        }
    }];
    UIAlertAction *alterAction_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alterVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [alterAction_0 setTitleColor:UIColorWithFloat(49)];
    [alterAction_2 setTitleColor:UIColorWithRGB(245, 0, 0)];
    [alterVc addAction:alterAction_0];
    [alterVc addAction:alterAction_2];
    [self presentViewController:alterVc animated:YES completion:^{
        
    }];
}

- (void)clickMapBtn{
    MyPositionViewController *vc = [[MyPositionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickVoiceBtn{
    UIButton *coverView = [[UIButton alloc] init];
    self.coverView = coverView;
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    coverView.frame = self.view.bounds;
    [coverView addTarget:self action:@selector(clickCoverBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:coverView];
    CGFloat width = self.view.width * 0.7;
    RecordView *recordView = [RecordView recordViewWithFrame:CGRectMake((self.view.width - width)*0.5,(self.view.height - 300) * 0.5 , width, 300)];
    self.recordView = recordView;
    self.recordView.delegate = self;
    [self.view addSubview:recordView];
}

- (void)clickCoverBtn:(UIButton *)btn{
    [btn removeFromSuperview];
    [self.recordView removeFromSuperview];
}

#pragma mark - ClickAction

- (void)clickAction:(FButton *)btn{
    if (btn.tag == 3) {
        NSMutableArray *arr = [NSMutableArray array];
        for (WorkTaskDetailModel *model in self.projectRegions) {
            [arr addObject:model.orgname];
        }
        [CGXPickerView showStringPickerWithTitle:@"责任区域和责任人" DataSource:arr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            int index = [selectRow intValue];
            WorkTaskDetailModel *model = self.projectRegions[index];
            self.currentModel = model;
            [btn setTitle:model.orgname forState:UIControlStateNormal];
            self.dutyRegionLabel.text = [NSString stringWithFormat:@"责任区:  %@",model.regionname];
            self.dutyPersonLabel.text = [NSString stringWithFormat:@"责任人:  %@",model.employername];
        }];
    }else if (btn.tag == 4){//处理人
        NSMutableArray *arr = [NSMutableArray array];
        for (User *user in [ProjectManager sharedProjectManager].orgContactlist) {
            [arr addObject:user.employername];
        }
        [CGXPickerView showStringPickerWithTitle:@"处理人" DataSource:arr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            int index = [selectRow intValue];
            User *user  = [ProjectManager sharedProjectManager].orgContactlist[index];
            self.reslovid = [user.employerid longLongValue];
            [btn setTitle:user.employername forState:UIControlStateNormal];

        }];
    }else if (btn.tag == 5){
        NSArray *arr = @[@"不紧急",@"紧急"];
        [CGXPickerView showStringPickerWithTitle:@"紧急度" DataSource:arr DefaultSelValue:@"紧急" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            int index = [selectRow intValue];
            NSString *str  = arr[index];
            self.urgencyType = index;
            [btn setTitle:str forState:UIControlStateNormal];
            
        }];
    }else if (btn.tag == 6){
        NSArray *arr = @[@"不需要",@"需要"];
        [CGXPickerView showStringPickerWithTitle:@"是否需要车" DataSource:arr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            int index = [selectRow intValue];
            self.isNeedCarType = index;
            NSString *str  = arr[index];
            [btn setTitle:str forState:UIControlStateNormal];
        }];
    }else if (btn.tag == 7){//提交
        NSArray *pickImages = [self.headerView workTaskHeaderViewGetPickImages];
        if (pickImages.count == 0) {
            [MBProgressHUD showError:@"请添加至少一张照片" toView:self.view];
            return;
        }
        if (self.currentModel == nil) {
            [MBProgressHUD showError:@"请选择责任人和责任区域" toView:self.view];
            return;
        };
        if (self.headerView.textView.text.length == 0) {
            [MBProgressHUD showError:@"请填写说明" toView:self.view];
            return;
        };
        if (self.reslovid == 0) {
            [MBProgressHUD showError:@"请选择处理人" toView:self.view];
            return;
        };
        // 调度组
        dispatch_group_t group = dispatch_group_create();
        // 队列
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        if (pickImages.count != 0) {
            ZXSHOW_LOADING(self.view, @"上传文件中...")
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
        __block NSString *soundUrl = @"";
        if (self.hasRecord) {
            dispatch_group_enter(group);
            NSData *recordData = [NSData dataWithContentsOfURL:[ZXRecoderVideoManager sharedRecoderManager].recordFileUrl];
            dispatch_group_async(group, queue, ^{
                [HttpClient zx_httpClientToUploadFileWithData:recordData andType:UPloadFileTypeSound andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                    if (code == 0) {
                        NSDictionary *dict = (NSDictionary *)data;
                        NSString *url = dict[@"url"];
                        soundUrl = url;
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
            [HttpClient zx_httpClientToAddEventWithEventno:0 andEventdescription:self.headerView.textView.text andOrgid:self.currentModel.orgid andRegionid:self.currentModel.projectorgregionid andPhotoUrl:temStr andVideoUrl:@"" andSoundUrl:soundUrl andPositionAdress:self.headerView.positionAdress andPosition:[UserLocationManager sharedUserLocationManager].position andCreateemployerid:[[UserManager sharedUserManager].user.employerid longLongValue] andLiableemployerid:self.currentModel.employerid andUrgency:self.urgencyType andIsvehneed:self.isNeedCarType andSendsms:self.selectApprvoBtn.selected andSolveemployerid:self.reslovid andEventsStatus:0 andPatroleventid:0 andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                if (code == 0) {
                    [MBProgressHUD showError:@"提交成功" toView:self.view];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKTASKRELOADDATA object:nil];
                    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
                }else{
                    if (message.length != 0) {
                        [MBProgressHUD showError:message toView:self.view];
                    }else{
                        [MBProgressHUD showError:@"提交失败" toView:self.view];
                    }
                }
            }];
        });
    }
}

- (void)clickMeassageAction{
    self.selectApprvoBtn.selected = !self.selectApprvoBtn.selected;
}

#pragma mark - setter && getter

- (workTaskHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [workTaskHeaderView workTaskView];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UILabel *)reslovPersonLabel{
    if (_reslovPersonLabel == nil) {
        _reslovPersonLabel = [[UILabel alloc] init];
        _reslovPersonLabel.text = @"选择责任区与责任人:";
        _reslovPersonLabel.textColor = UIColorWithFloat(79);
        _reslovPersonLabel.font = [UIFont systemFontOfSize:15];
    }
    return _reslovPersonLabel;
}

- (FButton *)reslovBtn{
    if (_reslovBtn == nil) {
        _reslovBtn  = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _reslovBtn.layer.borderWidth = 1;
        [_reslovBtn  setTitle:@"请选择" forState:UIControlStateNormal];
        _reslovBtn.layer.borderColor = UIColorWithFloat(159).CGColor;
        _reslovBtn.backgroundColor = UIColorWithFloat(222);
        _reslovBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_reslovBtn  setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_reslovBtn  setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_reslovBtn  addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _reslovBtn.tag = 3;
    }
    return _reslovBtn ;
}

- (UILabel *)dutyRegionLabel{
    if (_dutyRegionLabel == nil) {
        _dutyRegionLabel = [[UILabel alloc] init];
        _dutyRegionLabel.textColor = UIColorWithFloat(79);
        _dutyRegionLabel.font = [UIFont systemFontOfSize:15];
        if (self.currentModel != nil) {
            _dutyRegionLabel.text = [NSString stringWithFormat:@"责任区:  %@",self.currentModel.orgname];
        }else{
            _dutyRegionLabel.text = @"责任区: ";
        }
    }
    return _dutyRegionLabel;
}

- (UILabel *)dutyPersonLabel{
    if (_dutyPersonLabel == nil) {
        _dutyPersonLabel = [[UILabel alloc] init];
        _dutyPersonLabel.textColor = UIColorWithFloat(79);
        _dutyPersonLabel.font = [UIFont systemFontOfSize:15];
        _dutyPersonLabel.textAlignment = NSTextAlignmentLeft;
        if (self.currentModel != nil) {
            _dutyPersonLabel.text = [NSString stringWithFormat:@"责任人:  %@",self.currentModel.employername];
        }else{
            _dutyPersonLabel.text = @"责任人:  ";
        }
    }
    return _dutyPersonLabel;
}

- (UILabel *)selectedPersonDesLabel{
    if (_selectedPersonDesLabel == nil) {
        _selectedPersonDesLabel = [[UILabel alloc] init];
        _selectedPersonDesLabel.text = @"处理人:";
        _selectedPersonDesLabel.textColor = UIColorWithFloat(79);
        _selectedPersonDesLabel.font = [UIFont systemFontOfSize:15];
    }
    return _selectedPersonDesLabel;
}

- (FButton *)selecetedPersonBtn{
    if (_selecetedPersonBtn == nil) {
        _selecetedPersonBtn  = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _selecetedPersonBtn.layer.borderWidth = 1;
        [_selecetedPersonBtn  setTitle:@"请选择" forState:UIControlStateNormal];
        _selecetedPersonBtn.layer.borderColor = UIColorWithFloat(159).CGColor;
        _selecetedPersonBtn.backgroundColor = UIColorWithFloat(222);
        _selecetedPersonBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_selecetedPersonBtn  setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_selecetedPersonBtn  setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_selecetedPersonBtn  addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _selecetedPersonBtn.tag = 4;
    }
    return _selecetedPersonBtn;
}

- (UILabel *)urgencyDesLabel{
    if (_urgencyDesLabel == nil) {
        _urgencyDesLabel = [[UILabel alloc] init];
        _urgencyDesLabel.text = @"紧急度:";
        _urgencyDesLabel.textColor = UIColorWithFloat(79);
        _urgencyDesLabel.font = [UIFont systemFontOfSize:15];
    }
    return _urgencyDesLabel;
}

- (FButton *)urgencyBtn{
    if (_urgencyBtn == nil) {
        _urgencyBtn  = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _urgencyBtn .layer.borderWidth = 1;
        [_urgencyBtn  setTitle:@"紧急" forState:UIControlStateNormal];
        _urgencyBtn.layer.borderColor = UIColorWithFloat(159).CGColor;
        _urgencyBtn.backgroundColor = UIColorWithFloat(222);
        _urgencyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_urgencyBtn  setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_urgencyBtn  setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_urgencyBtn  addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _urgencyBtn.tag = 5;
    }
    return _urgencyBtn;
}

- (UILabel *)isNeedIvhLabel{
    if (_isNeedIvhLabel == nil) {
        _isNeedIvhLabel = [[UILabel alloc] init];
        _isNeedIvhLabel.text = @"车辆需求:";
        _isNeedIvhLabel.textColor = UIColorWithFloat(79);
        _isNeedIvhLabel.font = [UIFont systemFontOfSize:15];
    }
    return _isNeedIvhLabel;
}

- (FButton *)isNeedIvhBtn{
    if (_isNeedIvhBtn == nil) {
        _isNeedIvhBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _isNeedIvhBtn.layer.borderWidth = 1;
        [_isNeedIvhBtn  setTitle:@"不需要" forState:UIControlStateNormal];
        _isNeedIvhBtn.layer.borderColor = UIColorWithFloat(159).CGColor;
        _isNeedIvhBtn.backgroundColor = UIColorWithFloat(222);
        _isNeedIvhBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_isNeedIvhBtn  setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_isNeedIvhBtn  setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_isNeedIvhBtn  addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _isNeedIvhBtn.tag = 6;
    }
    return _isNeedIvhBtn;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.backgroundColor = BTNBackgroudColor;
        _saveBtn.layer.cornerRadius = 6;
        [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 8;
    }
    return _saveBtn;
}

- (FButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _submitBtn.backgroundColor = BTNBackgroudColor;
        _submitBtn.layer.cornerRadius = 6;
        [_submitBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.tag = 7;
    }
    return _submitBtn;
}

- (FButton *)selectApprvoBtn{
    if (_selectApprvoBtn == nil) {
        _selectApprvoBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_selectApprvoBtn setImage:[UIImage imageNamed:@"eventSelectNomal"]
                          forState:UIControlStateNormal];
        [_selectApprvoBtn setImage:[UIImage imageNamed:@"eventSelectHighted"] forState:UIControlStateSelected];
        [_selectApprvoBtn addTarget:self action:@selector(clickMeassageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectApprvoBtn;
}

@end
