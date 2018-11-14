//
//  LYRUIIconStatusView.m
//  Pods
//
//  Created by Mike Hernas on 14/11/2018.
//

#import "LYRUIIconStatusView.h"
#import "LYRUIConfiguration+DependencyInjection.h"
#import "LYRUIImageCreating.h"

@interface LYRUIIconStatusView ()
@property (nonatomic, readonly, strong) id<LYRUIImageCreating> imageFactory;
@end

@implementation LYRUIIconStatusView

@synthesize layerConfiguration = _layerConfiguration;

- (instancetype)initWithConfiguration:(LYRUIConfiguration *)configuration {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self lyr_commonInitWithCoder:nil frame:CGRectZero];
        self.layerConfiguration = configuration;
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
    [self addSubview:imageView];
    
}


#pragma mark - LYRUIConfigurable Implementation

- (void)setLayerConfiguration:(LYRUIConfiguration *)layerConfiguration {
    _layerConfiguration = layerConfiguration;
    _imageFactory = [self.layerConfiguration.injector protocolImplementation:@protocol(LYRUIImageCreating) forClass:[self class]];
}
@end
