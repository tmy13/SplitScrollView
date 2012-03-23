//
//  splitScrollView.h
//  restfulViewTest
//
//  Created by 唐 梦韵 on 12-3-23.
//  Copyright (c) 2012年 kingtrust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplitScrollView : UIView <UIScrollViewDelegate>
{
    UIScrollView *leftScrollView;
    UIScrollView *rightScrollView;
    CGPoint startOffset;
    CGFloat rate;
    BOOL touchLeft;
}

- (id)initWithFrame:(CGRect)frame 
          LeftImage:(UIImage *)leftImage 
         RightImage:(UIImage *)rightImage;

- (id)initWithFrame:(CGRect)frame 
           LeftSize:(CGSize)leftSize 
          RightSize:(CGSize)rightSize;

- (void)addSubviewIntoLeftScrollView:(UIView *)view;
- (void)addSubviewIntoRightScrollView:(UIView *)view;

@end
