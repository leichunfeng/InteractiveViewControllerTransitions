//
//  DSLViewControllerAnimatedTransition.m
//  TransitionExample
//
//  Created by leichunfeng on 15/12/7.
//  Copyright © 2015年 Dative Studios. All rights reserved.
//

#import "DSLViewControllerAnimatedTransition.h"

@interface DSLViewControllerAnimatedTransition ()

@property (nonatomic, assign, readwrite) UINavigationControllerOperation operation;

@end

@implementation DSLViewControllerAnimatedTransition

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation {
    self = [super init];
    if (self) {
        self.operation = operation;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect initialFrameForFromViewController = [transitionContext initialFrameForViewController:fromViewController];
    CGRect finalFrameForFromViewController   = [transitionContext finalFrameForViewController:fromViewController];
    
    NSLog(@"initialFrameForFromViewController: %@", NSStringFromCGRect(initialFrameForFromViewController));
    NSLog(@"finalFrameForFromViewController: %@", NSStringFromCGRect(finalFrameForFromViewController));
    
    CGRect initialFrameForToViewController = [transitionContext initialFrameForViewController:toViewController];
    CGRect finalFrameForToViewController   = [transitionContext finalFrameForViewController:toViewController];
    
    NSLog(@"initialFrameForToViewController: %@", NSStringFromCGRect(initialFrameForToViewController));
    NSLog(@"finalFrameForToViewController: %@", NSStringFromCGRect(finalFrameForToViewController));

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.operation == UINavigationControllerOperationPush) { // push
        toViewController.view.frame = CGRectOffset(toViewController.view.frame, CGRectGetWidth(toViewController.view.frame), 0);
        [[transitionContext containerView] addSubview:toViewController.view];

        [UIView animateWithDuration:duration
                         animations:^{
                             fromViewController.view.alpha = 0;
                             fromViewController.view.frame = CGRectInset(fromViewController.view.frame, 10, 10);
                             toViewController.view.frame = CGRectOffset(toViewController.view.frame, -CGRectGetWidth(toViewController.view.frame), 0);
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else if (self.operation == UINavigationControllerOperationPop) { // pop
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] sendSubviewToBack:toViewController.view];
        
        [UIView animateWithDuration:duration
                         animations:^{
                             toViewController.view.alpha = 1;
                             fromViewController.view.frame = CGRectOffset(fromViewController.view.frame, CGRectGetWidth(fromViewController.view.frame), 0);
                             toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

@end
