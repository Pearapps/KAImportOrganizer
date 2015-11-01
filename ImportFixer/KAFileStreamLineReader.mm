//
//  KAFileStreamLineReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/1/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAFileStreamLineReader.h"
#include <fstream>
#include <string>
#import <Foundation/Foundation.h>

using namespace std;

@interface KAFileStreamLineReader () {
    ifstream stream;
    NSString *nextLine;
}

@end

@implementation KAFileStreamLineReader

- (void)dealloc {
    stream.close();
}

- (NSString *)readLine {
    return nextLine;
}

- (BOOL)hasAnotherLine {
    string string;
    if (getline(stream, string)) {
        nextLine = [[NSString alloc] initWithUTF8String:string.c_str()];
        return nextLine != nil;
    }
    
    return NO;
}

- (instancetype)initWithFileURL:(NSURL *)URL {
    self = [super init];
    
    const NSString *fileString = [URL path];
    stream.open([fileString UTF8String]);
    

    return self;
}


@end
