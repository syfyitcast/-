//
//  EventsDetailViewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/17.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import "workTaskHeaderView.h"
#import "UserLocationManager.h"
#import "MyPositionViewController.h"
#import "RecordView.h"
#import "ZXRecoderVideoManager.h"
#import "UIAlertAction+Attribute.h"
#import "HttpClient+UploadFile.h"
#import "HttpClient+WorkTask.h"

@interface EventsDetailViewController ()<workTaskHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RecordViewDelegate>

@property (nonatomic, strong) workTaskHeaderView *headerView;

@property (nonatomic, strong) UILabel *submiterDesLabel;
@property (nonatomic, strong) UILabel *submiterNameLabel;
@property (nonatomic, strong) UILabel *dutyRegionLabel;
@property (nonatomic, strong) UILabel *dutyPersonLabel;

@property (nonatomic, strong) UILabel *selectedPersonDesLabel;
@property (nonatomic, strong) UILabel *urgencyDesLabel;
@property (nonatomic, strong) UILabel *isNeedIvhLabel;

@property (nonatomic, strong) workTaskHeaderView *FooterView;
@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;

@property (nonatomic, strong) UIButton *coverView;
@property (nonatomic, strong) RecordView *recordView;
@property (nonatomic, assign) BOOL hasRecord;


@end

@implementation EventsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件详情";
    [self setupSubViews];
    [self swichTaskStatus];
}

- (void)swichTaskStatus{
    if (self.model.eventstatus == 2) {
        if (self.model.soundurl != nil && self.model.soundurl.length != 0) {//有音频
            [self.headerView insetSoundViewWithUrl:self.model.soundUrls.firstObject];
        }
        if (self.model.solvesoundurl != nil && self.model.solvesoundurl.length != 0) {//有音频
            [self.FooterView insetSoundViewWithUrl:self.model.afterSoundUrls.firstObject];
        }
        self.headerView.eventModel = self.model;
        self.FooterView.eventModel = self.model;
        [self setPositionAdress];
    }else if (self.model.eventstatus == 0){//未完成
        if (self.model.soundurl != nil && self.model.soundurl.length != 0) {//有音频
            [self.headerView insetSoundViewWithUrl:self.model.soundUrls.firstObject];
        }
        self.headerView.eventModel = self.model;
        [self setPositionAdress];
    }
}

