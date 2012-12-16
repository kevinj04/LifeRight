//
//  LRCollectionViewCell.m
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRCollectionViewCell.h"
#import "LRTweet.h"
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
    CGFloat bottomOfContent = self.contentImageView.top;

    if (nil == self.contentImageView.image)
    {
        // no image so the bottom of the content is from the label, not the image
        self.authorLabel.top = margin;
        bottomOfContent = self.authorLabelContainerView.bottom;
    } else {
        bottomOfContent += self.contentImageView.height + margin;
    }

    self.contentTextView.top = bottomOfContent;
    CGSize textViewSize = [self.content.message sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(text_view_frame.size.width, 500.0)];
    self.contentTextView.height = textViewSize.height + text_view_margin;
    bottomOfContent = self.contentTextView.bottom + margin;

    self.sentInfoViewContainer.top = bottomOfContent;
    bottomOfContent = self.sentInfoViewContainer.bottom;

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
        bottomOfContent += label_height;
    }

    // add text height
    CGSize textViewSize = [content.message sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(text_view_frame.size.width, 500.0)];
    bottomOfContent += textViewSize.height + margin + text_view_margin;

    // add sent view hegith
    bottomOfContent += sent_view_height;

    CGSize contentSize = CGSizeMake(cell_width, bottomOfContent);
    NSLog(@"Content size for %@ is %@", content, NSStringFromCGSize(contentSize));
    return contentSize;
}

@end
