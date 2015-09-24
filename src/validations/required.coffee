module.exports = (field, value, item, vm) ->
  if typeof value is 'string' then value = value.trim()
  ["", undefined, null].indexOf(value) == -1
