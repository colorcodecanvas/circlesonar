package com.colorcodecanvas.circlesonar.color;

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
      default:
        color = "white";
    }
    return color;
  }
}