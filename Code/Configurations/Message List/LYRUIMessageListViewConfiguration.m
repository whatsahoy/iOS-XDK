//
//  LYRUIMessageListViewConfiguration.m
//  Layer-UI-iOS
//
//  Created by Łukasz Przytuła on 18.08.2017.
//  Copyright (c) 2017 Layer. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "LYRUIMessageListViewConfiguration.h"
#import "LYRUIConfiguration+DependencyInjection.h"
#import "LYRUIListSection.h"
#import "LYRUIListDataSource.h"
#import "LYRUIMessageListDelegate.h"
#import "LYRUIMessageListLayout.h"
#import "LYRUIMessageCollectionViewCell.h"
#import "LYRUIMessageListView.h"
#import "LYRUIMessageItemView.h"
#import "LYRUIMessageCellConfiguration.h"
#import "LYRUIListHeaderView.h"
#import <LayerKit/LayerKit.h>
#import "LYRUIListCellConfiguring.h"
#import "LYRUIListSupplementaryViewConfiguring.h"
#import "LYRUIMessageListTimeSupplementaryViewConfiguration.h"
#import "LYRUIMessageListMessageTimeView.h"
#import "LYRUIMessageListStatusSupplementaryViewConfiguration.h"
#import "LYRUIMessageListMessageStatusView.h"
#import "LYRUIListLoadingIndicatorConfiguration.h"
#import "LYRUIListLoadingIndicatorView.h"
#import "LYRUIMessageCollectionViewCell.h"
#import "LYRUIMessageListTypingIndicatorsController.h"
#import "LYRUIPanelTypingIndicatorView.h"
#import "LYRUITypingIndicatorFooterConfiguration.h"
#import "LYRUIBubbleTypingIndicatorCollectionViewCell.h"
#import "LYRUITypingIndicatorCellConfiguration.h"

static NSTimeInterval const LYRUIMessageListViewDefaultGroupintTimeInterval = 60.0 * 30.0;
static NSInteger const LYRUIMessageListViewDefaultPageSize = 30;

@implementation LYRUIMessageListViewConfiguration
@synthesize layerConfiguration = _layerConfiguration;

- (instancetype)initWithConfiguration:(LYRUIConfiguration *)configuration {
    self = [super init];
    if (self) {
        self.layerConfiguration = configuration;
    }
    return self;
}

- (void)setupListView:(LYRUIMessageListView *)messageListView {
    id<LYRUIDependencyInjection> injector = self.layerConfiguration.injector;
    
    messageListView.messageGroupingTimeInterval = LYRUIMessageListViewDefaultGroupintTimeInterval;
    messageListView.pageSize = LYRUIMessageListViewDefaultPageSize;
    
    LYRUIMessageListLayout *layout = [injector layoutForViewClass:[LYRUIMessageListView class]];
    
    LYRUIMessageCellConfiguration *cellConfiguration = [injector configurationForViewClass:[LYRUIMessageCollectionViewCell class]];
    
    LYRUIMessageListTimeSupplementaryViewConfiguration *messageTimeViewConfiguration =
        [injector configurationForViewClass:[LYRUIMessageListMessageTimeView class]];
    messageTimeViewConfiguration.messageListView = messageListView;
    
    LYRUIMessageListStatusSupplementaryViewConfiguration *messageStatusViewConfiguration =
        [injector configurationForViewClass:[LYRUIMessageListMessageStatusView class]];
    
    LYRUIListLoadingIndicatorConfiguration *loadingIndicatorConfiguration =
        [injector configurationForViewClass:[LYRUIListLoadingIndicatorView class]];
    
    LYRUIMessageListTypingIndicatorsController *typingIndicatorConfigurator =
        [injector objectOfType:[LYRUIMessageListTypingIndicatorsController class]];
    typingIndicatorConfigurator.collectionView = messageListView.collectionView;
    messageListView.typingIndicatorsController = typingIndicatorConfigurator;
    
    LYRUITypingIndicatorCellConfiguration *typingIndicatorCellConfiguration =
        [injector configurationForViewClass:[LYRUIBubbleTypingIndicatorCollectionViewCell class]];
    
    LYRUITypingIndicatorFooterConfiguration *typingIndicatorFooterConfiguration =
        [injector configurationForViewClass:[LYRUIPanelTypingIndicatorView class]];
    
    [self registerCellsWithConfigurations:@[cellConfiguration,
                                            typingIndicatorCellConfiguration]
                         inCollectionView:messageListView.collectionView];
    [self registerSupplementaryViewsWithConfigurations:@[messageTimeViewConfiguration,
                                                         messageStatusViewConfiguration,
                                                         loadingIndicatorConfiguration,
                                                         typingIndicatorFooterConfiguration]
                                      inCollectionView:messageListView.collectionView];
    
    messageListView.layout = layout;
    
    LYRUIListDataSource *dataSource = [[LYRUIListDataSource alloc] init];
    cellConfiguration.listDataSource = dataSource;
    [dataSource registerCellConfiguration:cellConfiguration];
    [dataSource registerCellConfiguration:typingIndicatorCellConfiguration];
    [dataSource registerSupplementaryViewConfiguration:messageTimeViewConfiguration];
    [dataSource registerSupplementaryViewConfiguration:messageStatusViewConfiguration];
    [dataSource registerSupplementaryViewConfiguration:loadingIndicatorConfiguration];
    [dataSource registerSupplementaryViewConfiguration:typingIndicatorFooterConfiguration];
    messageListView.dataSource = dataSource;
    
    LYRUIMessageListDelegate *delegate = [[LYRUIMessageListDelegate alloc] init];
    [delegate registerCellSizeCalculation:cellConfiguration];
    [delegate registerCellSizeCalculation:typingIndicatorCellConfiguration];
    [delegate registerSupplementaryViewSizeCalculation:messageTimeViewConfiguration];
    [delegate registerSupplementaryViewSizeCalculation:messageStatusViewConfiguration];
    [delegate registerSupplementaryViewSizeCalculation:loadingIndicatorConfiguration];
    [delegate registerSupplementaryViewSizeCalculation:typingIndicatorFooterConfiguration];
    delegate.loadingDelegate = loadingIndicatorConfiguration;
    messageListView.delegate = delegate;
}

#pragma mark - Cells and Supplementary Views setup

- (void)registerCellsWithConfigurations:(NSArray<id<LYRUIListCellConfiguring>> *)cellConfigurations
                       inCollectionView:(UICollectionView *)collectionView {
    for (id<LYRUIListCellConfiguring> configuration in cellConfigurations) {
        [configuration registerCellInCollectionView:collectionView];
    }
}

- (void)registerSupplementaryViewsWithConfigurations:(NSArray<id<LYRUIListSupplementaryViewConfiguring>> *)supplementaryViewConfigurations
                                    inCollectionView:(UICollectionView *)collectionView {
    for (id<LYRUIListSupplementaryViewConfiguring> configuration in supplementaryViewConfigurations) {
        [configuration registerSupplementaryViewInCollectionView:collectionView];
    }
}

@end
