Vue = require("../shared")

describe "properties", ->
  it "should set properties on $validate", ->
    component = new Vue
      validations:
        "user.email": "required"

    expect(component.$get("validation.user.email.required")).equal(undefined)
    expect(component.$get("validation.user.email.invalid")).equal(undefined)

    component.$validate()

    expect(component.$get("validation.user.email.required")).equal(true)
    expect(component.$get("validation.user.email.invalid")).equal(true)

    component.$set("user.email", "test@email.com")

    component.$validate()

    expect(component.$get("validation.user.email.required")).equal(false)
    expect(component.$get("validation.user.email.invalid")).equal(false)

  it "should update properties after $watch_validations", ->
    component = new Vue
      validations:
        "user.email": "required"

    expect(component.$get("validation.user.email.required")).equal(undefined)
    expect(component.$get("validation.user.email.invalid")).equal(undefined)

    component.$watch_validations()

    component.$set("user.email", "test@email.com")

    Vue.nextTick ->
      expect(component.$get("validation.user.email.required")).equal(false)
      expect(component.$get("validation.user.email.invalid")).equal(false)