- (void)setPositionAdress{
    if ([UserLocationManager sharedUserLocationManager].positionAdress != nil) {
        ZXHIDE_LOADING;
        self.FooterView.positionAdress =  [UserLocationManager sharedUserLocationManager].positionAdress;
    }else{
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            ZXHIDE_LOADING;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            self.FooterView.positionAdress = [NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street];
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
    UILabel *resolvBeforeDesLabel = [[UILabel alloc] init];
    resolvBeforeDesLabel.text = @"处理前";
    resolvBeforeDesLabel.layer.cornerRadius = 4;
    resolvBeforeDesLabel.backgroundColor = UIColorWithFloat(219);
    resolvBeforeDesLabel.textColor = WhiteColor;
    resolvBeforeDesLabel.font = [UIFont systemFontOfSize:14];
    resolvBeforeDesLabel.clipsToBounds = YES;
    resolvBeforeDesLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:resolvBeforeDesLabel];
    [resolvBeforeDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(contentView.mas_top).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    UIView *lineOne = [[UIView alloc] init];
    lineOne.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(resolvBeforeDesLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.headerView];
    CGFloat height = 0;
    if (self.model.soundurl != nil && self.model.soundurl.length != 0) {//有音频
        height = 421;
    }else{
        height = 361;
    }
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(lineOne.mas_bottom);
        make.height.mas_equalTo(height);
    }];
    [contentView addSubview:self.submiterDesLabel];
    [self.submiterDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(self.headerView.mas_bottom).offset(15);
    }];
    [contentView addSubview:self.submiterNameLabel];
    [self.submiterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.submiterDesLabel.mas_right).offset(5);
        make.centerY.equalTo(self.submiterDesLabel.mas_centerY);
    }];
    UIView *lineTwo = [[UIView alloc] init];
    lineTwo.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(self.submiterDesLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.dutyRegionLabel];
    [self.dutyRegionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineTwo.mas_bottom).offset(15);
    }];
    [contentView addSubview:self.dutyPersonLabel];
    [self.dutyPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-40);
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
        make.top.equalTo(lineThree.mas_bottom).offset(15);
    }];
    UIView *lineFour = [[UIView alloc] init];
    lineFour.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(self.selectedPersonDesLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.urgencyDesLabel];
    [self.urgencyDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineFour.mas_bottom).offset(15);
    }];
    [contentView addSubview:self.isNeedIvhLabel];
    [self.isNeedIvhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(self.urgencyDesLabel.mas_bottom).offset(30);
    }];
    UIView *lineFive = [[UIView alloc] init];
    lineFive.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineFive];
    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(self.isNeedIvhLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    UILabel *resolvAfterDesLabel = [[UILabel alloc] init];
    resolvAfterDesLabel.text = @"处理后";
    resolvAfterDesLabel.layer.cornerRadius = 4;
    resolvAfterDesLabel.backgroundColor = UIColorWithFloat(219);
    resolvAfterDesLabel.textColor = WhiteColor;
    resolvAfterDesLabel.font = [UIFont systemFontOfSize:14];
    resolvAfterDesLabel.clipsToBounds = YES;
    resolvAfterDesLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:resolvAfterDesLabel];
    [resolvAfterDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineFive.mas_bottom).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    UIView *lineSix = [[UIView alloc] init];
    lineSix.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineSix];
    [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(resolvAfterDesLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    CGFloat afterHeight = 0;
    if (self.model.solvesoundurl != nil && self.model.solvesoundurl.length != 0) {//有音频
        afterHeight = 421;
    }else{
        afterHeight = 361;
    }
    [contentView addSubview:self.FooterView];
    [self.FooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(contentView);
        make.top.equalTo(lineSix.mas_bottom);
        make.height.mas_equalTo(afterHeight);
    }];
    if (self.model.eventstatus != 2) {
        [contentView addSubview:self.saveBtn];
        [contentView addSubview:self.submitBtn];
        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.mas_left).offset(60);
            make.top.equalTo(weakself.FooterView.mas_bottom).offset(20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(44);
        }];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView.mas_right).offset(-60);
            make.top.equalTo(weakself.FooterView.mas_bottom).offset(20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(44);
        }];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.submitBtn.mas_bottom).offset(30);
        }];
    }else{
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.FooterView.mas_bottom);
        }];
    }
}

#pragma mark - RecordViewDelegateMethod

- (void)recordViewDidEndRecord{
    [self.recordView removeFromSuperview];
    [self.coverView removeFromSuperview];
    [self.FooterView insertVideoPlayViewWithPlayTime:[ZXRecoderVideoManager sharedRecoderManager].videoTime];
    [self.FooterView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(431);
    }];
    self.hasRecord = YES;
}


#pragma mark - WorkTaskHeaderViewDelegateMethod

- (void)workTaskHeaderViewDidClickAtionWithTag:(int)tag andView:(workTaskHeaderView *)view{
    if (tag == 1006) {//录音
        [self clickVoiceBtn];
    }else if (tag == 1007){//位置
        [self clickMapBtnWithView:view];
    }
}

