//
//  DeviceCollectionController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceCollectionController.h"
#import "DeviceCollectionView.h"
#import "UserLocationManager.h"
#import "GobHeaderFile.h"
#import "UIAlertAction+Attribute.h"
#import "HttpClient+UploadFile.h"
#import "HttpClient+Device.h"

@interface DeviceCollectionController ()<DeviceCollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) DeviceCollectionView *collectionView;

@property (nonatomic, assign) int isFoucs;
@property (nonatomic, assign) int isVdieo;
@property (nonatomic, assign) int isPublic;


@end

@implementation DeviceCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备采集";
    self.collectionView.frame = self.view.bounds;
    [self setPositionAdress];
    [self setupSubViews];
}

- (void)setupSubViews{
   [self.view addSubview:self.collectionView];
 
}

- (void)setPositionAdress{
    if ([UserLocationManager sharedUserLocationManager].positionAdress != nil) {
        ZXHIDE_LOADING;
        [self.collectionView  setPositionAdress:[UserLocationManager sharedUserLocationManager].positionAdress];
    }else{
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            ZXHIDE_LOADING;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            [UserLocationManager sharedUserLocationManager].positionAdress = [NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street];
            [self.collectionView  setPositionAdress:[UserLocationManager sharedUserLocationManager].positionAdress];
        }];
    }
}


#pragma mark - CollectionViewDelegateMethod

- (void)deviceCollectionViewDidClickBtnTag:(UIButton *)btn{
    if (btn.tag == 5) {//取消
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 6){//提交
        NSArray *pickImages = [self.collectionView getImages];
        if (pickImages.count == 0) {
            [MBProgressHUD showError:@"请至少选择一张照片" toView:self.view];
            return;
        }
        if (self.collectionView.deviceCodeFiled.text.length == 0) {
            [MBProgressHUD showError:@"请填写设备编码" toView:self.view];
            return;
        }
        if (self.collectionView.deviceNameFiled.text.length == 0) {
            [MBProgressHUD showError:@"请填写设备名称" toView:self.view];
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
        dispatch_queue_t mQueue = dispatch_get_main_queue();
        dispatch_group_notify(group, mQueue, ^{//照片上传完提交审核
            ZXHIDE_LOADING;
            ZXSHOW_LOADING(self.view, @"提交中...");
            if (temStr.length != 0) {
                [temStr replaceCharactersInRange:NSMakeRange(temStr.length - 1, 1) withString:@""];//去掉最后一个|符号
            }
            [HttpClient zx_httpClientToAddfacilityWithFacilitycode:self.collectionView.deviceCodeFiled.text andFacilityname:self.collectionView.deviceNameFiled.text andFacilitytype:self.deviceTypeDict[@"datacode"] andRfidtag:self.collectionView.RFIDfiled.text andPhotoUrl:temStr andPositionAdress:[UserLocationManager sharedUserLocationManager].positionAdress andPositionlon:[UserLocationManager sharedUserLocationManager].currentCoordinate.longitude andPositionlat:[UserLocationManager sharedUserLocationManager].currentCoordinate.latitude andIsFocus:self.isFoucs andIsvideo:self.isVdieo andIspublic:self.isPublic andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                ZXHIDE_LOADING;
                if (code == 0) {
                    [MBProgressHUD showError:@"提交成功" toView:self.view];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_DEVICEINFORELOADDATA object:nil];
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
        
    }else if (btn.tag == 1001){
        self.isFoucs = btn.selected;
    }else if (btn.tag == 1002){
        self.isVdieo = btn.selected;
    }else if(btn.tag == 1003){
        self.isPublic = btn.selected;
    }else if (btn.tag == 100){//拍照
        [self alterPickController];
    }
}

- (void)alterPickController{
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

#pragma mark - WorkTaskAddImageViewDelegateMethod

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.collectionView getPickImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - setter && getter

- (DeviceCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [DeviceCollectionView deviceCollectionView];
        [_collectionView setDeviceDict:self.deviceTypeDict];
        _collectionView.delegate = self;
    }
    return _collectionView;
}



@end
