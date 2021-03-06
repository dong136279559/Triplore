//
//  TPNoteBarButton.m
//  Triplore
//
//  Created by Sorumi on 17/6/29.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "TPNoteBarButton.h"

@interface TPNoteBarButton ()


@property (nonatomic, nonnull) UIImageView *imgView;
@end

@implementation TPNoteBarButton

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
//    [super setImage:image forState:state];
    if (self.imgView) {
        [self.imgView removeFromSuperview];
    }

    self.imgView = [[UIImageView alloc] initWithImage:image];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame) / 2;
    
    CGRect rect = CGRectMake((width-16)/2, 0, 16, height);

    self.imgView.frame = rect;
    [self addSubview:self.imgView];
    
}

//-(CGRect)imageRectForContentRect:(CGRect)contentRect {

//    NSLog(@"%f %f", CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
//    
//    CGFloat width = CGRectGetWidth(contentRect);
//    CGFloat height = CGRectGetHeight(contentRect) / 3 * 2;
//    
//    CGRect rect = CGRectMake((width-18)/2, 0, 18, height);
    
//    return rect;
//}

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat width = CGRectGetWidth(contentRect);
    CGFloat height = CGRectGetHeight(contentRect) / 2;
    
    CGRect rect = CGRectMake(0, height, width, height);
    
    return rect;
}

@end
