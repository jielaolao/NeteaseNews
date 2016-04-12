//
//  LoopViewCell.m
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import "LoopViewCell.h"
#import <UIImageView+WebCache.h>

@interface LoopViewCell ()
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation LoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [self addSubview:iconView];
    }
    return self;
}

- (void)setURL:(NSURL *)URL {
    _URL = URL;
    [self.iconView sd_setImageWithURL:URL];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = self.bounds;
}
@end
