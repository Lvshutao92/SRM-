//
//  AddGongYouConnectViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/14.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "AddGongYouConnectViewController.h"

@interface AddGongYouConnectViewController ()<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PGDatePickerDelegate>
{
    UIScrollView *scrollview;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UIImageView *imaview;
    UIButton *btn;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    
    SQCustomButton *isAbtn;
    SQCustomButton *noAbtn;
    NSString *isnoConnect;
    
    SQCustomButton *isBbtn;
    SQCustomButton *noBbtn;
    NSString *isnoNan;
}















@end

@implementation AddGongYouConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollview];
    
    [self setUpView];
    text1.text = self.model.leadNo;
    text6.text = [Manager getCurrentTimes];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
}

- (void)clicksave{
    [self addgongyou];
}


- (void)addgongyou{
    if (text2.text.length >0&&text3.text.length >0&&text4.text.length >0&&text5.text.length >0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"上传中...", @"HUD loading title");
        
        NSDictionary *dic = @{@"leadNo":text1.text,
                              @"mainPerson":isnoConnect,
                              @"personName":text2.text,
                              @"mobile":text3.text,
                              @"email":text4.text,
                              @"wechat":text5.text,
                              @"sex":isnoNan,
                              @"birthday":text6.text,
                              @"nickName":text7.text,
                              @"position":text8.text,
                              };
        LRWeakSelf(self);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:[Manager redingwenjianming:@"msg"] forHTTPHeaderField:@"Authorization"];
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
        CGSize size = imaview.image.size;
        size.height = size.height/5;
        size.width  = size.width/5;
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [imaview.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [manager POST:[Manager dictionToString:dic string:KURLNSString(@"contacts/person/insert?")] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData * data   =  UIImagePNGRepresentation(scaledImage);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"businessCardFile" fileName:fileName mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *diction = [Manager returndictiondata:responseObject];
            //NSLog(@"%@",diction);
            [hud hideAnimated:YES];
            if ([[diction objectForKey:@"code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:centain];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"-----%@",error);
            [hud hideAnimated:YES];
        }];
    }
}

















- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        return NO;
    }
    else if ([textField isEqual:text6]) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        datePickManager.isShadeBackgroud = true;
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerType = PGPickerViewType1;
        datePicker.isHiddenMiddleText = false;
        datePicker.datePickerMode = PGDatePickerModeDate;
        [self presentViewController:datePickManager animated:false completion:nil];
        return NO;
    }
    return YES;
}












- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    text6.text = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
}

- (void)setUpView{
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    lab1.font = FONT(20);
    lab1.text = @"   必要信息";
    lab1.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    lab1.textColor = [UIColor whiteColor];
    [scrollview addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 70, 40)];
    lab2.text = @"线索编号";
    [scrollview addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 110, 40)];
    lab3.text = @"是否主联系人";
    [scrollview addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 70, 40)];
    lab4.text = @"姓名";
    [scrollview addSubview:lab4];
    
    UILabel *lab14 = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 70, 40)];
    lab14.text = @"手机";
    [scrollview addSubview:lab14];
    
    UILabel *lab15 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 70, 40)];
    lab15.text = @"Email";
    [scrollview addSubview:lab15];
    
    UILabel *lab16 = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 70, 40)];
    lab16.text = @"微信号";
    [scrollview addSubview:lab16];
    
    
    
    [self setBaseInfo];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 350, SCREEN_WIDTH, 40)];
    lab5.font = FONT(20);
    lab5.text = @"   补充信息";
    lab5.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    lab5.textColor = [UIColor whiteColor];
    [scrollview addSubview:lab5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, 70, 40)];
    lab6.text = @"性别";
    [scrollview addSubview:lab6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, 70, 40)];
    lab7.text = @"生日";
    [scrollview addSubview:lab7];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 500, 70, 40)];
    lab8.text = @"称呼";
    [scrollview addSubview:lab8];
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 550, 70, 40)];
    lab9.text = @"职位";
    [scrollview addSubview:lab9];
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 600, 70, 40)];
    lab10.text = @"名片";
    [scrollview addSubview:lab10];
    
    [self buchongInfo];
    
    scrollview.contentSize = CGSizeMake(0, 750);
}



