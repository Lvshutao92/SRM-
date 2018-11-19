//
//  AddGongYouViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/13.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "AddGongYouViewController.h"

@interface AddGongYouViewController ()<UITextFieldDelegate,UITextViewDelegate,PGDatePickerDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
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
    UITextField *text9;
    
    
    
    UITextField *text10;
    
    
    
    UITextView *textview;
    
    UIWindow *window;
    NSString *str;
    
    NSString *addressString;
    NSString *addressString1;

    NSString *addressString2;

//    NSString *sheng;
//    NSString *shi;
    NSString *shiCode;
//    NSString *qu;
    NSString *shengCode;
    NSString *quCode;
 
    
    NSString *addressOrother;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;

@property(nonatomic,strong)NSMutableArray *dataArray2;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation AddGongYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollview];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    [self setUpView];
    
    addressString = @"1";
    addressString1 = @"";
    addressString2 = @"";
    
    text1.text = [Manager getCurrentTimes];
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    shengCode = @"";
    shiCode = @"";
    quCode = @"";
    text10.text = @"";
    textview.text = @"";
    
    if ([self.navigationItem.title isEqualToString:@"编辑公有线索"]) {
        text1.text = self.model.leadGetDate;
        text2.text = self.model.leadSource;
        text3.text = self.model.customerShortName;
        
        text4.text = self.model.customerFullName;
        text5.text = self.model.customerScale;
        text6.text = self.model.customerIndustry;
        
        
        
        text7.text = self.model.customerProvinceName;
        text8.text = self.model.customerCityName;
        text9.text = self.model.customerDistrictName;
        
        shengCode = self.model.customerProvinceCode;
        shiCode = self.model.customerCityCode;
        quCode = self.model.customerDistrictCode;
        
        addressString1 = self.model.customerProvinceCode;
        addressString2 = self.model.customerCityCode;
        
        
        text10.text = self.model.customerAddress;
        textview.text = self.model.customerIntroduce;
    }
  
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
    if ([self.navigationItem.title isEqualToString:@"新增公有线索"]) {
        [self addgongyou];
    }else{
        [self editgongyou];
    }
}
- (void)addgongyou{
    if (text4.text==nil) {
        text4.text = @"";
    }
    if (text5.text==nil) {
        text5.text = @"";
    }
    if (text6.text==nil) {
        text6.text = @"";
    }
    if (text10.text==nil) {
        text10.text = @"";
    }
    if (textview.text==nil) {
        textview.text = @"";
    }
    if (shengCode==nil) {
        shengCode = @"";
    }
    if (shiCode==nil) {
        shiCode = @"";
    }
    if (quCode==nil) {
        quCode = @"";
    }
    if (text1.text.length >0 && text2.text.length >0 && text3.text.length >0) {
        NSDictionary *dic = @{@"leadGetDate":text1.text,
                              @"leadSource":text2.text,
                              @"customerShortName":text3.text,
                              @"customerFullName":text4.text,
                              @"customerScale":text5.text,
                              @"customerIndustry":text6.text,
                              @"customerProvinceCode":shengCode,
                              @"customerCityCode":shiCode,
                              @"customerDistrictCode":quCode,
                              @"customerAddress":text10.text,
                              @"customerIntroduce":textview.text
                              };
        [Manager requestPOSTWithURLStr:[Manager dictionToString:dic string:KURLNSString(@"lead/public/insert?")] finish:^(id  _Nonnull responseObject) {
            NSDictionary *diction = [Manager returndictiondata:responseObject];
            if ([[diction objectForKey:@"code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:centain];
                [self presentViewController:alert animated:YES completion:nil];
            }
            //NSLog(@"------%@",diction);
        } enError:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}
- (void)editgongyou{
    if (text4.text==nil) {
        text4.text = @"";
    }
    if (text5.text==nil) {
        text5.text = @"";
    }
    if (text6.text==nil) {
        text6.text = @"";
    }
    if (text10.text==nil) {
        text10.text = @"";
    }
    if (textview.text==nil) {
        textview.text = @"";
    }
    if (shengCode==nil) {
        shengCode = @"";
    }
    if (shiCode==nil) {
        shiCode = @"";
    }
    if (quCode==nil) {
        quCode = @"";
    }
    if (text1.text.length >0 && text2.text.length >0 && text3.text.length >0) {
        NSDictionary *dic = @{@"leadGetDate":text1.text,
                              @"leadSource":text2.text,
                              @"customerShortName":text3.text,
                              @"customerFullName":text4.text,
                              @"customerScale":text5.text,
                              @"customerIndustry":text6.text,
                              @"customerProvinceCode":shengCode,
                              @"customerCityCode":shiCode,
                              @"customerDistrictCode":quCode,
                              @"customerAddress":text10.text,
                              @"customerIntroduce":textview.text,
                              @"id":self.model.id,
                              @"leadNo":self.model.leadNo,
                              };
        [Manager requestPOSTWithURLStr:[Manager dictionToString:dic string:KURLNSString(@"lead/public/update?")] finish:^(id  _Nonnull responseObject) {
            NSDictionary *diction = [Manager returndictiondata:responseObject];
            if ([[diction objectForKey:@"code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:centain];
                [self presentViewController:alert animated:YES completion:nil];
            }
            //NSLog(@"------%@",diction);
        } enError:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
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
    
    if ([addressOrother isEqualToString:@"1"]) {
        cell.textLabel.text = model.label;
    }else{
        cell.textLabel.text = model.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:.3 animations:^{
        self->window.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    Model *model  =[self.dataArray objectAtIndex:indexPath.row];
    
    //NSLog(@"%@",model.key);
    if ([str isEqualToString:@"1"]) {
        text2.text = model.label;
    }else if ([str isEqualToString:@"2"]) {
        text5.text = model.label;
    }else if ([str isEqualToString:@"3"]){
        text6.text = model.label;
    }
    
    else if ([str isEqualToString:@"4"]){
        text8.text = nil;
        text9.text = nil;
        shiCode = nil;
        quCode = nil;
        
        text7.text = model.name;
        addressString1 = model.id;
        shengCode = model.id;
        addressString2 = @"";
        
    }
    else if ([str isEqualToString:@"5"]){
        quCode=nil;
        text9.text = nil;
        
        text8.text = model.name;
        addressString2 = model.id;
        shiCode = model.id;
        
    }
    else if ([str isEqualToString:@"6"]){
        text9.text = model.name;
        addressString2 = model.id;
        quCode = model.id;

    }
    
}














- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [self textFV];
        
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        datePickManager.isShadeBackgroud = true;
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerType = PGPickerViewType1;
        datePicker.isHiddenMiddleText = false;
        datePicker.datePickerMode = PGDatePickerModeDate;
        [self presentViewController:datePickManager animated:false completion:nil];
        
        return NO;
    }else if ([textField isEqual:text2]) {
        [self textFV];
        [self lod1];
        str = @"1";
        return NO;
    }else if ([textField isEqual:text5]) {
        [self textFV];
        [self lod2];
        str = @"2";
        return NO;
    }else if ([textField isEqual:text6]) {
        [self textFV];
        [self lod3];
        str = @"3";
        return NO;
    }else if ([textField isEqual:text7]) {
        [self textFV];
        str = @"4";
        [self lod4];
        return NO;
    }
    else if ([textField isEqual:text8]) {
        [self textFV];
        if (text7.text.length>0){
            str = @"5";
            [self lod5];
        }
        
        return NO;
    }
    else if ([textField isEqual:text9]) {
        [self textFV];
        if (text7.text.length>0&&text8.text.length>0){
            str = @"6";
            [self lod6];
        }
        
        return NO;
    }
    return YES;
}


- (void)lod4{
    LRWeakSelf(self);
    NSString *urlString = [NSString stringWithFormat:@"%@?parentcode=%@",KURLNSString(@"config/address/list"),addressString];
    //NSLog(@"%@",urlString);
    [Manager requestPOSTWithURLStr:urlString finish:^(id  _Nonnull responseObject) {
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
        self->addressOrother = @"2";
//        NSLog(@"1111-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)lod5{
     LRWeakSelf(self);
    NSString *urlString = [NSString stringWithFormat:@"%@?parentcode=%@",KURLNSString(@"config/address/list"),addressString1];
    //NSLog(@"%@",urlString);
    [Manager requestPOSTWithURLStr:urlString finish:^(id  _Nonnull responseObject) {
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
        self->addressOrother = @"2";
//        NSLog(@"222222-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)lod6{
    LRWeakSelf(self);
    NSString *urlString = [NSString stringWithFormat:@"%@?parentcode=%@",KURLNSString(@"config/address/list"),addressString2];
    //NSLog(@"%@",urlString);
    [Manager requestPOSTWithURLStr:urlString finish:^(id  _Nonnull responseObject) {
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
        self->addressOrother = @"2";
//        NSLog(@"3333333333-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}





- (void)lod1{
    LRWeakSelf(self);
    [Manager requestPOSTWithURLStr:KURLNSString(@"config/dictionary/data/getDataListByType?type=lead_source") finish:^(id  _Nonnull responseObject) {
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
        self->addressOrother = @"1";
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"-----------%@",error);
    }];
}
- (void)lod2{
    LRWeakSelf(self);
    [Manager requestPOSTWithURLStr:KURLNSString(@"config/dictionary/data/getDataListByType?type=customer_scale") finish:^(id  _Nonnull responseObject) {
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
        }self->addressOrother = @"1";
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"-----------%@",error);
    }];
}
- (void)lod3{
    LRWeakSelf(self);
    [Manager requestPOSTWithURLStr:KURLNSString(@"config/dictionary/data/getDataListByType?type=customer_industry") finish:^(id  _Nonnull responseObject) {
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
        }self->addressOrother = @"1";
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"-----------%@",error);
    }];
}






















- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    text1.text = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
}












- (void)textFV{
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    [textview resignFirstResponder];
}


- (void)setUpView{
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    lab1.font = FONT(20);
    lab1.text = @"   基本信息";
    lab1.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    lab1.textColor = [UIColor whiteColor];
    [scrollview addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 70, 40)];
    lab2.text = @"获得日期";
    [scrollview addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 70, 40)];
    lab3.text = @"获得渠道";
    [scrollview addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 70, 40)];
    lab4.text = @"客户简称";
    [scrollview addSubview:lab4];
    
    [self setBaseInfo];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
    lab5.font = FONT(20);
    lab5.text = @"   补充信息";
    lab5.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    lab5.textColor = [UIColor whiteColor];
    [scrollview addSubview:lab5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 70, 40)];
    lab6.text = @"客户全称";
    [scrollview addSubview:lab6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 70, 40)];
    lab7.text = @"客户规模";
    [scrollview addSubview:lab7];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 350, 70, 40)];
    lab8.text = @"客户行业";
    [scrollview addSubview:lab8];
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, 70, 40)];
    lab9.text = @"省";
    [scrollview addSubview:lab9];
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, 70, 40)];
    lab10.text = @"市";
    [scrollview addSubview:lab10];
    
    UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(10, 500, 70, 40)];
    lab11.text = @"区";
    [scrollview addSubview:lab11];
    
    
    UILabel *lab12 = [[UILabel alloc]initWithFrame:CGRectMake(10, 550, 70, 40)];
    lab12.text = @"详细地址";
    [scrollview addSubview:lab12];
    
    UILabel *lab13 = [[UILabel alloc]initWithFrame:CGRectMake(10, 600, 70, 40)];
    lab13.text = @"客户介绍";
    [scrollview addSubview:lab13];
    
    
    [self buchongInfo];
    
    text1.placeholder = @"请选择";
    text2.placeholder = @"请选择";
    text6.placeholder = @"请选择";
    text5.placeholder = @"请选择";
    text7.placeholder = @"请选择";
    text8.placeholder = @"请选择";
    text9.placeholder = @"请选择";
    scrollview.contentSize = CGSizeMake(0, 750);
}



