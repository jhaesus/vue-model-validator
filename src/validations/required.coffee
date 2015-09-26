module.exports = (field, value, item, vm) ->
  if typeof value is 'string' then value = value.trim()
  ["", undefined, null, false].indexOf(value) == -1
