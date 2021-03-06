package MVC.Models.AnimationObject;


import MVC.Controllers.AnimationController;
import MVC.Controllers.TeacherController;
import javafx.scene.image.Image;
import javafx.util.Pair;

import java.util.Random;
import java.util.regex.Pattern;

/**
 * This class handles ...
 *
 * @author Leo Persson
 * @version 1.0
 *
 * @editor Laiz Figueroa and Leo Persson
 * @version 1.1 Modifications: Added a method for check the
 * devices based on the deployment diagram.
 *
 */

public class DrawableObject {
    public String name;
    public Image image;
    public int x, y;

    /**
     * Method for checking the device on the deployment diagram
     */
    public void checkDevice () {

        String device = name.split (Pattern.quote ("Device: "))[1];
        for (Pair<String, Image> deviceImage : AnimationController.deviceImages) {
            if (deviceImage.getKey ().compareTo (device) == 0) {
                image = deviceImage.getValue ();
            }
        }
    }

    /**
     * Constructor to select a random position to a house and
     * sets the name of it.
     */
    public DrawableObject (Object obj, int x, int y) {
        Random rand = new Random ();
        if (TeacherController.user == "teacher") {
            this.x = rand.nextInt (x - 2) + 1;
            this.y = rand.nextInt (y - 2) + 1;
        } else {
            this.x = x;
            this.y = y;
        }
        name = obj.toString ();
    }
}
