module.exports = (field, value, item, vm) ->
  this.watchTarget = "expression"
  value == vm.$get(item.expression)
