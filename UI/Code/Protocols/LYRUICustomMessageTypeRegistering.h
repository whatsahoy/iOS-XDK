//
//  LYRUICustomMessageTypeRegistering.h
//  Layer-XDK-UI-iOS
//
//  Created by Łukasz Przytuła on 16.02.2018.
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
@protocol LYRUICustomMessageTypeRegistering <NSObject>

- (void)registerMessageTypeClass:(Class)messageTypeClass
             withSerializerClass:(Class)serializerClass
           contentPresenterClass:(Class)contentPresenterClass;

- (void)registerMessageTypeClass:(Class)messageTypeClass
             withSerializerClass:(Class)serializerClass
           contentPresenterClass:(Class)contentPresenterClass
         containerPresenterClass:(nullable Class)containerPresenterClass;

- (void)registerActionHandlerClass:(Class)actionHandlerClass
                          forEvent:(NSString *)event;

- (void)registerActionHandlerClass:(Class)actionHandlerClass
                          forEvent:(NSString *)event
                  messageTypeClass:(nullable Class)messageTypeClass;

@end
NS_ASSUME_NONNULL_END       // }
