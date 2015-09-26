# vue-model-validator [![Build Status](https://travis-ci.org/jhaesus/vue-model-validator.svg?branch=master)](https://travis-ci.org/jhaesus/vue-model-validator)

Model validator component for Vue.js

# Installation

## npm
```shell
$ npm install vue-model-validator
```

# Usage
```javascript
  var Vue = require('vue')
  var Validator = require('vue-model-validator')

  Vue.use(Validator)
```
```javascript
  Vue.extend({
    created: function() {
      this.$watch_validations()
    },
    validate: {
      // can use multiple validations, vue directive style
      "user.email": "required, min-length: 3",
      "user.password": "required, min-length: 6"
      "user.password_confirmation": "required, min-length: 6"
      
    }
    methods: {
      on_create: function(e) {
        // checks all validations
        if(this.$validate()) {
        }
      },
      on_update: function(e) {
        // checks only user.email and user.password validations
        if(this.$validate("user.email", "user.password")) {
        }
      }
    }
  });
```

# Properties

## validation
For example, if you use `required` validator on the user.email model, then you will have model properties set up
```
    validation.user.email.invalid (true if any validations didn't pass)
    validation.user.email.required (true if the validation didn't pass)
```
# Validators

## build-in validator

### required
```javascript
  Vue.extend({
    validate: {
      "user.email": "required"
    }
  });
```

### pattern
```javascript
  Vue.extend({
    validate: {
      "user.email": "pattern: '.*'"
    }
  });
```

### min-length
```javascript
  Vue.extend({
    validate: {
      "user.email": "min_length: 3"
    }
  });
```

### max-length
```javascript
  Vue.extend({
    validate: {
      "user.email": "max_length: 255"
    }
  });
```

### min
```javascript
  Vue.extend({
    validate: {
      "user.images.length": "min: 1"
    }
  });
```

### max
```javascript
  Vue.extend({
    validate: {
      "user.images.length": "max: 3"
    }
  });
```

### email
```javascript
  Vue.extend({
    validate: {
      "user.email": "email"
    }
  });
```

### equal-to
```javascript
  Vue.extend({
    validate: {
      "user.password": "equal_to: user.password_confirmation"
    }
  });
```

### custom

```javascript
  Vue.extend({
    validate: {
      "user.images": "custom: myfunc"
    },
    methods: {
      myfunc: function(value) {
        return true;
      }
    }
  });
```

## Adding/Overwriting validators
```javascript
  Vue.validator("my_validator", function(field_name, value, directive, vm) {
    return true;
  });
```

# License

[MIT](http://opensource.org/licenses/MIT)
