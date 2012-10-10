import com.greensock.TimelineLite;
import wot.utils.Animation;
//import wot.utils.Logger;

class wot.VehicleMarkersManager.components.damage.DamageTextAnimation
{
    // Animates textField and cleans it up.
    private var textField:TextField;

    public function DamageTextAnimation(cfg:Object, textField:TextField)
    {
        this.textField = textField;

        var timeline:TimelineLite = new TimelineLite( { onComplete:removeTextField } );
        var animation:Animation = new Animation(timeline, textField);
        animation.evaluate(cfg.animation, cfg);
    }

    private function removeTextField():Void
    {
        textField.removeTextField();
        delete textField;
    }
}
