module.exports = (field, value, item, vm) ->
  origin = field.replace(/_confirmation$/, "")
  value == vm.$get(origin)
