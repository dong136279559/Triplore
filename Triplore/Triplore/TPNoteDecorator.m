//
//  TPNoteDecorator.m
//  Triplore
//
//  Created by 宋 奎熹 on 2017/6/15.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "TPNoteDecorator.h"
#import "TPNoteTitleViewGreen.h"
#import "TPNote.h"
#import "TPNoteTemplate.h"
#import "UIImageView+Decorator.h"

@implementation TPNoteDecorator

//  标题 Label ：Tag = 1

+ (NSArray<UIView *> *)getNoteViews:(TPNote *)note andTemplate:(TPNoteTemplate *)template{
    NSMutableArray<UIView *> *tempViews = [[NSMutableArray alloc] init];
    
    //最顶上 View
    [template.tem_titleView setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 80)];
    [template.tem_titleView setDate:note.createTime];
    [template.tem_titleView setTitleTextColor:template.tem_titleColor];
    [tempViews addObject:template.tem_titleView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 40)];
    [titleLabel setText:note.title];
    [titleLabel setFont:[UIFont fontWithName:template.tem_font size:35.0]];
    [titleLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    [titleLabel setTag:1];
    [titleLabel setNumberOfLines:0];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:template.tem_titleColor];
    [tempViews addObject:titleLabel];
    
    for(UIView *view in note.views){
        if([view isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)view;
            [label setNumberOfLines:0];
            [label setTextAlignment:NSTextAlignmentLeft];
            [label setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 40)];
            [label setFont:[UIFont fontWithName:template.tem_font size:16.0]];
            [label setTextColor:template.tem_textColor];
            [label setAdjustsFontSizeToFitWidth:YES];
            [label sizeToFit];
            [tempViews addObject:label];
        }else if([view isKindOfClass:[UIImageView class]]){
            UIImageView *oldView = (UIImageView *)view;
            CGRect newFrame = CGRectMake(0,
                                         0,
                                         SCREEN_WIDTH - 40,
                                         CGRectGetHeight(oldView.frame) / CGRectGetWidth(oldView.frame) * (SCREEN_WIDTH - 40));
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:newFrame];
            [imageView setImage:oldView.image];
            switch (template.tem_num) {
                case TPGreen:
                    [imageView decorateWithGreen];
                    break;
                case TPBrown:
                    [imageView decorateWithBrown];
                    break;
                default:
                    break;
            }
            [tempViews addObject:imageView];
        }
    }
    
    [tempViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setBackgroundColor:template.tem_color];
    }];
    
    return [NSArray arrayWithArray:tempViews];
}

@end
