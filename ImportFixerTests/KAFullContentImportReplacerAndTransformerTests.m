//
//  KAFullContentImportReplacerAndTransformerTests.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/3/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KAFullContentsImportReplacerAndTransformer.h"
#import "KAImportStatement.h"

@interface KAFullContentImportReplacerAndTransformerTests : XCTestCase

@end

@implementation KAFullContentImportReplacerAndTransformerTests

- (void)testSimplestImportSortingAndReplacement {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                 [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"],
                                 [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"]
                                 ]
                                 ];
    
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "import Kenny\n"
    "import Foundation\n";
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:0 originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "import Foundation\n"
    "import Kenny\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testSimplestImportSortingAndReplacementWithOneNewLine {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"]
                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @0,
                         @1
                         ];
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "import Kenny\n"
    "\n"
    "import Foundation\n";
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "import Foundation\n"
    "import Kenny\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testSimplestImportSortingAndReplacementWithTwoNewLines {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"]
                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @0,
                         @2
                         ];
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "import Kenny\n"
    "\n"
    "\n"
    "import Foundation\n";
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "import Foundation\n"
    "import Kenny\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testSimplestImportSortingAndReplacementWithTwoNewLinesOneBeforeImports {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"import Kenny\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"import Foundation\n"]
                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @1,
                         @2
                         ];
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "\n"
    "import Kenny\n"
    "\n"
    "\n"
    "import Foundation\n";
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "\n"
    "import Foundation\n"
    "import Kenny\n";
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testNestedImportSortingAndReplacing {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import Kenny;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                     ],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import XCTest;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import AppKit;\n"]
                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @0,
                         @0,
                         @0
                         ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "@import Kenny;\n"
    "@import Foundation;\n"
    "#ifdef DEBUG\n"
    "@import XCTest;\n"
    "@import AppKit;\n"
    "#endif\n"
    ;
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "@import Kenny;\n"
    "#ifdef DEBUG\n"
    "@import AppKit;\n"
    "@import XCTest;\n"
    "#endif\n"
    ;
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testNestedImportSortingAndReplacingWithNewLine {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import Kenny;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                     ],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import XCTest;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import AppKit;\n"]
                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @0,
                         @0,
                         @1
                         ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "@import Kenny;\n"
    "@import Foundation;\n"
    "#ifdef DEBUG\n"
    "@import XCTest;\n"
    "@import AppKit;\n"
    "\n"
    "#endif\n"
    ;
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "@import Kenny;\n"
    "#ifdef DEBUG\n"
    "@import AppKit;\n"
    "@import XCTest;\n"
    "#endif\n"
    ;
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testMultipleNestedImportSortingAndReplacing {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import Kenny;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                     ],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import XCTest;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import AppKit;\n"]
                                     ],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"#import \"RootViewController.h\"\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"#import \"hello.h\"\n"]

                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @0,
                         @0,
                         @1,
                         @0,
                         @0
                         ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "@import Kenny;\n"
    "@import Foundation;\n"
    "#ifdef DEBUG\n"
    "@import XCTest;\n"
    "@import AppKit;\n"
    "\n"
    "#endif\n"
    "// Hi I am kenny\n"
    "#import \"RootViewController.h\"\n"
    "#import \"hello.h\"\n"
    ;
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "@import Kenny;\n"
    "#ifdef DEBUG\n"
    "@import AppKit;\n"
    "@import XCTest;\n"
    "#endif\n"
    "// Hi I am kenny\n"
    "#import \"hello.h\"\n"
    "#import \"RootViewController.h\"\n"
    ;
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testMultipleNestedImportSortingAndReplacingWithNewLine {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import Kenny;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                     ],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import XCTest;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import AppKit;\n"]
                                     ],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"#import \"RootViewController.h\"\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"#import \"hello.h\"\n"]
                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @0,
                         @0,
                         @1,
                         @0,
                         @2
                         ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "@import Kenny;\n"
    "@import Foundation;\n"
    "#ifdef DEBUG\n"
    "@import XCTest;\n"
    "@import AppKit;\n"
    "\n"
    "#endif\n"
    "// Hi I am kenny\n"
    "\n"
    "#import \"RootViewController.h\"\n"
    "\n"
    "#import \"hello.h\"\n"
    ;
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "@import Kenny;\n"
    "#ifdef DEBUG\n"
    "@import AppKit;\n"
    "@import XCTest;\n"
    "#endif\n"
    "// Hi I am kenny\n"
    "\n"
    "#import \"hello.h\"\n"
    "#import \"RootViewController.h\"\n"
    ;
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

- (void)testMultipleNestedImportSortingAndReplacingWithMultipleNewLines {
    NSArray *originalImports = @[
                                 @[],
                                 @[],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import Kenny;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import Foundation;\n"]
                                     ],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"@import XCTest;\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"@import AppKit;\n"]
                                     ],
                                 @[],
                                 @[
                                     [[KAImportStatement alloc] initWithImportString:@"#import \"RootViewController.h\"\n"],
                                     [[KAImportStatement alloc] initWithImportString:@"#import \"hello.h\"\n"]
                                     ]
                                 ];
    
    NSArray *numbers = @[
                         @0,
                         @0,
                         @0,
                         @1,
                         @3,
                         @0,
                         @3
                         ];
    
    NSString *contents = @"//Some stuff\n"
    "// hello\n"
    "@import Kenny;\n"
    "\n"
    "@import Foundation;\n"
    "#ifdef DEBUG\n"
    "@import XCTest;\n"
    "@import AppKit;\n"
    "\n"
    "\n"
    "\n"
    "#endif\n"
    "// Hi I am kenny\n"
    "\n"
    "#import \"RootViewController.h\"\n"
    "\n"
    "\n"
    "#import \"hello.h\"\n"
    ;
    
    NSString *transformedString = [[[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:originalImports numbersOfNewlines:numbers originalContents:contents] transformedString];
    
    NSString *projectedOutcome = @"//Some stuff\n"
    "// hello\n"
    "@import Foundation;\n"
    "@import Kenny;\n"
    "#ifdef DEBUG\n"
    "@import AppKit;\n"
    "@import XCTest;\n"
    "#endif\n"
    "// Hi I am kenny\n"
    "\n"
    "#import \"hello.h\"\n"
    "#import \"RootViewController.h\"\n"
    ;
    
    XCTAssert([projectedOutcome isEqualToString:transformedString]);
}

@end
