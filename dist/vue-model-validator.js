/*!
 * vue-model-validator v0.0.3
 * (c) 2015 Rainer Sai
 * Released under the MIT License.
 */
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory();
	else if(typeof define === 'function' && define.amd)
		define([], factory);
	else if(typeof exports === 'object')
		exports["VueModelValidator"] = factory();
	else
		root["VueModelValidator"] = factory();
})(this, function() {
return /******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	exports.install = function(Vue, global) {
	  var base, base1, base2, defaults, expressions, listener, old_init, on_missing_validator, parsed_expressions, run_all, run_single_validation, run_until_first, run_validations, runners, target_listener, watch_target;
	  if (global == null) {
	    global = {};
	  }
	  defaults = {
	    watch: false,
	    parse_all: true,
	    invalid_on_error: true,
	    watch_options: {
	      deep: false,
	      immediate: false,
	      sync: false
	    }
	  };
	  if (global.watch == null) {
	    global.watch = defaults.watch;
	  }
	  if (global.parse_all == null) {
	    global.parse_all = defaults.parse_all;
	  }
	  if (global.invalid_on_error == null) {
	    global.invalid_on_error = defaults.invalid_on_error;
	  }
	  if (global.watch == null) {
	    global.watch = defaults.watch;
	  }
	  if ((base = global.watch).deep == null) {
	    base.deep = defaults.watch.deep;
	  }
	  if ((base1 = global.watch).immediate == null) {
	    base1.immediate = defaults.watch.immediate;
	  }
	  if ((base2 = global.watch).sync == null) {
	    base2.sync = defaults.watch.sync;
	  }
	  Vue.options.validators = __webpack_require__(1);
	  Vue.validator = function(name, fn) {
	    if (name === "invalid") {
	      return Vue.util.warn("Model Validator: 'invalid' is reserved");
	    } else {
	      return Vue.options.validators[name] = fn;
	    }
	  };
	  expressions = function(vm) {
	    return vm.$options.validations || {};
	  };
	  runners = function(vm) {
	    return vm.$options.validators || {};
	  };
	  parsed_expressions = function(expression) {
	    return Vue.parsers.directive.parse(expression);
	  };
	  on_missing_validator = function(validation) {
	    Vue.util.warn("Model Validator: Missing validator " + validation);
	    return !global.invalid_on_error;
	  };
	  run_single_validation = function(item, vm, field) {
	    var result, validation, validator;
	    validation = item.arg || item.expression;
	    validator = runners(vm)[validation];
	    result = validator ? validator(field, vm.$get(field), item, vm) : on_missing_validator(validation);
	    vm.$set("validation." + field + "." + validation, !result);
	    return result;
	  };
	  run_all = function(field, expression, vm, value, validations) {
	    if (expression == null) {
	      expression = "";
	    }
	    return validations.map(function(item) {
	      return run_single_validation(item, vm, field);
	    }).indexOf(false) === -1;
	  };
	  run_until_first = function(field, expression, vm, value, validations) {
	    if (expression == null) {
	      expression = "";
	    }
	    return validations.every(function(item) {
	      return run_single_validation(item, vm, field);
	    });
	  };
	  run_validations = function(field, expression, vm, value) {
	    var result;
	    if (expression == null) {
	      expression = "";
	    }
	    result = global.parse_all ? run_all(field, expression, vm, value, parsed_expressions(expression)) : run_until_first(field, expression, vm, value, parsed_expressions(expression));
	    vm.$set("validation." + field + ".invalid", !result);
	    return result;
	  };
	  listener = function(field, expression, vm) {
	    if (expression == null) {
	      expression = "";
	    }
	    return function(value) {
	      return run_validations(field, expression, vm, value);
	    };
	  };
	  target_listener = function(field, expression, vm) {
	    if (expression == null) {
	      expression = "";
	    }
	    return function() {
	      return run_validations(field, expression, vm, vm.$get(field));
	    };
	  };
	  watch_target = function(field, expression, vm, options) {
	    var unwatches;
	    if (expression == null) {
	      expression = "";
	    }
	    if (options == null) {
	      options = global.watch_options;
	    }
	    unwatches = [];
	    parsed_expressions(expression).forEach(function(item) {
	      var key, validation;
	      validation = item.arg || item.expression;
	      if (key = runners(vm)[validation].watchTarget) {
	        return unwatches.push(vm.$watch(item[key], target_listener(field, item.raw, vm), options));
	      }
	    });
	    return unwatches;
	  };
	  Vue.prototype.$validate = function() {
	    var keys;
	    keys = arguments.length ? [].slice.call(arguments) : Object.keys(expressions(this));
	    return keys.map((function(_this) {
	      return function(key) {
	        var expression;
	        if (expression = expressions(_this)[key]) {
	          return listener(key, expression, _this)(_this.$get(key));
	        } else {
	          Vue.util.warn("Model Validator: Invalid validation target " + key);
	          return !global.invalid_on_error;
	        }
	      };
	    })(this)).indexOf(false) === -1;
	  };
	  Vue.prototype.$watch_validations = function(options) {
	    var expression, field, ref, unwatches;
	    if (options == null) {
	      options = global.watch_options;
	    }
	    unwatches = [];
	    ref = expressions(this);
	    for (field in ref) {
	      expression = ref[field];
	      unwatches = unwatches.concat(watch_target(field, expression, this, options));
	      unwatches.push(this.$watch(field, listener(field, expression, this), options));
	    }
	    return unwatches;
	  };
	  if (global.watch) {
	    old_init = Vue.prototype._init;
	    Vue.prototype._init = function(options) {
	      var old_created;
	      if (options == null) {
	        options = {};
	      }
	      old_created = options.created || function() {};
	      options.created = function() {
	        this.$watch_validations();
	        return old_created.apply(this, arguments);
	      };
	      return old_init.call(this, options);
	    };
	  }
	  return this;
	};


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	exports.email = __webpack_require__(2);

	exports['equal_to'] = __webpack_require__(3);

	exports['custom'] = __webpack_require__(4);

	exports.max = __webpack_require__(5);

	exports['max_length'] = __webpack_require__(6);

	exports.min = __webpack_require__(7);

	exports['min_length'] = __webpack_require__(8);

	exports.pattern = __webpack_require__(9);

	exports.required = __webpack_require__(10);


/***/ },
/* 2 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return (value == null) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$/.test(value);
	};


/***/ },
/* 3 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  this.watchTarget = "expression";
	  return value === vm.$get(item.expression);
	};


/***/ },
/* 4 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return vm[item.expression](value);
	};


/***/ },
/* 5 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return (value == null) || value <= +item.expression;
	};


/***/ },
/* 6 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return (value == null) || (value.length != null) && value.length <= +item.expression;
	};


/***/ },
/* 7 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return (value == null) || value >= +item.expression;
	};


/***/ },
/* 8 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return (value == null) || value.length && value.length >= +item.expression;
	};


/***/ },
/* 9 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return (value == null) || RegExp("" + (vm.constructor.util.stripQuotes(item.expression))).test(value);
	};


/***/ },
/* 10 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  if (typeof value === 'string') {
	    value = value.trim();
	  }
	  return ["", void 0, null, false].indexOf(value) === -1;
	};


/***/ }
/******/ ])
});
;