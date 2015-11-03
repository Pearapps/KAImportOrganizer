//
//  KAImportFinderTests.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/2/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAArrayBasedLineReader.h"
#import "KAImportFinder.h"

@interface KAImportFinderTests : XCTestCase

@end

@implementation KAImportFinderTests

+ (KAImportFinder *)finderWithArrayOfLinesFromSourceCode:(NSArray *)lines {
    KAArrayBasedLineReader *arrayBasedLineReader = [[KAArrayBasedLineReader alloc] initWithLines:lines];
    return [[KAImportFinder alloc] initWithLineReader:arrayBasedLineReader];
}

+ (NSArray *)importStringsFromImportFinder:(KAImportFinder *)importFinder {
    
    NSArray *importStrings = [importFinder importStrings];
    
    NSArray *allImports = [NSArray new];
    for (NSArray *arrayOfString in importStrings) {
        allImports = [allImports arrayByAddingObjectsFromArray:arrayOfString];
    }
    
    return [allImports valueForKey:@"importString"];
}

+ (NSInteger)totalNewLinesFromImportFinder:(KAImportFinder *)importFinder {
    NSInteger total = 0;
    for (NSNumber *number in [importFinder numbersOfNewLines]) {
        total += [number integerValue];
    }
    return total;
}

- (void)testNewlineDoesNot {
    KAImportFinder *importFinder = [KAImportFinderTests finderWithArrayOfLinesFromSourceCode:@[
                                                                                               @"// Hello",
                                                                                               @"@import Foundation;",
                                                                                               @"#import \"Kenny.h\"",
                                                                                               @"",
                                                                                               @"@import UIKit;",
                                                                                               ]];
    NSArray *rawImportStrings = [KAImportFinderTests importStringsFromImportFinder:importFinder];
    
    XCTAssert([rawImportStrings containsObject:@"@import Foundation;\n"]);
    XCTAssert([rawImportStrings containsObject:@"#import \"Kenny.h\"\n"]);
    XCTAssert([rawImportStrings containsObject:@"@import UIKit;\n"]);
    XCTAssert([KAImportFinderTests totalNewLinesFromImportFinder:importFinder] == 1);
    
}

@end
