Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.value": "pattern: '^bla'"

describe "validator: pattern", ->
  it "should validate 'blaasdadsad'", ->
    component = make()
    component.$set("user.value", "blaasdadsad")
    expect(component.$validate()).equal(true)

  it "should validate null", ->
    component = make()
    component.$set("user.value", null)
    expect(component.$validate()).equal(true)

  it "should validate 'bla'", ->
    component = make()
    component.$set("user.value", "bla")
    expect(component.$validate()).equal(true)

  it "should validate 'xxx'", ->
    component = make()
    component.$set("user.value", "xxx")
    expect(component.$validate()).equal(false)

  it "should validate ''", ->
    component = make()
    component.$set("user.value", "")
    expect(component.$validate()).equal(false)

  it "should validate false", ->
    component = make()
    component.$set("user.value", false)
    expect(component.$validate()).equal(false)

  it "should validate '    '", ->
    component = make()
    component.$set("user.value", "    ")
    expect(component.$validate()).equal(false)

  it "should validate true", ->
    component = make()
    component.$set("user.value", true)
    expect(component.$validate()).equal(false)


