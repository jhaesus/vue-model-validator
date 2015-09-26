Vue = require("../../shared")

describe "validator: max_length", ->
  it "should validate maximum length", ->
    component = new Vue
      validations:
        "user.name": "max_length: 5"

    expect(component.$validate()).equal(true)

    component.$set("user.name", "aaaaa")

    expect(component.$validate()).equal(true)

    component.$set("user.name", "aaaaaa")

    expect(component.$validate()).equal(false)


