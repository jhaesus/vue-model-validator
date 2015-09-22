exports.install = (Vue) ->
  Vue.options.validators = require "./validations/index"

  Vue.validator = (name, fn) ->
    Vue.options.validators[name] = fn

  run_validations = (field, expression="", vm, value) ->
    validations = Vue.parsers.directive.parse(expression)
    vm.$set "validation.#{field}.invalid", !validations.every (item) ->
      validation = item.arg || item.expression
      result = (vm.$options.validators?[validation] || Vue.options.validators[validation])(field, value, item, vm)
      vm.$set "validation.#{field}.#{validation}", !result
      result

  listener = (field, expression="", vm) ->
    (value) -> run_validations(field, expression, vm, value)

  target_listener = (field, expression="", vm) ->
    -> run_validations(field, expression, vm, vm.$get(field))

  watch_targets = (field, expression="", vm) ->
    Vue.parsers.directive.parse(expression).forEach (item) ->
      validation = item.arg || item.expression
      arg = if item.arg then item.expression
      if key = (vm.$options.validators?[validation] || Vue.options.validators[validation]).watchTarget
        vm.$watch(item[key], target_listener(field, item.raw, vm), true, false)

  collection = (vm) ->
    vm.$options.validations || {}

  Vue.prototype.$validate = ->
    keys = if arguments.length then [].slice.call(arguments) else Object.keys(collection(@))
    keys.map((key) =>
      listener(key, collection(@)[key], @)(@$get(key))
      !@$get("validation.#{key}.invalid")
    ).indexOf(false) == -1

  Vue.prototype.$watch_validations = ->
    for field, expression of collection(@)
      watch_targets(field, expression, @)
      @$watch(field, listener(field, expression, @), true, false)

  @
