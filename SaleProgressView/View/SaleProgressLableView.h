//
//  SaleProgressLableView.h
//  SaleProgressView
//
//  Created by LDD on 2017/11/27.
//  Copyright © 2017年 LDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleProgressLableView : UIView

//顶层View
@property(nonatomic,strong) UIView * showView;
//中间层View
@property(nonatomic,strong) UIView * clipView;

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andFooter:(NSString *)footer;

- (void)setProgress:(CGFloat )progress;

-(void) setText:(NSString *)title title:(NSInteger )footer;

-(void) reset;
@end
