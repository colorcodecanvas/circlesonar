package com.colorcodecanvas.circlesonar.color

import spock.lang.Specification

class ColorServiceSpec extends Specification {
  ColorService service = new ColorService()

  def "guess color for a person with lion as favorite animal"() {
    when:
    def guessedColor = service.guessColorByAnimal('lion')

    then:
    guessedColor == 'yellow'
  }

  def "guess color for a person with owl as favorite animal"() {
    when:
    def guessedColor = service.guessColorByAnimal('owl')

    then:
    guessedColor == 'brown'
  }
}
