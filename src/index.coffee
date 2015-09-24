exports.install = (Vue, options={watch: false}) ->
  Vue.options.validators = require "./validations/index"

  Vue.validator = (name, fn) ->
    Vue.options.validators[name] = fn

  run_validations = (field, expression="", vm, value) ->
    validations = Vue.parsers.directive.parse(expression)

    vm.$set "validation.#{field}.invalid", !validations.every (item) ->
      validation = item.arg || item.expression
      if validator = (vm.$options.validators?[validation] || Vue.options.validators[validation])
        result = validator(field, value, item, vm)
        vm.$set "validation.#{field}.#{validation}", !result
        result
      else
        Vue.util.warn("Model Validator: Missing validator #{validation}")
        null

  listener = (field, expression="", vm) ->
    (value) -> run_validations(field, expression, vm, value)

  target_listener = (field, expression="", vm) ->
    -> run_validations(field, expression, vm, vm.$get(field))

  watch_targets = (field, expression="", vm, options={deep: true, immediate: false, sync: false}) ->
    Vue.parsers.directive.parse(expression).forEach (item) ->
      validation = item.arg || item.expression
      if key = (vm.$options.validators?[validation] || Vue.options.validators[validation]).watchTarget
        vm.$watch(item[key], target_listener(field, item.raw, vm), options)

  collection = (vm) ->
    vm.$options.validations || {}

  Vue.prototype.$validate = ->
    keys = if arguments.length then [].slice.call(arguments) else Object.keys(collection(@))
    keys.map((key) =>
      if expression = collection(@)[key]
        listener(key, expression, @)(@$get(key))
        !@$get("validation.#{key}.invalid")
      else
        Vue.util.warn("Model Validator: Invalid validation target #{key}")
        null
    ).indexOf(false) == -1

  Vue.prototype.$watch_validations = (options={deep: true, immediate: false, sync: false}) ->
    for field, expression of collection(@)
      watch_targets(field, expression, @, options)
      @$watch(field, listener(field, expression, @), options)

  if options.watch
    old_init = Vue.prototype._init
    Vue.prototype._init = (options={}) ->
      old_created = options.created || ->
      options.created = ->
        @$watch_validations()
        old_created.apply(@, arguments)
      old_init.call(@, options)

  @
