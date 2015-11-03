//
//  KAImportStatementTests.m
//  KAImportStatementTests
//
//  Created by Kenneth Parker Ackerson on 11/2/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAImportStatement.h"

@interface KAImportStatementTests : XCTestCase

@end

@implementation KAImportStatementTests

- (void)testImportPartsEqualsTwoWhenDividedByDivisionSign {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"#import <AppKit/AppKit.h>"];
    XCTAssert(importStatement.importParts.count == 2);
}

- (void)testImportPartsEqualsOneForSwiftModuleImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"import Foundation"];
    XCTAssert(importStatement.importParts.count == 1);
}

- (void)testImportPartsEqualsTwoForSpecificSwiftModuleImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"import Foundation.NSString"];
    XCTAssert(importStatement.importParts.count == 2);
}

- (void)testImportPartsEqualsOneForObjectiveCModuleImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"@import Foundation;"];
    XCTAssert(importStatement.importParts.count == 1);
}

- (void)testImportPartsEqualsOneForNormalObjectiveCImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"#import \"Person.h\";"];
    XCTAssert(importStatement.importParts.count == 1);
}


- (void)testImportIsRightTypeForSpecificBracketedImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"#import <AppKit/AppKit.h>"];
    XCTAssert(importStatement.importType == KAImportTypePound);
}

- (void)testImportIsRightTypeForSwiftModuleImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"import Foundation"];
    XCTAssert(importStatement.importType == KAImportTypeSwift);
}

- (void)testImportIsRightTypeForObjectiveCModuleImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"@import Foundation;"];
    XCTAssert(importStatement.importType == KAImportTypeAtSign);
}

- (void)testImportIsRightTypeFoSpecificrSwiftModuleImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"import Foundation.NSString"];
    XCTAssert(importStatement.importType == KAImportTypeSwift);
}

- (void)testImportIsRightTypeForNormalObjectiveCImport {
    KAImportStatement *importStatement = [[KAImportStatement alloc] initWithImportString:@"#import \"Person.h\";"];
    XCTAssert(importStatement.importType == KAImportTypePound);
}


@end
