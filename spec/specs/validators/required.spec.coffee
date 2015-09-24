Vue = require("../../shared")

describe "validator: required", ->
  it "should validate presence", ->
    component = new Vue
      validations:
        "user.value": "required"

    expect(component.$validate()).equal(false)

    component.$set("user.value", 0)

    expect(component.$validate()).equal(true)

    component.$set("user.value", null)

    expect(component.$validate()).equal(false)

    component.$set("user.value", "0")

    expect(component.$validate()).equal(true)

    component.$set("user.value", "")

    expect(component.$validate()).equal(false)

    component.$set("user.value", false)

    expect(component.$validate()).equal(true)

    component.$set("user.value", "    ")

    expect(component.$validate()).equal(false)

    component.$set("user.value", true)

    expect(component.$validate()).equal(true)


