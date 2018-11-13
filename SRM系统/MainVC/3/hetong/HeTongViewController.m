//
//  HeTongViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/12.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "HeTongViewController.h"

@interface HeTongViewController ()

@end

@implementation HeTongViewController

- (void)clickback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *btnview = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnview addSubview:btn];
    [btn addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btnview];
    self.navigationItem.leftBarButtonItem = bar;
    // Do any additional setup after loading the view.
    [self setupscrollviewBtn];
}
- (void)setupscrollviewBtn{
    NSMutableArray *arr1 = [@[@"待生成",@"已生成",@"已邮寄",@"已回签",@"执行中",@"执行完",@"已作废"]mutableCopy];
    NSMutableArray *arr2 = [@[@"ht_dsc",@"ht_ysc",@"ht_yyj",@"ht_yhq",@"ht_zxz",@"ht_zxw",@"ht_yzf"]mutableCopy];
    int b = 0;
    int hangshu;
    if (arr1.count % 4 == 0 ) {
        hangshu = (int )arr1.count / 4;
    } else {
        hangshu = (int )arr1.count / 4 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 4; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < arr1.count) {
                btn.frame = CGRectMake((0  + j * SCREEN_WIDTH/4), kNavBarHAbove7+(i * 120) ,SCREEN_WIDTH/4, 120);
                btn.tag = b;
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.font = FONT(14);
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clicktopBtn:) forControlEvents:UIControlEventTouchUpInside];
                //                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                //                [btn.layer setBorderWidth:0.5f];
                //                [btn.layer setMasksToBounds:YES];
                [self.view addSubview:btn];
                if (b > arr1.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}


- (void)clicktopBtn:(UIButton *)sender{
    
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
