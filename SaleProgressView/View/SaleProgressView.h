//
//  SaleProgressView.h
//  SaleProgressView
//
//  Created by LDD on 2017/11/24.
//  Copyright © 2017年 LDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleProgressView : UIView

-(void) setTotal:(NSInteger)_total andCurrentIndex:(NSInteger)_currentIndex;

-(void) reset;
@end
