module.exports = (field, value, item, vm) ->
  !value? || ///#{vm.constructor.util.stripQuotes(item.expression)}///.test(value)
