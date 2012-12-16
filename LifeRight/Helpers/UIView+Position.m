//
//  UIView+Position.m
//  LifeRight
//
//  Created by Kevin Jenkins on 12/15/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "UIView+Position.h"

@implementation UIView (Position)

- (CGPoint)origin
{
    return self.frame.origin;
}
- (CGSize)size
{
    return  self.frame.size;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)x
{
    return self.frame.origin.y;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}
- (CGFloat)bottom
{
    return self.top + self.height;
}
- (CGFloat)left
{
    return self.frame.origin.x;
}
- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setX:(CGFloat)newX;
{
    self.origin = CGPointMake(newX, self.y);
}

- (void)setY:(CGFloat)newY
{
    self.origin = CGPointMake(self.x, newY);
}

- (void)setTop:(CGFloat)value
{
    self.frame = CGRectMake(self.left, value, self.width, self.height);
}
- (void)setBottom:(CGFloat)value
{
    self.frame = CGRectMake(self.left, value-self.height, self.width, self.height);
}
- (void)setLeft:(CGFloat)value
{
    self.frame = CGRectMake(value, self.top, self.width, self.height);
}
- (void)setRight:(CGFloat)value
{
    self.frame = CGRectMake(value-self.width, self.top, self.width, self.height);
}

- (void)setHeight:(CGFloat)value
{
    self.frame = CGRectMake(self.left, self.top, self.width, value);
}
- (void)setWidth:(CGFloat)value
{
    self.frame = CGRectMake(self.left, self.top, value, self.height);
}

- (void)setOrigin:(CGPoint)newOrigin
{
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.width, self.height);
}
- (void)setSize:(CGSize)newSize
{
    self.frame = CGRectMake(self.left, self.top, newSize.width, newSize.height);
}


@end
