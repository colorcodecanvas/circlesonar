package com.colorcodecanvas.circlesonar.color;

import static io.vavr.API.$;
import static io.vavr.API.Case;
import static io.vavr.API.Match;

public class ColorService {
  public String guessColorByAnimal(String animal) {
    return Match(animal).of(
      Case($("lion"), "yellow"),
      Case($("dog"), "black"),
      Case($("cat"), "blue"),
      Case($("elephant"), "grey"),
      Case($(), "white")
    );
  }
}