//
//  UIViewController+Present.m
//  DynamicAppIcon
//
//  Created by Seven on 30/09/2017.
//  Copyright © 2017 Seven. All rights reserved.
//

#import "UIViewController+Present.h"
#import <objc/runtime.h>

@implementation UIViewController (Present)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(newPresentViewController:animated:completion:));

        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}

- (void)newPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {

        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        // 系统弹框的title和message均为空
        if (alertController.title == nil && alertController.message == nil) {
            return;
        } else {
            [self newPresentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    [self newPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
