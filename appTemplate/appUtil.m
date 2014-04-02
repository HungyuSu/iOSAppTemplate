//
//  appUtil.m
//  appTemplate
//
//  Created by Mac on 14/2/20.
//  Copyright (c) 2014年 Gocharm. All rights reserved.
//

#import "appUtil.h"

@implementation appUtil

NSString *const coimLoginURI = @"drinks/account/login";
NSString *const coimLogoutURI = @"drinks/account/logout";
NSString *const coimRegisterURI = @"drinks/account/register";
NSString *const coimActivateURI = @"drinks/account/activate";
NSString *const coimSearchURI = @"twCtBus/busStop/search";
NSString *const coimCheckTokenURI = @"drinks/account/profile";
NSString *const coimDetailURI = @"drinks/shops/info";
NSString *const coimDocURI = @"drinks/shops/view";

const struct requestKeysForCoimotionAPI coimReqParams = {
    .lat = @"lat",
    .lng = @"lng",
    .addr = @"addr",
    .accName = @"accName",
    .passwd = @"passwd",
    .token = @"token",
    .detail = @"detail",
    .passwd2 = @"passwd2",
    .appKey=@"_key"
};

const struct responseKeysFromCoimotionAPI coimResParams = {
    .errCode = @"errCode",
    .message = @"message",
    .value = @"value",
    .list = @"list",
    .latitude = @"latitude",
    .longitude = @"longitude",
    .title = @"title",
    .summary = @"summary",
    .body = @"body",
    .geID = @"geID",
    .ngID = @"ngID",
    .token = @"token",
    .addr = @"addr",
    .dspName = @"dspName",
    .doc = @"doc",
    .actID = @"actID"
};
@synthesize token, userName, shopMenuList;

+ (void)setRootWindowView:(UIViewController *)VC
{
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:VC];
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
}
/*
 start with app login view, create a tab controlled view with list and map view controller
*/
+ (void)enterLogin
{
    [self setRootWindowView:[LoginViewController new]];
}
/*
    start with app main view, create a tab controlled view with list and map view controller
*/
+ (void)enterApp
{
    //TableListingViewController *tableListVC = [TableListingViewController new];
    GridViewController *VC = [GridViewController new];
    
    UINavigationController *naviVC1 = [[UINavigationController alloc] initWithRootViewController:VC];
    [self setRootWindowView:naviVC1];
}
@end
