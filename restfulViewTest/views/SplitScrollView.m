//
//  splitScrollView.m
//  restfulViewTest
//
//  Created by 唐 梦韵 on 12-3-23.
//  Copyright (c) 2012年 kingtrust. All rights reserved.
//

#import "SplitScrollView.h"

@implementation SplitScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame 
          LeftImage:(UIImage *)leftImage 
         RightImage:(UIImage *)rightImage
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
        leftScrollView = [[UIScrollView alloc] 
                          initWithFrame:
                          CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        UIImageView *leftIV = [[UIImageView alloc] initWithImage:leftImage];
        leftScrollView.contentSize = CGSizeMake(leftScrollView.frame.size.width, leftIV.frame.size.height);
        [leftScrollView addSubview:leftIV];
        leftScrollView.delegate = self;
        leftScrollView.bounces = NO;
        [leftIV release];
        
        [self addSubview:leftScrollView];
        [leftScrollView release];
        
        rightScrollView = [[UIScrollView alloc] 
                          initWithFrame:
                          CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        UIImageView *rightIV = [[UIImageView alloc] initWithImage:rightImage];
        rightScrollView.contentSize = CGSizeMake(rightScrollView.frame.size.width, rightIV.frame.size.height);
        [rightScrollView addSubview:rightIV];
        rightScrollView.delegate = self;
        rightScrollView.bounces = NO;
        [rightIV release];
        
        [self addSubview:rightScrollView];
        [rightScrollView release];
        
        //左右高度的比例
        rate = (leftIV.frame.size.height-frame.size.height) / (rightIV.frame.size.height-frame.size.height);
        NSLog(@"left %.2f right %.2f rate %.2f", 
              leftIV.frame.size.height, rightIV.frame.size.height, rate);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame 
           LeftSize:(CGSize)leftSize 
          RightSize:(CGSize)rightSize
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
        leftScrollView = [[UIScrollView alloc] 
                          initWithFrame:
                          CGRectMake(0, 0, leftSize.width, frame.size.height)];
        leftScrollView.contentSize = CGSizeMake(leftSize.width, leftSize.height);
        leftScrollView.delegate = self;
        leftScrollView.bounces = NO;
        
        [self addSubview:leftScrollView];
        [leftScrollView release];
        
        rightScrollView = [[UIScrollView alloc] 
                           initWithFrame:
                           CGRectMake(leftSize.width, 0, rightSize.width, frame.size.height)];
        rightScrollView.contentSize = CGSizeMake(rightSize.width, rightSize.height);
        rightScrollView.delegate = self;
        rightScrollView.bounces = NO;
        
        [self addSubview:rightScrollView];
        [rightScrollView release];
        
        //rate of the left & right UIScrollView
        rate = (leftSize.height-frame.size.height) / (rightSize.height-frame.size.height);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)addSubviewIntoLeftScrollView:(UIView *)view
{
    [leftScrollView addSubview:view];
    // if the view.frame.size.height lagrer than the leftSize, reset the contentSize and rate
    if (view.frame.size.height > leftScrollView.contentSize.height) {
        leftScrollView.contentSize = 
        CGSizeMake(leftScrollView.contentSize.width, view.frame.size.height);
        rate = (leftScrollView.contentSize.height-self.frame.size.height) /
        (rightScrollView.contentSize.height-self.frame.size.height);
    }
}

- (void)addSubviewIntoRightScrollView:(UIView *)view
{
    [rightScrollView addSubview:view];
    // if the view.frame.size.height lagrer than the rightSize, reset the contentSize and rate
    if (view.frame.size.height > leftScrollView.contentSize.height) {
        rightScrollView.contentSize = 
        CGSizeMake(rightScrollView.contentSize.width, view.frame.size.height);
        rate = (leftScrollView.contentSize.height-self.frame.size.height) /
        (rightScrollView.contentSize.height-self.frame.size.height);
    }
}

- (void)dealloc
{
    
}

#pragma scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint leftOffset = leftScrollView.contentOffset;
    CGPoint rightOffset = rightScrollView.contentOffset;
    if (scrollView == leftScrollView && touchLeft) {
        CGFloat offset = leftOffset.y - startOffset.y;
        CGPoint newRightOffset = rightOffset;
        newRightOffset.y += (offset/rate);
        //NSLog(@"left:\n leftOffset %.2f, rightOffset %.2f", leftOffset.y, newRightOffset.y);
        [rightScrollView setContentOffset:newRightOffset];
        startOffset = leftOffset;
    }
    if (scrollView == rightScrollView && !touchLeft) {
        CGFloat offset = rightOffset.y - startOffset.y;
        CGPoint newLeftOffset = leftOffset;
        newLeftOffset.y += (offset/rate);
        //NSLog(@"left:\n leftOffset %.2f, rightOffset %.2f", newLeftOffset.y, rightOffset.y);
        [leftScrollView setContentOffset:newLeftOffset];
        startOffset = rightOffset;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == leftScrollView) {
        startOffset = leftScrollView.contentOffset;
        touchLeft = YES;
    }
    if (scrollView == rightScrollView) {
        startOffset = rightScrollView.contentOffset;
        touchLeft = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{    
    //startOffset = CGPointZero;
}

@end
