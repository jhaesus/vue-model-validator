module.exports = (field, value, item, vm) ->
  this.watchTarget = "expression"

  arg = if item.arg then item.expression
  (value || "") == (vm.$get(arg) || "")
