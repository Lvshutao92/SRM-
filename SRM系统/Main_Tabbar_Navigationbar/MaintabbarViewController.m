//
//  MaintabbarViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "MaintabbarViewController.h"
#import "A_ViewController.h"
#import "B_ViewController.h"
#import "Center_ViewController.h"
#import "C_ViewController.h"
#import "D_ViewController.h"




@interface MaintabbarViewController ()

@end

@implementation MaintabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (instancetype)init {
    if (self = [super init]) {
        A_ViewController *oneVc = [[A_ViewController alloc]init];
        MainNavigationViewController *aaa = [[MainNavigationViewController alloc]initWithRootViewController:oneVc];
        aaa.tabBarItem.image = [UIImage imageNamed:@"1"];
        aaa.title = @"提醒";
        aaa.tabBarItem.selectedImage = [UIImage imageNamed:@"01"];
        
        
        B_ViewController *bVc = [[B_ViewController alloc]init];
        MainNavigationViewController *bbb = [[MainNavigationViewController alloc]initWithRootViewController:bVc];
        bbb.tabBarItem.image = [UIImage imageNamed:@"2"];
        bbb.title = @"通讯录";
        bbb.tabBarItem.selectedImage = [UIImage imageNamed:@"02"];
        
        
        
        
        Center_ViewController *centerVc = [[Center_ViewController alloc]init];
        //MainNavigationViewController *center = [[MainNavigationViewController alloc]initWithRootViewController:centerVc];
        centerVc.tabBarItem.image = [UIImage imageNamed:@"3"];
        centerVc.title = @"工作台";
        centerVc.tabBarItem.selectedImage = [UIImage imageNamed:@"03"];
        
        
        C_ViewController *cVc = [[C_ViewController alloc]init];
        MainNavigationViewController *ccc = [[MainNavigationViewController alloc]initWithRootViewController:cVc];
        ccc.tabBarItem.image = [UIImage imageNamed:@"4"];
        ccc.title = @"统计";
        ccc.tabBarItem.selectedImage = [UIImage imageNamed:@"04"];
        
        D_ViewController *dVc = [[D_ViewController alloc]init];
        MainNavigationViewController *ddd = [[MainNavigationViewController alloc]initWithRootViewController:dVc];
        ddd.tabBarItem.image = [UIImage imageNamed:@"5"];
        ddd.title = @"更多";
        ddd.tabBarItem.selectedImage = [UIImage imageNamed:@"05"];
        
        
        self.tabBar.tintColor = RGBACOLOR(30, 144, 255, 1);
        self.viewControllers = @[aaa,bbb,centerVc,ccc,ddd];
    }
    return self;
}
@end
