//
//  ElanceWebLogin.h
//  Balloon
//
//  Created by Hikari Senju 2014.
//  Copyright (c) 2014 Hikari Senju. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FSWebLogin : UIViewController

@property(nonatomic,weak) id delegate;
@property (nonatomic,assign) SEL selector;

- (id) initWithUrl:(NSString *)url;

@end
