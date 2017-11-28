//
//  SaleProgressView.m
//  SaleProgressView
//
//  Created by LDD on 2017/11/24.
//  Copyright © 2017年 LDD. All rights reserved.
//

#import "SaleProgressView.h"
#import "SaleProgressLableView.h"
@implementation SaleProgressView{
    NSInteger progress;
    NSInteger count;
    NSInteger currentIndex;
    SaleProgressLableView *lable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void) reset{
    progress = 0;
    count = 0;
    currentIndex = 0;
    [lable reset];
}

-(void) setTotal:(NSInteger)_total andCurrentIndex:(NSInteger)_currentIndex{
    if (progress == 0 || currentIndex>progress) {
        count = _total;
        dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(concurrentQueue, ^(){
            for (NSInteger i = currentIndex; i<_currentIndex; i++) {
                currentIndex++;
                progress = ((float)currentIndex/count*100);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self setNeedsDisplay];
                    [lable setProgress:progress];
                });
            }
        });
    }
}

-(void) initUI{
    progress = 0;
    currentIndex = 0;
    count = 0;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor clearColor];
    lable = [[SaleProgressLableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andTitle:@"已售0件" andFooter:@""];
    [self addSubview:lable];
    [lable setBackgroundColor:[UIColor clearColor]];
}

- (void)drawRect:(CGRect)rect {
    CGFloat bfWidth = self.frame.size.width/100*(100-progress);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *image = [UIImage imageNamed:@"sale_progress_bg.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];//在坐标中画出图片
    CGContextDrawImage(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), image.CGImage);//使用这个使图片上下颠倒了，参考
    UIImage *imagefg = [UIImage imageNamed:@"sale.progress_fg.png"];
    [imagefg drawInRect:CGRectMake(-bfWidth, 0, self.frame.size.width, self.frame.size.height)];//在坐标中画出图片
    CGContextDrawImage(context, CGRectMake(-bfWidth, 0, self.frame.size.width, self.frame.size.height), imagefg.CGImage);//使用这个使图片上下颠倒了，参考
    UIFont  *font = [UIFont systemFontOfSize:self.frame.size.height/2];//设置
    NSString *header = [NSString stringWithFormat:@"已售%d件",currentIndex];
    if (progress>80) {
        header = @"即将售完";
    }
    if(progress == 100) {
        header = @"已售完";
        CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    }
    [lable setText:header title:progress];
    CGContextSaveGState(context);
}


@end
