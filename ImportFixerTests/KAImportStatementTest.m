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

- (void)testImportInsideOfModuleNameDoesNotImpactParsingSwift {
    KAImportStatement *statement = [[KAImportStatement alloc] initWithImportString:@"import myimport"];
    
    for (NSString *string in statement.importParts) {
        XCTAssert([string isEqualToString:@"myimport"]);
    }
}

- (void)testImportInsideOfModuleNameDoesNotImpactParsingObjectiveCModule {
    KAImportStatement *statement = [[KAImportStatement alloc] initWithImportString:@"@import myimport;"];
    
    for (NSString *string in statement.importParts) {
        XCTAssert([string isEqualToString:@"myimport"]);
    }
}

- (void)testImportInsideOfModuleNameDoesNotImpactParsingObjectiveCPoundLibrary {
    KAImportStatement *statement = [[KAImportStatement alloc] initWithImportString:@"#import <MyImport/MyImport.h>"];
    
    for (NSString *string in statement.importParts) {
        XCTAssert([string isEqualToString:@"MyImport"]);
    }
}

@end
