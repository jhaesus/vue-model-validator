exports.install = (Vue, global={}) ->
  defaults =
    watch: false
    parse_all: true
    invalid_on_error: true
    watch_options:
      deep: false
      immediate: false
      sync: false
  global.watch ?= defaults.watch
  global.parse_all ?= defaults.parse_all
  global.invalid_on_error ?= defaults.invalid_on_error
  global.watch ?= defaults.watch
  global.watch.deep ?= defaults.watch.deep
  global.watch.immediate ?= defaults.watch.immediate
  global.watch.sync ?= defaults.watch.sync

  Vue.options.validators = require "./validations/index"

  Vue.validator = (name, fn) ->
    if name == "invalid"
      Vue.util.warn("Model Validator: 'invalid' is reserved")
    else
      Vue.options.validators[name] = fn

  expressions = (vm) -> vm.$options.validations || {}

  runners = (vm) -> vm.$options.validators || {}

  parsed_expressions = (expression) ->
    Vue.parsers.directive.parse(expression)

  on_missing_validator = (validation) ->
    Vue.util.warn("Model Validator: Missing validator #{validation}")
    !global.invalid_on_error

  run_single_validation = (item, vm, field) ->
    validation = item.arg || item.expression
    validator = runners(vm)[validation]
    result = if validator
      validator(field, vm.$get(field), item, vm)
    else on_missing_validator(validation)
    vm.$set "validation.#{field}.#{validation}", !result
    result

  run_all = (field, expression="", vm, value, validations) ->
    validations.map((item) -> run_single_validation(item, vm, field)).indexOf(false) == -1

  run_until_first = (field, expression="", vm, value, validations) ->
    validations.every (item) -> run_single_validation(item, vm, field)

  run_validations = (field, expression="", vm, value) ->
    result = if global.parse_all
      run_all(field, expression, vm, value, parsed_expressions(expression))
    else
      run_until_first(field, expression, vm, value, parsed_expressions(expression))
    vm.$set "validation.#{field}.invalid", !result
    result

  listener = (field, expression="", vm) ->
    (value) -> run_validations(field, expression, vm, value)

  target_listener = (field, expression="", vm) ->
    -> run_validations(field, expression, vm, vm.$get(field))

  watch_target = (field, expression="", vm, options=global.watch_options) ->
    unwatches = []
    parsed_expressions(expression).forEach (item) ->
      validation = item.arg || item.expression
      if key = runners(vm)[validation].watchTarget
        unwatches.push vm.$watch(item[key], target_listener(field, item.raw, vm), options)
    unwatches

  Vue.prototype.$validate = ->
    keys = if arguments.length then [].slice.call(arguments) else Object.keys(expressions(@))
    keys.map((key) =>
      if expression = expressions(@)[key]
        listener(key, expression, @)(@$get(key))
      else
        Vue.util.warn("Model Validator: Invalid validation target #{key}")
        !global.invalid_on_error
    ).indexOf(false) == -1

  Vue.prototype.$watch_validations = (options=global.watch_options) ->
    unwatches = []
    for field, expression of expressions(@)
      unwatches = unwatches.concat watch_target(field, expression, @, options)
      unwatches.push @$watch(field, listener(field, expression, @), options)
    unwatches

  if global.watch
    old_init = Vue.prototype._init
    Vue.prototype._init = (options={}) ->
      old_created = options.created || ->
      options.created = ->
        @$watch_validations()
        old_created.apply(@, arguments)
      old_init.call(@, options)

  @
