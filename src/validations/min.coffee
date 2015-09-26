module.exports = (field, value, item, vm) ->
  !value? || value >= +item.expression
