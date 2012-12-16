//
//  LRCollectionViewCell.m
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRCollectionViewCell.h"
#import "LRTweetContent.h"
#import "UIView+Position.h"

static CGFloat margin = 5.0;
static CGFloat image_height = 250.0;
static CGRect text_view_frame = {0.0,0.0,250.0,0.0};
static CGFloat label_height = 30.0;
static CGFloat cell_width = 320.0;
static CGFloat sent_view_height = 75.0;
static CGFloat text_view_margin = 24.0;

@implementation LRCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)setupWithContent:(LRCellContent *)contentObject
{
    self.content = contentObject;

    self.authorLabel.text = contentObject.author;
    self.contentTextView.text = contentObject.message;
    self.avatarImageView.image = contentObject.avatarImage;
    self.contentImageView.image = contentObject.image;
    self.contentImageView.size = CGSizeMake(250.0,250.0);

    [self setPostedTime:contentObject.date];
    self.viaLabel.text = contentObject.preSourceText;
    self.sourceImageView.image = contentObject.sourceImage;

    [self resizeToFitContent];
}
- (void)setPostedTime:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.postedTimeLabel.text = [NSString stringWithFormat:@"posted %@", [dateFormatter stringFromDate:date]];
}
- (void)resizeToFitContent
{
    CGFloat bottomOfContent = 0.0;
    self.contentImageView.top = bottomOfContent;
    self.authorLabelContainerView.top = bottomOfContent + margin;

    if (self.content.hasImage)
    {
        self.contentImageView.height = image_height;
        bottomOfContent = self.contentImageView.height + margin;
    } else {
        // no image so the bottom of the content is from the label, not the image
        self.contentImageView.height = 0.0;
        bottomOfContent = self.authorLabelContainerView.bottom + margin;
    }

    self.contentTextView.top = bottomOfContent;

    if (self.content.hasMessage)
    {
        CGSize textViewSize = [self.content.message sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(text_view_frame.size.width, 500.0)];
        self.contentTextView.height = textViewSize.height + text_view_margin;
        bottomOfContent = self.contentTextView.bottom + margin;
    } else {
        self.contentTextView.height = 0.0;
    }

    self.sentInfoViewContainer.top = bottomOfContent;
    bottomOfContent = self.sentInfoViewContainer.bottom;

    self.contentView.autoresizesSubviews = NO;
    self.contentView.height = bottomOfContent;
    self.height = bottomOfContent;
    [self setNeedsDisplay];
}

#pragma mark - Size Estimation
+ (CGSize)predictSizeForContent:(LRCellContent*)content
{
    CGFloat bottomOfContent = 0.0;

    if (content.hasImage)
    {
        bottomOfContent += image_height + margin;
    } else {
        // add author label height
        bottomOfContent += label_height + margin;
    }

    // add text height
    CGSize textViewSize = [content.message sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(text_view_frame.size.width, 500.0)];
    bottomOfContent += textViewSize.height + margin + text_view_margin;

    // add sent view hegith
    bottomOfContent += sent_view_height;

    CGSize contentSize = CGSizeMake(cell_width, bottomOfContent);
    return contentSize;
}

@end
