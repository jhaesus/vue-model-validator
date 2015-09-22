module.exports = (field, value, item, vm) ->
  vm[item.expression](value)
