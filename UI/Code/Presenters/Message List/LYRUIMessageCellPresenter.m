//
//  LYRUIMessageCellPresenter.m
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 28.08.2017.
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

#import "LYRUIMessageCellPresenter.h"
#import "LYRUIConfiguration+DependencyInjection.h"
#import "LYRUIMessageItemViewPresenter.h"
#import "LYRUIMessageItemAccessoryViewProviding.h"
#import "LYRUIParticipantsFiltering.h"
#import "LYRUIMessageCollectionViewCell.h"
#import "LYRUIMessageItemView.h"
#import "LYRUIListDataSource.h"
#import "LYRUIListSection.h"
#import "UIView+LYRUISafeArea.h"
#import "LYRUIMessageType.h"

static CGFloat const LYRUIMessageCellPresenterSmallWidth = 460.0;
static CGFloat const LYRUIMessageCellPresenterWideWidth = 600.0;

static CGFloat const LYRUIMessageCellPresenterSmallMaxWidthRatio = 0.6;
static CGFloat const LYRUIMessageCellPresenterMediumMaxWidthRatio = 0.75;

static CGFloat const LYRUIMessageCellPresenterViewsWithMarginsWidth = 64.0 + 25;

@interface LYRUIMessageCellPresenter ()

@property (nonatomic, strong) LYRUIMessageItemViewPresenter *messageItemPresenter;

@end

@implementation LYRUIMessageCellPresenter
@synthesize listDataSource = _listDataSource,
            layerConfiguration = _layerConfiguration;

- (instancetype)initWithConfiguration:(LYRUIConfiguration *)configuration {
    self = [super init];
    if (self) {
        self.layerConfiguration = configuration;
    }
    return self;
}

- (void)setLayerConfiguration:(LYRUIConfiguration *)layerConfiguration {
    _layerConfiguration = layerConfiguration;
    self.messageItemPresenter = [layerConfiguration.injector presenterForViewClass:[LYRUIMessageItemView class]];
}

#pragma mark - LYRUIListCellSizeCalculating

- (NSSet<Class> *)handledItemTypes {
    return [NSSet setWithObject:[LYRUIMessageType class]];
}

- (CGSize)cellSizeInCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath {
    LYRUIMessageType *message = (LYRUIMessageType *)[self.listDataSource itemAtIndexPath:indexPath];
    CGFloat width = [self cellWidthInCollectionView:collectionView];
    CGFloat maxContentViewWidth = [self maxContentViewWidthForCellWidth:width];
    CGFloat height = [self cellHeightForMessage:message contentViewWidth:maxContentViewWidth];
    return CGSizeMake(width, height);
}

- (CGFloat)cellWidthInCollectionView:(UICollectionView *)collectionView {
    UIEdgeInsets insets = collectionView.lyr_safeAreaInsets;
    return CGRectGetWidth(collectionView.bounds) - insets.left - insets.right;
}

- (CGFloat)cellHeightForMessage:(LYRUIMessageType *)message contentViewWidth:(CGFloat)width {
    return [self.messageItemPresenter messageViewHeightForMessage:message
                                                         maxWidth:width];
}

- (CGFloat)maxContentViewWidthForCellWidth:(CGFloat)cellWidth {
    CGFloat maxContentViewWidth = cellWidth - LYRUIMessageCellPresenterViewsWithMarginsWidth;
    if (cellWidth > LYRUIMessageCellPresenterWideWidth) {
        maxContentViewWidth = (LYRUIMessageCellPresenterSmallMaxWidthRatio * cellWidth);
    } else if (cellWidth > LYRUIMessageCellPresenterSmallWidth) {
        maxContentViewWidth = (LYRUIMessageCellPresenterMediumMaxWidthRatio * cellWidth);
    }
    return maxContentViewWidth;
}

#pragma mark - LYRUIListCellPresenting

- (NSString *)cellReuseIdentifier {
    return NSStringFromClass([LYRUIMessageCollectionViewCell class]);
}

- (void)registerCellInCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[LYRUIMessageCollectionViewCell class] forCellWithReuseIdentifier:self.cellReuseIdentifier];
}

- (void)setupCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    LYRUIMessageItemView *messageItemView = ((LYRUIMessageCollectionViewCell *)cell).messageView;
    LYRUIMessageType *message = (LYRUIMessageType *)[self.listDataSource itemAtIndexPath:indexPath];
    [self setupMessageItemView:messageItemView withMessage:message];
}

- (void)setupMessageItemView:(LYRUIMessageItemView *)messageItemView withMessage:(LYRUIMessageType *)message {
    messageItemView.layerConfiguration = self.layerConfiguration;
    [self setupAccessoryViewVisibility:messageItemView.primaryAccessoryViewContainer
                            forMessage:message];
    
    [self.messageItemPresenter setupMessageItemView:messageItemView withMessage:message];
    
    [self setupMessageViewLayout:messageItemView
                      forMessage:message];
}

- (void)setupMessageViewLayout:(LYRUIMessageItemView *)messageView
                    forMessage:(LYRUIMessageType *)message {
    BOOL outgoingMessage = [self isOutgoingMessage:message];
    LYRUIMessageItemViewLayoutDirection layoutDirection =
        outgoingMessage ? LYRUIMessageItemViewLayoutDirectionRight : LYRUIMessageItemViewLayoutDirectionLeft;
    if (messageView.layout.layoutDirection != layoutDirection) {
        messageView.layout.layoutDirection = layoutDirection;
        [messageView setNeedsUpdateConstraints];
    }
}

- (void)setupAccessoryViewVisibility:(UIView *)accessoryView
                          forMessage:(LYRUIMessageType *)message {
    NSIndexPath *indexPath = [self.listDataSource indexPathOfItem:message];
    accessoryView.hidden = NO;
    LYRUIListSection *section = self.listDataSource.sections[indexPath.section];
    if (indexPath.item < (section.items.count - 1)) {
        LYRUIMessageType *message = section.items[indexPath.item];
        id nextItem = section.items[indexPath.item + 1];
        if (![nextItem isKindOfClass:[LYRUIMessageType class]]) {
            return;
        }
        LYRUIMessageType *nextMessage = (LYRUIMessageType *)nextItem;
        accessoryView.hidden = [message.sender.userID isEqualToString:nextMessage.sender.userID];
    }
}

- (BOOL)isOutgoingMessage:(LYRUIMessageType *)message {
    NSString *currentUserId = self.layerConfiguration.client.authenticatedUser.userID;
    return [message.sender.userID isEqualToString:currentUserId];
}

#pragma mark - Properties

- (void)setActionHandlingDelegate:(id)actionHandlingDelegate {
    _actionHandlingDelegate = actionHandlingDelegate;
    self.messageItemPresenter.actionHandlingDelegate = actionHandlingDelegate;
}

@end
