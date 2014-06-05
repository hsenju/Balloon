//
//  Address+Additions.m
//  Balloon
//
//  Created by Hikari Senju 2014.
//  Copyright (c) 2014 Hikari Senju. All rights reserved.
//

#import "Address+Additions.h"
#import <AddressBookUI/AddressBookUI.h>

@implementation NSObject (RecordID)

+ (ABRecordRef)infoWithRecordID:(NSInteger)recordID
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
	CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
	CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
	
    ABRecordRef person = NULL;
	for (int i = 0; i < nPeople; i++)
	{
		person = CFArrayGetValueAtIndex(allPeople, i);
        
        int currentID = (int)ABRecordGetRecordID(person);
        
        if (currentID == recordID) 
            break;
    }
    
    CFRelease(allPeople);
    CFRelease(addressBook);
    return person;
}

+ (NSArray *)getAllRecordIDs
{
    NSMutableArray *items = [NSMutableArray array];
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
	CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
	CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
	
	for (int i = 0; i < nPeople; i++)
	{
		ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        
        int recordID = (int)ABRecordGetRecordID(person);
        
        [items addObject:[NSNumber numberWithInt:recordID]];
    }
    
    CFRelease(allPeople);
    CFRelease(addressBook);
    return (NSArray *)items;
}

@end