- (void)setBaseInfo{
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(130, 50, SCREEN_WIDTH-140, 40)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [scrollview addSubview:text1];
    
    
    isAbtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(130, 100, 80, 40)
                                                           type:SQCustomButtonLeftImageType
                                                      imageSize:CGSizeMake(20, 20) midmargin:10];
    isAbtn.isShowSelectBackgroudColor = NO;
    isAbtn.imageView.image = [UIImage imageNamed:@"isselected"];
    isAbtn.titleLabel.text = @"是";
    isAbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:isAbtn];
    
    noAbtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(220, 100, 80, 40)
                                             type:SQCustomButtonLeftImageType
                                        imageSize:CGSizeMake(20, 20) midmargin:10];
    noAbtn.isShowSelectBackgroudColor = NO;
    noAbtn.imageView.image = [UIImage imageNamed:@"noselected"];
    noAbtn.titleLabel.text = @"否";
    noAbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:noAbtn];
    
    isnoConnect = @"Y";
    
    [isAbtn touchAction:^(SQCustomButton * _Nonnull button) {
        self->isnoConnect = @"Y";
         button.imageView.image = [UIImage imageNamed:@"isselected"];
         self->noAbtn.imageView.image = [UIImage imageNamed:@"noselected"];
    }];
    [noAbtn touchAction:^(SQCustomButton * _Nonnull button) {
        self->isnoConnect = @"N";
        button.imageView.image = [UIImage imageNamed:@"isselected"];
        self->isAbtn.imageView.image = [UIImage imageNamed:@"noselected"];
    }];
    
    
    
    
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(130, 150, SCREEN_WIDTH-140, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(130, 200, SCREEN_WIDTH-140, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.keyboardType = UIKeyboardTypePhonePad;
    [scrollview addSubview:text3];
    
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(130, 250, SCREEN_WIDTH-140, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.keyboardType = UIKeyboardTypeEmailAddress;
    [scrollview addSubview:text4];
    
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(130, 300, SCREEN_WIDTH-140, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text5];
}

- (void)buchongInfo{
    isBbtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(130, 400, 80, 40)
                                             type:SQCustomButtonLeftImageType
                                        imageSize:CGSizeMake(20, 20) midmargin:10];
    isBbtn.isShowSelectBackgroudColor = NO;
    isBbtn.imageView.image = [UIImage imageNamed:@"isselected"];
    isBbtn.titleLabel.text = @"男";
    isBbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:isBbtn];
    
    noBbtn = [[SQCustomButton alloc]initWithFrame:CGRectMake(220, 400, 80, 40)
                                             type:SQCustomButtonLeftImageType
                                        imageSize:CGSizeMake(20, 20) midmargin:10];
    noBbtn.isShowSelectBackgroudColor = NO;
    noBbtn.imageView.image = [UIImage imageNamed:@"noselected"];
    noBbtn.titleLabel.text = @"女";
    noBbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:noBbtn];
    
    isnoNan = @"M";
    
    [isBbtn touchAction:^(SQCustomButton * _Nonnull button) {
        self->isnoNan = @"M";
        button.imageView.image = [UIImage imageNamed:@"isselected"];
        self->noBbtn.imageView.image = [UIImage imageNamed:@"noselected"];
    }];
    [noBbtn touchAction:^(SQCustomButton * _Nonnull button) {
        self->isnoNan = @"W";
        button.imageView.image = [UIImage imageNamed:@"isselected"];
        self->isBbtn.imageView.image = [UIImage imageNamed:@"noselected"];
    }];
    
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(130, 450, SCREEN_WIDTH-140, 40)];
    text6.delegate = self;
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text6];
    
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(130, 500, SCREEN_WIDTH-140, 40)];
    text7.delegate = self;
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text7];
    
    text8 = [[UITextField alloc]initWithFrame:CGRectMake(130, 550, SCREEN_WIDTH-140, 40)];
    text8.delegate = self;
    text8.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text8];
    
    imaview = [[UIImageView alloc]initWithFrame:CGRectMake(130, 610, 160, 120)];
    imaview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimgSelectImage:)];
    [imaview addGestureRecognizer:tap];
    //imaview.image = [UIImage imageNamed:@""];
    imaview.userInteractionEnabled = YES;
    [scrollview addSubview:imaview];
}
- (void)clickimgSelectImage:(UITapGestureRecognizer *)tap{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请选择图片获取路径" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerPictureFromAlbum];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pictureFromCamera];
    }];
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:actionA];
    [alert addAction:actionB];
    [alert addAction:actionC];
    [self presentViewController:alert animated:YES completion:nil];
}
//从手机相册选取图片功能
- (void)pickerPictureFromAlbum {
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.allowsEditing = YES;
    imagepicker.delegate = self;
    [self presentViewController:imagepicker animated:YES completion:nil];
}
//拍照--照相机是否可用
- (void)pictureFromCamera {
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isCamera) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"摄像头不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
//当得到选中的图片或视频时触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imagesave = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImageOrientation imageOrientation = imagesave.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        UIGraphicsBeginImageContext(imagesave.size);
        [imagesave drawInRect:CGRectMake(0, 0, imagesave.size.width, imagesave.size.height)];
        imagesave = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    imaview.image = imagesave;
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
