Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.age": "custom: oldenough"
    methods:
      oldenough: (value) ->
        value && value > 18

describe "validator: custom", ->
  it "should validate 19", ->
    component = make()
    component.$set("user.age", 19)
    expect(component.$validate()).equal(true)

  it "should validate 15", ->
    component = make()
    component.$set("user.age", 15)
    expect(component.$validate()).equal(false)