- (void)clickMapBtnWithView:(workTaskHeaderView *)view{
    MyPositionViewController *vc = [[MyPositionViewController alloc] init];
    if (self.model.eventstatus == 2) {
        vc.location = CLLocationCoordinate2DMake([self.model.positionlat doubleValue], [self.model.positionlon doubleValue]);
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (view == self.headerView) {
        vc.location = CLLocationCoordinate2DMake([self.model.positionlat doubleValue],[self.model.positionlon doubleValue]);
    }
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.FooterView workTaskHeaderViewGetImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma make - clickAction

- (void)clickAction:(FButton *)btn{
    if (btn.tag == 3) {
        
    }else if (btn.tag == 5){//返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 6){//提交
        NSArray *pickImages = [self.FooterView workTaskHeaderViewGetPickImages];
        if (pickImages.count == 0) {
            [MBProgressHUD showError:@"请添加至少一张照片" toView:self.view];
            return;
        }
        if (self.FooterView.textView.text.length == 0) {
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
            [HttpClient zx_httpClientToConfirmEventAssignWithAssignid:self.model.assignid andEventId:[self.model.eventid longLongValue] andSoundUrl:soundUrl andVideoUrl:@"" andPhotoUrl:temStr andBeginTime:[[NSDate date] timeIntervalSince1970] * 1000.0 andSolveOpinon:self.FooterView.textView.text andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                ZXHIDE_LOADING;
                if (code == 0) {
                    [MBProgressHUD showError:@"提交成功" toView:self.view];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_WORKEVENTRELOADDATA object:nil];
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

#pragma mark - setter && getter

- (workTaskHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [workTaskHeaderView workTaskView];
        _headerView.type = 1;
        _headerView.delegate = self;
    }
    return _headerView;
}

- (workTaskHeaderView *)FooterView{
    if (_FooterView == nil) {
        _FooterView = [workTaskHeaderView workTaskView];
        _FooterView.type = 2;
        _FooterView.delegate = self;
    }
    return _FooterView;
}

- (UILabel *)submiterDesLabel{
    if (_submiterDesLabel == nil) {
        _submiterDesLabel = [[UILabel alloc] init];
        _submiterDesLabel.textColor = UIColorWithFloat(79);
        _submiterDesLabel.font = [UIFont systemFontOfSize:15];
        _submiterDesLabel.text  = @"发起人:";
    }
    return _submiterDesLabel;
}

- (UILabel *)submiterNameLabel{
    if (_submiterNameLabel == nil) {
        _submiterNameLabel = [[UILabel alloc] init];
        _submiterNameLabel.textColor = BTNBackgroudColor;
        _submiterNameLabel.font = [UIFont systemFontOfSize:15];
        _submiterNameLabel.text = self.model.createemployername;
    }
    return _submiterNameLabel;
}

- (UILabel *)dutyRegionLabel{
    if (_dutyRegionLabel == nil) {
        _dutyRegionLabel = [[UILabel alloc] init];
        _dutyRegionLabel.textColor = UIColorWithFloat(79);
        _dutyRegionLabel.font = [UIFont systemFontOfSize:15];
        _dutyRegionLabel.text = [NSString stringWithFormat:@"责任区:  %@",self.model.regionname];
    }
    return _dutyRegionLabel;
}

- (UILabel *)dutyPersonLabel{
    if (_dutyPersonLabel == nil) {
        _dutyPersonLabel = [[UILabel alloc] init];
        _dutyPersonLabel.textColor = UIColorWithFloat(79);
        _dutyPersonLabel.font = [UIFont systemFontOfSize:15];
        _dutyPersonLabel.textAlignment = NSTextAlignmentLeft;
        _dutyPersonLabel.text = [NSString stringWithFormat:@"责任人:  %@",self.model.liableemployername];
    }
    return _dutyPersonLabel;
}

- (UILabel *)selectedPersonDesLabel{
    if (_selectedPersonDesLabel == nil) {
        _selectedPersonDesLabel = [[UILabel alloc] init];
        _selectedPersonDesLabel.text = [NSString stringWithFormat:@"处理人:  %@",self.model.receiveemployername?self.model.receiveemployername:@""];
        _selectedPersonDesLabel.textColor = UIColorWithFloat(79);
        _selectedPersonDesLabel.font = [UIFont systemFontOfSize:15];
    }
    return _selectedPersonDesLabel;
}

- (UILabel *)urgencyDesLabel{
    if (_urgencyDesLabel == nil) {
        _urgencyDesLabel = [[UILabel alloc] init];
        _urgencyDesLabel.text = [NSString stringWithFormat:@"紧急度:  %@",self.model.urgencyname];
        _urgencyDesLabel.textColor = UIColorWithFloat(79);
        _urgencyDesLabel.font = [UIFont systemFontOfSize:15];
    }
    return _urgencyDesLabel;
}

- (UILabel *)isNeedIvhLabel{
    if (_isNeedIvhLabel == nil) {
        _isNeedIvhLabel = [[UILabel alloc] init];
        _isNeedIvhLabel.text = [NSString stringWithFormat:@"车辆需求:  %@",[self.model.isvehneed intValue] == 0?@"不需要":@"需要"];
        _isNeedIvhLabel.textColor = UIColorWithFloat(79);
        _isNeedIvhLabel.font = [UIFont systemFontOfSize:15];
    }
    return _isNeedIvhLabel;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"返回" forState:UIControlStateNormal];
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



@end
