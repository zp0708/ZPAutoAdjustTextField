//
//  ViewController.m
//  customTest
//
//  Created by ZP on 15/11/6.
//  Copyright © 2015年 ZP. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ZPAutoAdjustTextField.h"
#import "UIView+Extension.h"

@interface ViewController () <CustomTextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *second = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:second animated:YES];
}

@end
