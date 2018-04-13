//
//  WorkTaskAddController.m
//  ZXProject
//
//  Created by Me on 2018/3/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskAddController.h"
#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"
#import "UserLocationManager.h"
#import "UIAlertAction+Attribute.h"
#import <Masonry.h>
#import "HttpClient+WorkTask.h"
#import "WorkTaskDetailModel.h"
#import "CGXStringPickerView.h"
#import "CGXPickerView.h"
#import "ZXRecordKit.h"
#import "workTaskHeaderView.h"
#import "MyPositionViewController.h"
#import "HttpClient+UploadFile.h"



@interface WorkTaskAddController()<WorkTaskAddImagePickViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,workTaskHeaderViewDelegate,RecordViewDelegate>


@property (nonatomic, copy) NSString *positionAdress;

@property (nonatomic, strong) WorkTaskAddImagePickView *pickView;
@property (nonatomic, strong) workTaskHeaderView *headerView;
@property (nonatomic, strong) UILabel *dutyRegionLabel;
@property (nonatomic, strong) UILabel *dutyPersonLabel;
@property (nonatomic, strong) UIView  *lineFive;

@property (nonatomic, strong) UILabel *reslovPersonLabel;
@property (nonatomic, strong) FButton *reslovBtn;
@property (nonatomic, strong) UIView *lineSix;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) FButton *levelBtn;
@property (nonatomic, strong) UIView *lineSeven;
@property (nonatomic, strong) UILabel *isvehNeedLabel;
@property (nonatomic, strong) FButton *isvehNeedBtn;
@property (nonatomic, strong) UIView *lineEight;

@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;

@property (nonatomic, strong) NSArray *projectRegions;
@property (nonatomic, strong) WorkTaskDetailModel *currentModel;

@property (nonatomic, strong) RecordView *recordView;
@property (nonatomic, strong) UIButton *coverView;
@property (nonatomic, assign) BOOL hasRecord;



@end

@implementation WorkTaskAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增事件";
    [self setNetworkRequest];
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
        self.headerView = [workTaskHeaderView workTaskView];
        self.headerView.positionAdress =  [UserLocationManager sharedUserLocationManager].positionAdress;
        self.positionAdress = [UserLocationManager sharedUserLocationManager].positionAdress;
        self.headerView.delegate = self;
         [self setSubViews];
    }else{
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            ZXHIDE_LOADING;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            self.headerView = [workTaskHeaderView workTaskView];
            self.headerView.positionAdress = [NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street];
            self.headerView.delegate = self;
            self.positionAdress = [NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street];
            [self setSubViews];
        }];
    }
}

- (void)setSubViews{
    __weak typeof(self) weakself = self;
    UIScrollView *svc = [[UIScrollView alloc] init];
    svc.backgroundColor = WhiteColor;
    svc.showsVerticalScrollIndicator = NO;
    svc.bounces = NO;
    [self.view addSubview:svc];
    [svc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = WhiteColor;
    [svc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(svc);
        make.width.equalTo(svc);
    }];
    [contentView addSubview:self.headerView];
    [contentView addSubview:self.dutyRegionLabel];
    [contentView addSubview:self.dutyPersonLabel];
    [contentView addSubview:self.lineFive];
    [contentView addSubview:self.reslovBtn];
    [contentView addSubview:self.reslovPersonLabel];
    [contentView addSubview:self.lineSix];
    [contentView addSubview:self.lineSeven];
    [contentView addSubview:self.submitBtn];
    [contentView addSubview:self.saveBtn];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(contentView.mas_top);
        make.height.mas_equalTo(361);
    }];
    [self.reslovPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.headerView.mas_bottom).offset(15);
    }];
    [self.reslovBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.reslovPersonLabel.mas_right).offset(30);
        make.centerY.equalTo(weakself.reslovPersonLabel.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [self.lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.reslovPersonLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.dutyRegionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineFive.mas_bottom).offset(15);
    }];
    [self.lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.dutyRegionLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.dutyPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineSix.mas_bottom).offset(15);
    }];
    [self.lineSeven mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.dutyPersonLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(60);
        make.top.equalTo(weakself.lineSeven.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-60);
        make.top.equalTo(weakself.lineSeven.mas_bottom).offset(20);
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
    }else if (btn.tag == 5){//保存
        
    }else if (btn.tag == 6){//提交
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
        }
      
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
            [HttpClient zx_httpClientToAddOrgTaskWithEventMark:self.headerView.textView.text andPosition:[UserLocationManager sharedUserLocationManager].position andPositionaddress:self.positionAdress andRegionid:self.currentModel.projectorgregionid andOrgid:self.currentModel.orgid andIableemployerid:self.currentModel.employerid andPhotoUrls:temStr andSoundUrls:soundUrl andVideoUrls:@"" andConfirmemployer:@"" andTaskStatus:@"" andOrgTaskid:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                ZXHIDE_LOADING;
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

#pragma mark - setter && getter
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

- (UIView *)lineFive{
    if (_lineFive == nil) {
        _lineFive = [[UIView alloc] init];
        _lineFive.backgroundColor = UIColorWithFloat(239);
    }
    return _lineFive;
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

- (UIView *)lineSix{
    if (_lineSix == nil) {
        _lineSix = [[UIView alloc] init];
        _lineSix.backgroundColor = UIColorWithFloat(239);
    }
    return _lineSix;
}

- (UIView *)lineSeven{
    if (_lineSeven== nil) {
        _lineSeven = [[UIView alloc] init];
        _lineSeven.backgroundColor = UIColorWithFloat(239);
    }
    return _lineSeven;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.backgroundColor = BTNBackgroudColor;
        _saveBtn.layer.cornerRadius = 6;
        [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 5;
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
        _submitBtn.tag = 6;
    }
    return _submitBtn;
}

- (UIView *)lineEight{
    if (_lineEight == nil) {
        _lineEight = [[UIView alloc] init];
        _lineEight.backgroundColor = UIColorWithFloat(239);
    }
    return _lineEight;
}




@end