- (void)setBaseInfo{
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(90, 50, SCREEN_WIDTH-100, 40)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(90, 100, SCREEN_WIDTH-100, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(90, 150, SCREEN_WIDTH-100, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
}

- (void)buchongInfo{
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(90, 250, SCREEN_WIDTH-100, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text4];
    
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(90, 300, SCREEN_WIDTH-100, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text5];
    
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(90, 350, SCREEN_WIDTH-100, 40)];
    text6.delegate = self;
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text6];
    
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(90, 400, SCREEN_WIDTH-100, 40)];
    text7.delegate = self;
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text7];
    
    text8 = [[UITextField alloc]initWithFrame:CGRectMake(90, 450, SCREEN_WIDTH-100, 40)];
    text8.delegate = self;
    text8.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text8];
    
    text9 = [[UITextField alloc]initWithFrame:CGRectMake(90, 500, SCREEN_WIDTH-100, 40)];
    text9.delegate = self;
    text9.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text9];
    
    text10 = [[UITextField alloc]initWithFrame:CGRectMake(90, 550, SCREEN_WIDTH-100, 40)];
    text10.delegate = self;
    text10.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text10];
    
    
    textview = [[UITextView alloc]initWithFrame:CGRectMake(90, 600,  SCREEN_WIDTH-100, 120)];
    textview.delegate = self;
    LRViewBorderRadius(textview, 5, .8, [UIColor colorWithWhite:.8 alpha:.4]);
    textview.font = FONT(16);
    [scrollview addSubview:textview];
}





- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end
