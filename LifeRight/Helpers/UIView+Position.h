//
//  UIView+Position.h
//  LifeRight
//
//  Created by Kevin Jenkins on 12/15/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Position)

- (CGPoint)origin;
- (CGSize)size;

- (CGFloat)height;
- (CGFloat)width;

- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)left;
- (CGFloat)right;

- (void)setTop:(CGFloat)value;
- (void)setBottom:(CGFloat)value;
- (void)setLeft:(CGFloat)value;
- (void)setRight:(CGFloat)value;

- (void)setHeight:(CGFloat)value;
- (void)setWidth:(CGFloat)value;

- (void)setOrigin:(CGPoint)newOrigin;
- (void)setSize:(CGSize)newSize;

@end
