package com.colorcodecanvas.circlesonar.color;

import java.util.Optional;

public class ColorService {
  public String guessColorByAnimal(String animal) {
    String color;
    switch (animal) {
      case "lion":
        color = "yellow";
        break;
      case "dog":
        color = "black";
        break;
      case "cat":
        color = "blue";
        break;
      case "owl":
        color = "brown1";
        break;
      default:
        color = "white";
    }
    return color;
  }
}