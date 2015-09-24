Vue = require("../../shared")

describe "validator: custom", ->
  it "should call vue methods", ->
    component = new Vue
      validations:
        "user.age": "custom: oldenough"
      methods:
        oldenough: (value) ->
          value && value > 18

    expect(component.$validate("user.age")).equal(false)

    component.$set("user.age", 19)

    expect(component.$validate()).equal(true)

    component.$set("user.age", 15)

    expect(component.$validate()).equal(false)


