Vue = require("../../shared")

describe "validator: max-length", ->
  it "should validate maximum length", ->
    component = new Vue
      validations:
        "user.name": "max-length: 5"

    expect(component.$validate()).equal(true)

    component.$set("user.name", "aaaaa")

    expect(component.$validate()).equal(true)

    component.$set("user.name", "aaaaaa")

    expect(component.$validate()).equal(false)


