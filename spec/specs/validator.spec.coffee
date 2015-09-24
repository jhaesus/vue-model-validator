Vue = require("../shared")

describe "Vue.validator", ->
  it "should allow registering global validations", ->
    Vue.validator "test", (field, value, item, vm) ->
      value == "test"

    component = new Vue
      validations:
        "user.email": "test"

    expect(component.$validate()).equal(false)

    component.$set("user.email", "test")

    expect(component.$validate()).equal(true)

    component.$set("user.email", "test2")

    expect(component.$validate()).equal(false)


