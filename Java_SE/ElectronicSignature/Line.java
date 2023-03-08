package ElectronicSignature;

import java.awt.*;
import java.io.Serializable;
import java.util.HashMap;
import java.util.LinkedList;

public class Line implements Serializable {
    private final LinkedList<HashMap<String, Integer>> points;
    private Color fontColor;

    public Line(){
        fontColor = Color.BLACK;
        points = new LinkedList<>();
    }

    public LinkedList<HashMap<String, Integer>> getPoints() {
        return points;
    }

    public Color getFontColor() {
        return fontColor;
    }

    public void setFontColor(Color fontColor) {
        this.fontColor = fontColor;
    }
}
