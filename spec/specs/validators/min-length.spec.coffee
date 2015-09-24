Vue = require("../../shared")

describe "validator: min-length", ->
  it "should validate minimum length", ->
    component = new Vue
      validations:
        "user.name": "min-length: 5"

    expect(component.$validate()).equal(false)

    component.$set("user.name", "aaaaa")

    expect(component.$validate()).equal(true)

    component.$set("user.name", "aaaa")

    expect(component.$validate()).equal(false)


