//
//  LYRUIIconStatusView.m
//  Pods
//
//  Created by Mike Hernas on 14/11/2018.
//

#import "LYRUIIconStatusView.h"
#import "LYRUIConfiguration+DependencyInjection.h"
#import "LYRUIImageCreating.h"
#import "LYRUIMessageType.h"
#import <LayerKit/layerKit.h>

@interface LYRUIIconStatusView ()
@property (nonatomic, readonly, strong) id<LYRUIImageCreating> imageFactory;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation LYRUIIconStatusView

@synthesize layerConfiguration = _layerConfiguration;

- (instancetype)initWithConfiguration:(LYRUIConfiguration *)configuration {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.layerConfiguration = configuration;
        [self lyr_commonInitWithCoder:nil frame:CGRectZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self lyr_commonInitWithCoder:nil frame:frame];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self lyr_commonInitWithCoder:aDecoder frame:CGRectZero];
    }
    return self;
}

- (void)lyr_commonInitWithCoder:(NSCoder *)aDecoder frame:(CGRect)frame {
    self.backgroundColor = UIColor.clearColor;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.backgroundColor = UIColor.clearColor;
    [self addSubview:imageView];
    
    [imageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [imageView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [imageView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    
    [self.widthAnchor constraintEqualToConstant:15.0].active = YES;
    [self.heightAnchor constraintEqualToConstant:10.0].active = YES;
    
    self.imageView = imageView;
}

- (void)configureWithMessage:(LYRUIMessageType *)message {
    
    switch (message.status.status) {
        case LYRUIMessageStatusNew:
            self.imageView.image = nil;
            break;
        case LYRUIMessageStatusPending:
            if([self isOutgoingMessage:message]) {
                self.imageView.image = [self.imageFactory imageNamed:@"statusPendingOutgoing"];
            } else {
                self.imageView.image = [self.imageFactory imageNamed:@"statusPending"];
            }
            break;
            
        case LYRUIMessageStatusSent:
        case LYRUIMessageStatusDelivered:
            if([self isOutgoingMessage:message]) {
                self.imageView.image = [self.imageFactory imageNamed:@"statusDeliveredOutgoing"];
            } else {
                self.imageView.image = [self.imageFactory imageNamed:@"statusDelivered"];
            }
            break;
            
        case LYRUIMessageStatusRead:
            self.imageView.image = [self.imageFactory imageNamed:@"statusRead"];
            break;
    }
}

- (BOOL)isOutgoingMessage:(LYRUIMessageType *)message {
    NSString *currentUserId = self.layerConfiguration.client.authenticatedUser.userID;
    return [message.sender.userID isEqualToString:currentUserId];
}


#pragma mark - LYRUIConfigurable Implementation

- (void)setLayerConfiguration:(LYRUIConfiguration *)layerConfiguration {
    _layerConfiguration = layerConfiguration;
    _imageFactory = [self.layerConfiguration.injector protocolImplementation:@protocol(LYRUIImageCreating) forClass:[self class]];
}
@end
