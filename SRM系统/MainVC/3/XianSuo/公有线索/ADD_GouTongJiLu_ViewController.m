//
//  ADD_GouTongJiLu_ViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/15.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "ADD_GouTongJiLu_ViewController.h"

@interface ADD_GouTongJiLu_ViewController ()<UITextFieldDelegate,UITextViewDelegate,PGDatePickerDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *scrollview;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextView  *textview;
    UIImageView *imageview;
    
    UIWindow *window;
    NSString *isnoConnect;
    NSString *personID;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation ADD_GouTongJiLu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollview];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    
    [self setUpView];
    
    
    window = [[UIWindow alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.3 alpha:.5];
    window.windowLevel = UIWindowLevelNormal;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tap.delegate = self;
    [window addGestureRecognizer:tap];
    [window makeKeyAndVisible];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT-350-10-50, SCREEN_WIDTH-20, 350)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [window addSubview:self.tableview];
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(10,0, SCREEN_WIDTH-20, 0.1)];
    self.tableview.tableFooterView = vv;
    UILabel *hea = [[UILabel alloc]initWithFrame:CGRectMake(10,SCREEN_HEIGHT-451, SCREEN_WIDTH-20, 40)];
    hea.text = @"请选择";
    hea.backgroundColor = [UIColor whiteColor];
    hea.textAlignment = NSTextAlignmentCenter;
    [window addSubview: hea];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, SCREEN_HEIGHT-10-40, SCREEN_WIDTH-20, 40);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [window addSubview:btn];
}
- (void)cancel{
    [UIView animateWithDuration:.3 animations:^{
        self->window.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}


- (void)clicksave{
    if (text1.text.length >0&&text2.text.length >0&&text3.text.length >0&&text4.text.length >0&&textview.text.length >0&& personID.length >0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"上传中...", @"HUD loading title");
        
        NSDictionary *dic = @{@"leadNo":self.model.leadNo,
                              @"contactsPersonId":personID,
                              @"communicateType":text3.text,
                              @"communicateTime":text4.text,
                              @"communicateResult":textview.text,
                              };
        LRWeakSelf(self);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:[Manager redingwenjianming:@"msg"] forHTTPHeaderField:@"Authorization"];
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
        CGSize size = imageview.image.size;
        size.height = size.height/5;
        size.width  = size.width/5;
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [imageview.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [manager POST:[Manager dictionToString:dic string:KURLNSString(@"contacts/communicate/insert?")] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

            NSData * data   =  UIImagePNGRepresentation(scaledImage);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            if (data == nil) {
                NSString *aString = @"";
                data = [aString dataUsingEncoding: NSUTF8StringEncoding];
            }
            [formData appendPartWithFileData:data name:@"communicateFileImg" fileName:fileName mimeType:@"image/png"];
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
            //NSLog(@"-----%@",error);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:centain];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            [hud hideAnimated:YES];
        }];
    }
    
}





- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.tableview])
    {
        return NO;
    }
    return YES;
}
- (void)tapAction{
    [UIView animateWithDuration:.3 animations:^{
        self->window.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Model *model  =[self.dataArray objectAtIndex:indexPath.row];
    if ([isnoConnect isEqualToString:@"2"]) {
        cell.textLabel.text = model.label;
    }else{
        cell.textLabel.text = model.personName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:.3 animations:^{
        self->window.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    Model *model  =[self.dataArray objectAtIndex:indexPath.row];
    if ([isnoConnect isEqualToString:@"1"]){
        NSLog(@"-------%@",model.id);
        personID = model.id;
        text2.text = model.personName;
    }else{
        text3.text = model.label;
    }
}









- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [self textFV];
        return NO;
    }else if ([textField isEqual:text2]) {
        [self textFV];
        [self lod1];
        return NO;
    }else if ([textField isEqual:text3]) {
        [self textFV];
        [self lod2];
        return NO;
    }else if ([textField isEqual:text4]) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        datePickManager.isShadeBackgroud = true;
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerType = PGPickerViewType2;
        datePicker.isHiddenMiddleText = false;
        datePicker.datePickerMode = PGDatePickerModeDate;
        [self presentViewController:datePickManager animated:false completion:nil];
        return NO;
    }
    return YES;
}



- (void)lod1{
    LRWeakSelf(self);
    NSDictionary *dic = @{@"leadNo":self.model.leadNo};
    [Manager requestPOSTWithURLStr:[Manager dictionToString:dic string:KURLNSString(@"contacts/communicate/leadno/person?")] finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        if (arr.count == 0) {
            [UIView animateWithDuration:.3 animations:^{
                self->window.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }else{
            [UIView animateWithDuration:.3 animations:^{
                self->window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            Model *model = [Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        self->isnoConnect = @"1";
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"-----------%@",error);
    }];
}
- (void)lod2{
    LRWeakSelf(self);
    [Manager requestPOSTWithURLStr:KURLNSString(@"config/dictionary/data/getDataListByType?type=communicate_type") finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        if (arr.count == 0) {
            [UIView animateWithDuration:.3 animations:^{
                self->window.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }else{
            [UIView animateWithDuration:.3 animations:^{
                self->window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            Model *model = [Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        self->isnoConnect = @"2";
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"-----------%@",error);
    }];
}





















- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    text4.text = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
}












- (void)textFV{
    [textview resignFirstResponder];
}


- (void)setUpView{
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 40)];
    lab2.text = @"线索编号";
    [scrollview addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 70, 40)];
    lab3.text = @"联系人";
    [scrollview addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 70, 40)];
    lab4.text = @"联系方式";
    [scrollview addSubview:lab4];
 
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 70, 40)];
    lab6.text = @"跟进时间";
    [scrollview addSubview:lab6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, 70, 40)];
    lab7.text = @"跟进结束";
    [scrollview addSubview:lab7];
    
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, 70, 40)];
    lab8.text = @"附件📎";
    [scrollview addSubview:lab8];
    
    
    
     [self setBaseInfo];
}



- (void)setBaseInfo{
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-100, 40)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(90, 60, SCREEN_WIDTH-100, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(90, 110, SCREEN_WIDTH-100, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
    
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(90, 160, SCREEN_WIDTH-100, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text4];
    
    textview = [[UITextView alloc]initWithFrame:CGRectMake(90, 210,  SCREEN_WIDTH-100, 90)];
    textview.delegate = self;
    LRViewBorderRadius(textview, 5, .8, [UIColor colorWithWhite:.8 alpha:.4]);
    textview.font = FONT(16);
    [scrollview addSubview:textview];
    
    text1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    text1.text = self.model.leadNo;
    text2.placeholder = @"请选择";
    text3.placeholder = @"请选择";
    text4.text = [Manager getCurrentTimesAAAAAAA];
    
    
    
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(90, 310, 120, 120)];
    imageview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimgSelectImage:)];
    [imageview addGestureRecognizer:tap];
    imageview.userInteractionEnabled = YES;
    [scrollview addSubview:imageview];
    
    
    scrollview.contentSize = CGSizeMake(0, 470);
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
    imageview.image = imagesave;
    [self dismissViewControllerAnimated:YES completion:nil];
}









- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
