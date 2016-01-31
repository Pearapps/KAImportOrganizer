//
//  KAImportSorterTests.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAImportSorter.h"

@interface KAImportSorterTests : XCTestCase

@end

@implementation KAImportSorterTests

- (void)testBasicSorting {
    
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"@import AAnny;\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import <Foundation/Foundation.h>\n"]];

    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:imports
                                               sortOrderOfImportType:nil];
    
    XCTAssert([[sorter sortedImports] isEqual:imports]);

}

- (void)testBasicSortingNotAlreadySorted {
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"@import AAnny;\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import <Foundation/Foundation.h>\n"]];
    
    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:[imports reverseObjectEnumerator].allObjects
                                               sortOrderOfImportType:nil];
    
    XCTAssert([[sorter sortedImports] isEqual:imports]);
}

- (void)testBasicSortingSwiftTestable {
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"@testable import Phoenix\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"import AppKit\n"]];
    
    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:imports
                                               sortOrderOfImportType:nil];
    
    XCTAssert([[sorter sortedImports] isEqual:[imports reverseObjectEnumerator].allObjects]);
}

- (void)testBasicSortingSwiftSpecificImport {
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"import AppKit.AppKit\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"@testable import AppKit.Phoenix\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"import AppKit\n"]];
    
    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:imports
                                               sortOrderOfImportType:nil];
    XCTAssert([[sorter sortedImports] isEqual:imports]);
}

- (void)testBasicSortingSwiftSpecificImportDifferentBeginningOrder {
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"import AppKit\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"import AppKit.AppKit\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"@testable import AppKit.Phoenix\n"],
                                               ];
    
    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:imports
                                               sortOrderOfImportType:nil];
    
    NSArray *sortedPotentially = @[[[KAImportStatement alloc] initWithImportString:@"import AppKit.AppKit\n"],
                                   [[KAImportStatement alloc] initWithImportString:@"@testable import AppKit.Phoenix\n"],
                                   [[KAImportStatement alloc] initWithImportString:@"import AppKit\n"]];
    
    NSArray *sorted = [sorter sortedImports];
    XCTAssert([sorted isEqual:sortedPotentially]);
}

- (void)testBasicSortingWithMultipleTypes {
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"@import CAnny;\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import <BAnny>\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import AAnny.h\n"]];
    
    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:imports
                                               sortOrderOfImportType:nil];
    
    XCTAssert([[sorter sortedImports] isEqual:imports.reverseObjectEnumerator.allObjects]);
    
}

#pragma mark - Sort import type tests

- (void)testBasicSortingWithImportTypeSorts {
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"@import CAnny;\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import <BAnny>\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import AAnny.h\n"]];
    
    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:imports.reverseObjectEnumerator.allObjects
                                               sortOrderOfImportType:@[
                                                                       [[KAImportTypeModel alloc] initWithImportType:KAImportTypeAtSign],
                                                                       [[KAImportTypeModel alloc] initWithImportType:KAImportTypePoundLibrary],
                                                                       [[KAImportTypeModel alloc] initWithImportType:KAImportTypePound]
                                                                       ]];
    
    XCTAssert([[sorter sortedImports] isEqual:imports]);
}

- (void)testBasicSortingWithImportTypeSortsSameName {
    NSArray <KAImportStatement *> *imports = @[[[KAImportStatement alloc] initWithImportString:@"@import AAnny;\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import <AAnny>\n"],
                                               [[KAImportStatement alloc] initWithImportString:@"#import AAnny.h\n"]];
    
    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:imports.reverseObjectEnumerator.allObjects
                                               sortOrderOfImportType:@[
                                                                       [[KAImportTypeModel alloc] initWithImportType:KAImportTypeAtSign],
                                                                       [[KAImportTypeModel alloc] initWithImportType:KAImportTypePoundLibrary],
                                                                       [[KAImportTypeModel alloc] initWithImportType:KAImportTypePound]
                                                                       ]];
    
    XCTAssert([[sorter sortedImports] isEqual:imports]);
}

@end
