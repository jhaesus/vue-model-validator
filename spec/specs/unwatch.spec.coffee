Vue = require("../shared")

describe "unwatch", ->
  it "gets returned from $watch_validations", ->
    component = new Vue
      validations:
        "user.email": "required"

    unwatches = component.$watch_validations()

    expect(component.$get("validation.user.email.required")).equal(undefined)
    expect(component.$get("validation.user.email.invalid")).equal(undefined)

    component.$set("user.email", "test@email.com")

    Vue.nextTick ->
      expect(component.$get("validation.user.email.required")).equal(false)
      expect(component.$get("validation.user.email.invalid")).equal(false)

      component.$set("user.email", null)

      Vue.nextTick ->
        expect(component.$get("validation.user.email.required")).equal(true)
        expect(component.$get("validation.user.email.invalid")).equal(true)

        unwatches.forEach((unwatch) -> unwatch())

        component.$set("user.email", "test@email.com")

        Vue.nextTick ->
          expect(component.$get("validation.user.email.required")).equal(true)
          expect(component.$get("validation.user.email.invalid")).equal(true)

          expect(component.$validate()).equal(true)

          expect(component.$get("validation.user.email.required")).equal(false)
          expect(component.$get("validation.user.email.invalid")).equal(false)

