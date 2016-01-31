//
//  KAImportStatementTest.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 1/31/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAImportStatement.h"

@interface KAImportStatementTest : XCTestCase

@end

@implementation KAImportStatementTest

- (void)testImportInsideOfModuleNameDoesNotImpactParsing {

    KAImportStatement *statement = [[KAImportStatement alloc] initWithImportString:@"import myimport"];
    
    for (NSString *string in statement.importParts) {
        XCTAssert([string isEqualToString:@"myimport"]);
    }
    
}

@end
