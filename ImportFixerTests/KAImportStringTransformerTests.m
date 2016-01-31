//
//  KAImportStringTransformerTests.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/3/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAImportStringTransformer.h"


@interface KAImportStringTransformerTests : XCTestCase

@end

@implementation KAImportStringTransformerTests

- (void)testInsertedNewLinesBetweenTypes {
    NSArray *originalImports = @[
                                 [[KAImportStatement alloc] initWithImportString:@"#import \"Kenny.h\"\n"],
                                 [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                 ];
    
    NSArray *sortedImports = @[
                               [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"],
                               [[KAImportStatement alloc] initWithImportString:@"#import \"Kenny.h\"\n"]
                               ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "#import \"Kenny.h\"\n"
    "@import Foundation;\n";
    
    NSString *transformedString = [[[KAImportStringTransformer alloc] initWithOriginalImports:originalImports sortedImportStatements:sortedImports originalContents:contents numberOfNewlines:0 insertsNewLinesInBetweenTypes:YES] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "\n"
    "#import \"Kenny.h\"\n";
    
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);

}

- (void)testBasicImportCreationSwift {
    NSArray *originalImports = @[
                                 [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"],
                                 [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"]
                                 ];
    
    NSArray *sortedImports = @[
                               [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"],
                               [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"]
                               ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "import Kenny\n"
    "import Foundation\n";
    
    NSString *transformedString = [[[KAImportStringTransformer alloc] initWithOriginalImports:originalImports sortedImportStatements:sortedImports originalContents:contents numberOfNewlines:0 insertsNewLinesInBetweenTypes:NO] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "import Foundation\n"
    "import Kenny\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testBasicImportCreationWithNewlineInBetweenSwift {
    NSArray *originalImports = @[
                                 [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"],
                                 [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"]
                                 ];
    
    NSArray *sortedImports = @[
                               [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"],
                               [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"]
                               ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "import Kenny\n"
    "\n"
    "import Foundation\n";
    
    NSString *transformedString = [[[KAImportStringTransformer alloc] initWithOriginalImports:originalImports sortedImportStatements:sortedImports originalContents:contents numberOfNewlines:1 insertsNewLinesInBetweenTypes:NO] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "import Foundation\n"
    "import Kenny\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

// Objective-C

- (void)testBasicImportCreation {
    NSArray *originalImports = @[
                                 [[KAImportStatement alloc] initWithImportString:@"#import \"Kenny.h\"\n"],
                                 [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                 ];
    
    NSArray *sortedImports = @[
                               [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"],
                               [[KAImportStatement alloc] initWithImportString:@"#import \"Kenny.h\"\n"]
                                 ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "#import \"Kenny.h\"\n"
    "@import Foundation;\n";
    
    NSString *transformedString = [[[KAImportStringTransformer alloc] initWithOriginalImports:originalImports sortedImportStatements:sortedImports originalContents:contents numberOfNewlines:0 insertsNewLinesInBetweenTypes:NO] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "#import \"Kenny.h\"\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testBasicImportCreationWithNewlineInBetween {
    NSArray *originalImports = @[
                                 [[KAImportStatement alloc] initWithImportString:@"#import \"Kenny.h\"\n"],
                                 [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                 ];
    
    NSArray *sortedImports = @[
                               [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"],
                               [[KAImportStatement alloc] initWithImportString:@"#import \"Kenny.h\"\n"]
                               ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "#import \"Kenny.h\"\n"
    "\n"
    "@import Foundation;\n";
    
    NSString *transformedString = [[[KAImportStringTransformer alloc] initWithOriginalImports:originalImports sortedImportStatements:sortedImports originalContents:contents numberOfNewlines:1 insertsNewLinesInBetweenTypes:NO] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "#import \"Kenny.h\"\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

@end
