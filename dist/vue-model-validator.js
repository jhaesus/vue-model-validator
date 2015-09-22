/*!
 * vue-model-validator v0.0.1
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

	exports.install = function(Vue) {
	  var collection, listener, run_validations, target_listener, watch_targets;
	  Vue.options.validators = __webpack_require__(1);
	  Vue.validator = function(name, fn) {
	    return Vue.options.validators[name] = fn;
	  };
	  run_validations = function(field, expression, vm, value) {
	    var validations;
	    if (expression == null) {
	      expression = "";
	    }
	    validations = Vue.parsers.directive.parse(expression);
	    return vm.$set("validation." + field + ".invalid", !validations.every(function(item) {
	      var ref, result, validation;
	      validation = item.arg || item.expression;
	      result = (((ref = vm.$options.validators) != null ? ref[validation] : void 0) || Vue.options.validators[validation])(field, value, item, vm);
	      vm.$set("validation." + field + "." + validation, !result);
	      return result;
	    }));
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
	  watch_targets = function(field, expression, vm) {
	    if (expression == null) {
	      expression = "";
	    }
	    return Vue.parsers.directive.parse(expression).forEach(function(item) {
	      var arg, key, ref, validation;
	      validation = item.arg || item.expression;
	      arg = item.arg ? item.expression : void 0;
	      if (key = (((ref = vm.$options.validators) != null ? ref[validation] : void 0) || Vue.options.validators[validation]).watchTarget) {
	        return vm.$watch(item[key], target_listener(field, item.raw, vm), true, false);
	      }
	    });
	  };
	  collection = function(vm) {
	    return vm.$options.validations || {};
	  };
	  Vue.prototype.$validate = function() {
	    var keys;
	    keys = arguments.length ? [].slice.call(arguments) : Object.keys(collection(this));
	    return keys.map((function(_this) {
	      return function(key) {
	        listener(key, collection(_this)[key], _this)(_this.$get(key));
	        return !_this.$get("validation." + key + ".invalid");
	      };
	    })(this)).indexOf(false) === -1;
	  };
	  return Vue.prototype.$watch_validations = function() {
	    var expression, field, ref, results;
	    ref = collection(this);
	    results = [];
	    for (field in ref) {
	      expression = ref[field];
	      watch_targets(field, expression, this);
	      results.push(this.$watch(field, listener(field, expression, this), true, false));
	    }
	    return results;
	  };
	};


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	exports.confirmation = __webpack_require__(2);

	exports.email = __webpack_require__(3);

	exports['equal-to'] = __webpack_require__(4);

	exports['custom'] = __webpack_require__(5);

	exports.max = __webpack_require__(6);

	exports['max-length'] = __webpack_require__(7);

	exports.min = __webpack_require__(8);

	exports['min-length'] = __webpack_require__(9);

	exports.pattern = __webpack_require__(10);

	exports.required = __webpack_require__(11);


/***/ },
/* 2 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  var origin;
	  origin = field.replace(/_confirmation$/, "");
	  return value === vm.$get(origin);
	};


/***/ },
/* 3 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$/.test(value);
	};


/***/ },
/* 4 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  var arg;
	  this.watchTarget = "expression";
	  arg = item.arg ? item.expression : void 0;
	  return (value || "") === (vm.$get(arg) || "");
	};


/***/ },
/* 5 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return vm[item.expression](value);
	};


/***/ },
/* 6 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  var arg, validation;
	  validation = item.arg || item.expression;
	  arg = item.arg ? item.expression : void 0;
	  return value <= +arg;
	};


/***/ },
/* 7 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  var arg, validation;
	  validation = item.arg || item.expression;
	  arg = item.arg ? item.expression : void 0;
	  return !value || value.length && value.length <= +arg;
	};


/***/ },
/* 8 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  var arg, validation;
	  validation = item.arg || item.expression;
	  arg = item.arg ? item.expression : void 0;
	  return value >= +arg;
	};


/***/ },
/* 9 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  var arg, validation;
	  validation = item.arg || item.expression;
	  arg = item.arg ? item.expression : void 0;
	  return !value || value.length && value.length >= +arg;
	};


/***/ },
/* 10 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  var arg, validation;
	  validation = item.arg || item.expression;
	  arg = item.arg ? item.expression : void 0;
	  return RegExp("" + arg).test(value);
	};


/***/ },
/* 11 */
/***/ function(module, exports) {

	module.exports = function(field, value, item, vm) {
	  return !!value;
	};


/***/ }
/******/ ])
});
;