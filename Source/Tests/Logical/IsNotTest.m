//
//  OCHamcrest - IsNotTest.m
//  Copyright 2014 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Docs: http://hamcrest.github.com/OCHamcrest/
//  Source: https://github.com/hamcrest/OCHamcrest
//

    // Class under test
#define HC_SHORTHAND
#import <OCHamcrest/HCIsNot.h>

    // Collaborators
#import <OCHamcrest/HCIsEqual.h>
#import <OCHamcrest/HCHasCount.h>

    // Test support
#import "AbstractMatcherTest.h"


@interface IsNotTest : AbstractMatcherTest
@end

@implementation IsNotTest

- (id <HCMatcher>)createMatcher
{
    return isNot(@"something");
}

- (void)testCopesWithNils
{
    id matcher = isNot(@"irrelevant");

    assertNilSafe(matcher);
}

- (void)testEvaluatesToTheTheLogicalNegationOfAnotherMatcher
{
    assertMatches(@"invert mismatch", isNot(equalTo(@"A")), @"B");
    assertDoesNotMatch(@"invert match", isNot(equalTo(@"A")), @"A");
}

- (void)testProvidesConvenientShortcutForNotEqualTo
{
    assertMatches(@"invert mismatch", isNot(@"A"), @"B");
    assertDoesNotMatch(@"invert match", isNot(@"A"), @"A");
}

- (void)testHasAReadableDescription
{
    assertDescription(@"not \"A\"", isNot(@"A"));
}

- (void)testSuccessfulMatchDoesNotGenerateMismatchDescription
{
    assertNoMismatchDescription(isNot(@"A"), @"B");
}

- (void)testMismatchDescriptionShowsActualArgument
{
    assertMismatchDescription(@"was \"A\"", isNot(@"A"), @"A");
}

- (void)testMismatchDescriptionShowsActualSubMatcherDescription
{
    NSArray *item = @[@"A", @"B"];
    NSString *expected = [NSString stringWithFormat:@"was count of <2> with <%@>", item];
    assertMismatchDescription(expected, isNot(hasCountOf(item.count)), item);
}

- (void)testDescribeMismatch
{
    assertDescribeMismatch(@"was \"A\"", isNot(@"A"), @"A");
}

@end
