//
//  ViewController.m
//  SaleProgressView
//
//  Created by LDD on 2017/11/24.
//  Copyright © 2017年 LDD. All rights reserved.
//

#import "ViewController.h"
#import "SaleProgressView.h"
#import "SaleProgressLableView.h"
@interface ViewController ()

@end

@implementation ViewController{
    NSInteger index ;
    SaleProgressView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
     view = [[SaleProgressView alloc] initWithFrame:CGRectMake(100, 100, 80, 15)];
    [self.view addSubview:view];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 100, 35)];
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(100, 250, 120, 30)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

-(void) refresh{
    index ++;
    [view reset];
    [view setTotal:200 andCurrentIndex:199];
    //[view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
