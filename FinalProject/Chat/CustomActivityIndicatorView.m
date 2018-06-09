//
//  CustomActivityIndicatorView.m
//  FinalProject
//
//  Created by Kellie Banzon on 06/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

#import "CustomActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomActivityIndicatorView ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation CustomActivityIndicatorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)_init {
    self.animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    self.animation.fromValue = [NSNumber numberWithFloat:0.0f];
    self.animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    self.animation.duration = 1.0f;
    self.animation.repeatCount = HUGE_VAL;
    
    if (!self.frame.size.width) {
        return;
    }
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    [self.imageView removeFromSuperview];
    self.imageView = nil;
    
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    
    if (self.subviews.count) {
        [self.subviews[0] setHidden:YES];
    }
    
    self.image = [UIImage imageNamed:@"loading"];
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    
    self.backgroundImage = [UIImage imageNamed:@"bg_loading"];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:self.backgroundImage];
    
    if (self.hidesWhenStopped && !self.isAnimating) {
        self.imageView.hidden = YES;
        self.backgroundImageView.hidden = YES;
    }
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.imageView];
    
    
    if (![self.imageView.layer animationForKey:@"animation"]) {
        [self.imageView.layer addAnimation:self.animation forKey:@"animation"];
    }
    
    self.imageView.frame = (CGRect){(self.bounds.size.width - self.imageView.frame.size.width) / 2, (self.bounds.size.height - self.imageView.frame.size.height) / 2, self.imageView.frame.size};
    self.backgroundImageView.frame = (CGRect){(self.bounds.size.width - self.backgroundImageView.frame.size.width) / 2, (self.bounds.size.height - self.backgroundImageView.frame.size.height) / 2, self.backgroundImageView.frame.size};
}

- (void)setHidesWhenStopped:(BOOL)hidesWhenStopped {
    [super setHidesWhenStopped:hidesWhenStopped];
    
    if (self.hidesWhenStopped && !self.isAnimating) {
        self.imageView.hidden = YES;
        self.backgroundImageView.hidden = YES;
    }
    else {
        self.imageView.hidden = NO;
        self.backgroundImageView.hidden = NO;
    }
}

- (void)startAnimating {
    [super startAnimating];
    
    self.imageView.hidden = NO;
    self.backgroundImageView.hidden = NO;
    
    [self.imageView.layer addAnimation:self.animation forKey:@"animation"];
}

- (void)stopAnimating {
    [super stopAnimating];
    
    if (self.hidesWhenStopped) {
        self.imageView.hidden = YES;
        self.backgroundImageView.hidden = YES;
    }
    
    [self.imageView.layer removeAllAnimations];
}

@end
