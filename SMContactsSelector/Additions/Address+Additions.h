//
//  Address+Additions.h
//  Balloon
//
//  Created by Hikari Senju 2014.
//  Copyright (c) 2014 Hikari Senju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface NSObject (RecordID)

+ (NSArray *)getAllRecordIDs;

+ (ABRecordRef)infoWithRecordID:(NSInteger)recordID;

@end
