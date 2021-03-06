//
//  LYRUIOROperation.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 22.03.2018.
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN     // {
@interface LYRUIOROperation<__covariant ObjectType> : NSObject

@property (nonatomic, readonly) ObjectType value;

@property (nonatomic, readonly) NSString *operationID;

- (instancetype)initWithValue:(ObjectType)value;

- (instancetype)initWithValue:(ObjectType)value operationID:(nullable NSString *)operationID;

@end
NS_ASSUME_NONNULL_END       // }
