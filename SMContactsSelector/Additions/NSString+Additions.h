//
//  StringHelper.h
//  Balloon
//
//  Created by Hikari Senju 2014.
//  Copyright (c) 2014 Hikari Senju. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "JSON.h"

@interface NSString (helper)

- (NSString*) substringFrom: (NSInteger) a to: (NSInteger) b;

- (NSInteger) indexOf: (NSString*) substring from: (NSInteger) starts;

- (NSString*) trim;

- (BOOL) startsWith:(NSString*) s;

- (BOOL) containsString:(NSString*) aString;

- (NSString *)urlEncodeCopy;

- (NSString *)reverseGeocode;

- (NSString *)shortURL;

- (NSString *)reformatTelephone;

- (BOOL)containsNullString;

@end
