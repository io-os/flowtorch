# FeeFiFlow should be doing these things:
# ---------------------------------------------------------
# - Macros / Stored Procedures (Dynamic Scaffolding while adding new features)
# - Automatic, Schema powered integrations with APIs. Automatic schema declaration.
# - Previously code intensive work asap within blocks. Making hard shit easy,
#   and quick (REST API generation with data models / block conditionals, editable UI gen)
# - Anything that needs to go in the flow language itself.

require './lib/Object'
require './lib/Edge'
require './lib/Property'
require './lib/Block'
require './lib/Output'
require './lib/Input'
require './lib/Output'
require './lib/TypeSystem'
require './lib/types/ValueTypes'
require './lib/Graph'

module.exports = window.FeeFiFlow