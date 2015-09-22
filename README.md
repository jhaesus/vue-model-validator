# vue-model-validator

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
    "user.email": "required"
  }
  methods: {
    on_submit: function(e) {
      if(this.$validate()) {
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
    validation.user.email.required (true if the validation passed)
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
      "user.email": "min-length: 3"
    }
  });
```

### max-length
```javascript
  Vue.extend({
    validate: {
      "user.email": "max-length: 255"
    }
  });
```

### min
```javascript
  Vue.extend({
    validate: {
      "user.images": "min: 1"
    }
  });
```

### max
```javascript
  Vue.extend({
    validate: {
      "user.images": "max: 3"
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
      "user.password": "equal-to: user.password_confirmation"
    }
  });
```

### confirmation
```javascript
  Vue.extend({
    validate: {
      "user.password": "confirmation"
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


# License

[MIT](http://opensource.org/licenses/MIT)
