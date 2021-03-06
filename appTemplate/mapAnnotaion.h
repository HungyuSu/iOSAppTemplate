//
//  mapAnnotaion.h
//  appTemplate
//
//  Created by Mac on 14/2/21.
//  Copyright (c) 2014年 Gocharm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mapAnnotaion : NSObject<MKAnnotation>{}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property int ind;

-(id) initWithCoordinate: (CLLocationCoordinate2D) the_coordinate;

@end
