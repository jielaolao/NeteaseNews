//
//  LoopViewFlowLayout.m
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import "LoopViewFlowLayout.h"

@implementation LoopViewFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
}

@end
