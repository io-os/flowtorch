# the primary compiler itself transpiles FeeFiFlow graphs into
# TypeScript code, utilizing the languages type systems and
# the mentality of Coffeescript.

# It will do this:
# ---------------------------------------------------------
# - Generate functions for blocks, and Promise-chain styled
#   output of connections, properly using edges for maximum
#   readability of output.
# - Gives specs of the flow language & assement of needs thereof.
# - Primarily: Blocks, Functions, Values, Conditionals, Arguments, Calls and more generally the
#   Abstraction of flow into code.
# - Become written in a short period of time.

# The initial implementation of the compiler will be based
# around the Typescript compiler, and directly tap into
# that to decrease the overall time spent before being able to make a profit.

module.exports = require './src'