Vue = require("../../node_modules/vue/dist/vue")
Validator = require("../../src/index")

Vue.use Validator, watch: true

describe "automatic watching", ->
  it "should call $watch_validations on initialization when enabled", ->
    component = new Vue
      validations:
        "user.email": "required"

    component.$set("user.email", "test@email.com")

    Vue.nextTick ->
      expect(component.$get("validation.user.email.required")).equal(false)
      expect(component.$get("validation.user.email.invalid")).equal(false)
