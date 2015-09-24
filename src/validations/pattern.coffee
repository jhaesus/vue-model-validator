module.exports = (field, value, item, vm) ->
  validation = item.arg || item.expression
  arg = if item.arg then item.expression
  ///#{vm.constructor.util.stripQuotes(arg)}///.test(value)
