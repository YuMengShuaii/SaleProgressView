//
//  SaleProgressLableView.m
//  SaleProgressView
//
//  Created by LDD on 2017/11/27.
//  Copyright © 2017年 LDD. All rights reserved.
//

#import "SaleProgressLableView.h"

@implementation SaleProgressLableView{
   CGFloat currentProgress;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andFooter:(NSString *)footer
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat _width = self.frame.size.width;
        CGSize titleSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:self.frame.size.height/2] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        CGSize footerSize = [footer sizeWithFont:[UIFont boldSystemFontOfSize:self.frame.size.height/2] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        //添加最里层Label
        UILabel *intoHeaderLable = [self createLabel:title andFrame:CGRectMake(10, 0, titleSize.width, self.frame.size.height) andColor:[UIColor redColor]];
        UILabel *intoFooterLable = [self createLabel:title andFrame:CGRectMake(self.frame.size.width - footerSize.width -10, 0, footerSize.width+10, self.frame.size.height) andColor:[UIColor redColor]];
        [intoHeaderLable setTag:1123];
        [intoFooterLable setTag:1124];
        [self addSubview:intoHeaderLable];
        [self addSubview:intoFooterLable];
        //滑块
        _clipView = [[UIView alloc]initWithFrame:CGRectMake(-_width, 0,_width, self.frame.size.height)];
        _clipView.layer.cornerRadius = self.frame.size.height/2;
        _clipView.backgroundColor = [UIColor clearColor];
        //设置不显示超出的部分
        _clipView.clipsToBounds = YES;
        _clipView.userInteractionEnabled = YES;
        [self addSubview:_clipView];
        
        //显示
        _showView = [[UIView alloc]initWithFrame:CGRectMake(_width, 0, self.frame.size.width, self.frame.size.height)];
        UILabel *outHeaderLable = [self createLabel:title andFrame:CGRectMake(10, 0, titleSize.width, self.frame.size.height) andColor:[UIColor whiteColor]];
        UILabel *outFooterLable = [self createLabel:title andFrame:CGRectMake(self.frame.size.width - footerSize.width -10, 0, footerSize.width+10, self.frame.size.height) andColor:[UIColor whiteColor]];
        [outHeaderLable setTag:1125];
        [outFooterLable setTag:1126];
        [_showView addSubview:outHeaderLable];
        [_showView addSubview:outFooterLable];
        [_clipView addSubview:_showView];
    }
    return self;
}

-(void) reset{
    CGFloat _width = self.frame.size.width;
    _clipView.frame =CGRectMake(-_width, 0,_width, self.frame.size.height);
    _showView.frame =CGRectMake(_width, 0, self.frame.size.width, self.frame.size.height);
    currentProgress = 0;
}

-(void)setProgress:(CGFloat )progress
{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        if (progress>currentProgress) {
            for (int i = currentProgress; i<progress; i++) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    CGPoint clipCenter = _clipView.center;
                    CGPoint showCenter = _showView.center;
                    clipCenter.x +=  self.frame.size.width /100;
                    showCenter.x -=  self.frame.size.width / 100;
                    _clipView.center = clipCenter;
                    _showView.center = showCenter;
                });
            }
            currentProgress = progress;
        }
    });
}

-(void) setText:(NSString *)title title:(NSInteger )footer{
   UILabel *intoHeaderLable =   [self viewWithTag:1123];
   UILabel *intoFooderLable =   [self viewWithTag:1124];
   UILabel *outHeaderLable =   [_showView viewWithTag:1125];
   UILabel *outFooderLable =   [_showView viewWithTag:1126];
   CGSize titleSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:self.frame.size.height/2] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
   CGSize footerSize = [[NSString stringWithFormat:@"%d%%",footer] sizeWithFont:[UIFont boldSystemFontOfSize:self.frame.size.height/2] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    [intoHeaderLable setText:title];
    [outHeaderLable setText:title];
    [intoFooderLable setText:[NSString stringWithFormat:@"%d%%",footer]];
    [outFooderLable setText: [NSString stringWithFormat:@"%d%%",footer]];
    if (footer>=80) {
        [intoHeaderLable setFrame:CGRectMake(self.frame.size.width/2-titleSize.width/2, self.frame.size.height/2-titleSize.height/2, titleSize.width, titleSize.height)];
        [outHeaderLable setFrame:CGRectMake(self.frame.size.width/2-titleSize.width/2, self.frame.size.height/2-titleSize.height/2, titleSize.width, titleSize.height)];
        if (footer >= 100) {
            [intoFooderLable setHidden:YES];
            [outFooderLable setHidden:YES];
        }
    }else{
        //添加最里层Label
        intoHeaderLable.frame =CGRectMake(10, 0, titleSize.width, self.frame.size.height);
        outHeaderLable.frame = CGRectMake(10, 0, titleSize.width, self.frame.size.height);
        intoFooderLable.frame = CGRectMake(self.frame.size.width - footerSize.width-10, 0, footerSize.width+10, self.frame.size.height);
        outFooderLable.frame = CGRectMake(self.frame.size.width - footerSize.width-10, 0, footerSize.width+10, self.frame.size.height);
        [intoFooderLable setHidden:NO];
        [outFooderLable setHidden:NO];
    }
}

- (UILabel *)createLabel:(NSString *)title andFrame:(CGRect)rect andColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont boldSystemFontOfSize:self.frame.size.height/2];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


@end
