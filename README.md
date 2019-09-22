# fraction_arithmetics
## Description
This small command-line executes operations between fractions given string input.

## Installation
As this command line is using the [Swift Package Manager](https://swift.org/package-manager/), once you clone the repo, you should build the sources.

`swift build`

Once is finished you can run the command line from the build directory or the installed package.

`.build/debug/Fractions_arithmetics <Arguments>`

or

`swift run Fractions_arithmetics <Arguments>`

## Usage
`Fractions_arithmetics` provides two options, Operate and Test.

`-o` or `--operation` executes an operation.

**e.g**
`swift run Fractions_arithmetics -o "1_1/2 + 1_1/2"`

The valid inputs for operands are:
* `1`, `-1` whole number
* `1_1/4`, `-1_1/4` mixed fractions
* `2/4`, `-2/4` proper fractions
* `20/4`, `-20/4` improper fractions

⚠️ This script supports more than two operands, but the operators' precedence is not being taken into account. (`"1/3 + 1/3 + 1/3" is still valid).

`-t` or `--test` Run the tests for parser and operations.
In `sources/Fractions_arithmetics/Tests.swift` you can find the unit tests are being run.
