//
//  MyAccountViewController.m
//  FindHouse
//
//  Created by 许景源 on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MyAccountViewController.h"
#import "ModifyMyPhoneViewController.h"
#import "TrueNameCitifyViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NJImageCropperViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f
#define BOUNDARY @"----------cH2gL6ei4Ef1KM7cH2KM7ae0ei4gL6"


@interface MyAccountViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, NJImageCropperDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong,nonatomic)UIView *successView;

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的账户";

    [self initValueAndView];

    
}

#pragma mark --------- 初始化
-(void)initValueAndView{
    
    self.isCitify = NO;
    self.isModify = NO;
   
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius = self.headImgView.frame.size.height/2;
    
    if (self.isCitify) {
        
        self.unCitifyView.hidden = YES;
        self.alerdayCitifyView.hidden = NO;
        self.citifyButtonView.hidden = YES;
    }else{
        
        self.unCitifyView.hidden = NO;
        self.alerdayCitifyView.hidden = YES;
        self.citifyButtonView.hidden = NO;
    }
    
    self.nickNameField.hidden = YES;
    self.phoneField.hidden = YES;
    self.offThreeButton.hidden = YES;
    self.offThreeLineLab.hidden = YES;
    self.sexImgView.hidden = YES;
    self.modifyPhoneButton.hidden = YES;
    self.modifyPhoneLineLab.hidden = YES;
    
    [self createSuccessView];
}
#pragma mark --------- 创建成功视图
-(void)createSuccessView{
    
    self.successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTHMAIN, HEIGHTMAIN)];
    self.successView.hidden = YES;
    self.successContentView.frame = CGRectMake(0, 0, WIDTHMAIN, HEIGHTMAIN);
    self.successContentView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    [self.successView addSubview:self.successContentView];
    
    [self.view addSubview:self.successView];
    
}



#pragma mark --------- 修改操作按钮方法
- (IBAction)operateButtonAction:(UIButton *)sender {
    
    self.isModify = !self.isModify;
    if (self.isModify) {
        
        self.nameLab.textColor = [UIColor lightGrayColor];
        [self.operateButton setTitle:@"保存" forState:UIControlStateNormal];
        self.nickNameLab.hidden = YES;
        self.nickNameField.text = self.nickNameLab.text;
        self.nickNameField.hidden = NO;
        self.modifyPhoneButton.hidden = NO;
        self.modifyPhoneLineLab.hidden = NO;
        self.offThreeButton.hidden = NO;
        self.offThreeLineLab.hidden = NO;
        self.sexImgView.hidden = NO;
    }
    else{
        
        self.successView.hidden = NO;
        
    }
    
}

#pragma mark --------- 修改头像按钮方法
- (IBAction)modifyHeadImgButtonAction:(UIButton *)sender {
 
     if (self.isModify) {
     
         [self editPortrait];
         NSLog(@"-------修改头像");
     }
  
}

#pragma mark --------- 实名认证按钮方法
- (IBAction)tureNameButtonAction:(UIButton *)sender {
    
    TrueNameCitifyViewController *trueNameCitifyVC = [TrueNameCitifyViewController new];
    [self.navigationController pushViewController:trueNameCitifyVC animated:YES];
}
#pragma mark --------- 修改性别方法
- (IBAction)modifySexButtonAction:(UIButton *)sender {
    
    if (self.isModify) {
        
        [self selectSexAction];
    }
    
    
}
#pragma mark --------- 更改绑定手机按钮方法
- (IBAction)modifyPhoneButtonAction:(UIButton *)sender {
    
    ModifyMyPhoneViewController *modifyMyPhoneVC = [ModifyMyPhoneViewController new];
    modifyMyPhoneVC.phoneNumStr = self.phoneLab.text;
    [self.navigationController pushViewController:modifyMyPhoneVC animated:YES];
}


#pragma mark --------- 解除绑定按钮方法
- (IBAction)offThreeFangButtonAction:(UIButton *)sender {
    
    
}

#pragma mark --------- 成功之后留在本页面按钮
- (IBAction)successInThisViewButtonAction:(UIButton *)sender {
    
    self.successView.hidden = YES;
    self.nameLab.textColor = [UIColor blackColor];
    self.nickNameField.hidden = YES;
    self.nickNameLab.hidden = NO;
    self.phoneField.hidden = YES;
    self.modifyPhoneButton.hidden = YES;
    self.modifyPhoneLineLab.hidden = YES;
    self.offThreeButton.hidden = YES;
    self.offThreeLineLab.hidden = YES;
    self.sexImgView.hidden = YES;
    [self.operateButton setTitle:@"修改" forState:UIControlStateNormal];
}

#pragma mark --------- 成功之后返回页面按钮
- (IBAction)successBackButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark ---------选择男女方法
-(void)selectSexAction{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择男女" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
    sheet.tag = 1000;
    [sheet showInView:self.view];
    
}


//-------------------------修改头像-------------------------------
#pragma mark 下面全是修改头像的，不是我写的，先暂时不看，能用就好
- (void)editPortrait {
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
    
}


#pragma mark VPImageCropperDelegate
- (void)imageCropper:(NJImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    //self.myImage = [UIImage new];
    //self.myImage  = editedImage;
    self.headImgView.image = editedImage;
    //[self webModifyMemberHeadImgInfo];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f.png", a];
    
    // 压缩图片
    UIImage *scaleImage = [self scaleFromImage:editedImage toSize:CGSizeMake(150.0f, 150.0f)];
    NSData *imageData = UIImageJPEGRepresentation(scaleImage, 1.0);
    
    //self.fileImg = [FileDetail fileWithName:timeString data:imageData];

    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(NJImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //选择男女
    if (actionSheet.tag == 1000) {
        
        if (buttonIndex == 0) {
            
            NSLog(@"==========男");
            self.sexLab.text = @"男";
            
        }
        if (buttonIndex == 1) {
            
            self.sexLab.text = @"女";
            NSLog(@"==========女");

            
        }
        
    }else{
        
        //-----------选择头像------------------
        if (buttonIndex == 0) {
            // 拍照
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
            }
            
        } else if (buttonIndex == 1) {
            // 从相册中选取
            if ([self isPhotoLibraryAvailable]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
            }
        }
        
        
    }
    
    
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        NJImageCropperViewController *imgEditorVC = [[NJImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 1;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 修改图像大小
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
