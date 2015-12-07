//
//  DSLViewControllerAnimatedTransition.h
//  TransitionExample
//
//  Created by leichunfeng on 15/12/7.
//  Copyright © 2015年 Dative Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSLViewControllerAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) UINavigationControllerOperation operation;

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation;

@end
