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
    
    UITextView *textview;
    
    UIWindow *window;
    NSString *str;
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
    
    window = [[UIWindow alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.3 alpha:.5];
    window.windowLevel = UIWindowLevelNormal;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tap.delegate = self;
    [window addGestureRecognizer:tap];
    [window makeKeyAndVisible];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(50, SCREEN_HEIGHT/2-180, SCREEN_WIDTH-100, 360)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    LRViewBorderRadius(self.tableview, 8, 0, [UIColor clearColor]);
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [window addSubview:self.tableview];
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-100, 1)];
    self.tableview.tableFooterView = vv;
    
}

- (void)lod1{
    LRWeakSelf(self);
    [Manager requestPOSTWithURLStr:KURLNSString(@"config/dictionary/data/getDataListByType?type=lead_source") paramDic:@{} finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            Model *model = [Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
       NSLog(@"-----------%@",error);
    }];
}
- (void)lod2{
    LRWeakSelf(self);
    [Manager requestPOSTWithURLStr:KURLNSString(@"config/dictionary/data/getDataListByType?type=customer_scale") paramDic:@{} finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            Model *model = [Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"-----------%@",error);
    }];
}
- (void)lod3{
    LRWeakSelf(self);
    [Manager requestPOSTWithURLStr:KURLNSString(@"config/dictionary/data/getDataListByType?type=customer_industry") paramDic:@{} finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            Model *model = [Model mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        //NSLog(@"-----------%@",diction);
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"-----------%@",error);
    }];
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
        self->window.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Model *model  =[self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.label;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:.3 animations:^{
        self->window.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    Model *model  =[self.dataArray objectAtIndex:indexPath.row];
    if ([str isEqualToString:@"1"]) {
        text2.text = model.label;
    }else if ([str isEqualToString:@"2"]) {
        text5.text = model.label;
    }else{
        text6.text = model.label;
    }
    
}


- (void)clicksave{
    
}












- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    text1.text = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
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
        [UIView animateWithDuration:.3 animations:^{
            self->window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        return NO;
    }else if ([textField isEqual:text5]) {
        [self textFV];
        [self lod2];
        str = @"2";
        [UIView animateWithDuration:.3 animations:^{
            self->window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        return NO;
    }else if ([textField isEqual:text6]) {
        [self textFV];
        [self lod3];
        str = @"3";
        [UIView animateWithDuration:.3 animations:^{
            self->window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        return NO;
    }else if ([textField isEqual:text7]) {
        [self textFV];
        
        
        [Manager requestPOSTWithURLStr:@
         "http://server-shop.dxracer.cn/mall/app/common/address" paramDic:@{} finish:^(id  _Nonnull responseObject) {
             NSDictionary *diction = [Manager returndictiondata:responseObject];
            
             NSLog(@"-----------%@",diction);
         } enError:^(NSError * _Nonnull error) {
             NSLog(@"%@",error);
         }];
        
        return NO;
    }
    return YES;
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
    lab1.backgroundColor = [UIColor blackColor];
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
    lab5.backgroundColor = [UIColor blackColor];
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
    lab9.text = @"省市区";
    [scrollview addSubview:lab9];
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, 70, 40)];
    lab10.text = @"详细地址";
    [scrollview addSubview:lab10];
    
    UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(10, 500, 70, 40)];
    lab11.text = @"客户介绍";
    [scrollview addSubview:lab11];
    
    
    [self buchongInfo];
    
    text1.placeholder = @"请选择";
    text2.placeholder = @"请选择";
    text6.placeholder = @"请选择";
    text5.placeholder = @"请选择";
    text7.placeholder = @"请选择";
  
    scrollview.contentSize = CGSizeMake(0, 650);
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
    
    
    textview = [[UITextView alloc]initWithFrame:CGRectMake(90, 500,  SCREEN_WIDTH-100, 120)];
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
