/**
 * @author sirmax
 */
import com.xvm.*;
import com.greensock.*;
import com.greensock.easing.*;
import net.wargaming.controls.*;
import net.wargaming.managers.*;

class wot.battle.SixthSenseIndicator
{
    var sixthSenseIndicatorXvm:MovieClip;
    var icon:UILoaderAlt;

    public function SixthSenseIndicator()
    {
        GlobalEventDispatcher.addEventListener(Defines.E_UPDATE_STAGE, this, onUpdateStage);

        // override _root.sixthSenseIndicator.gotoAndPlay()
        _root.sixthSenseIndicator.gotoAndPlay2 = _root.sixthSenseIndicator.gotoAndPlay;
        _root.sixthSenseIndicator.gotoAndPlay = sixthSenseIndicator_gotoAndPlay;

        sixthSenseIndicatorXvm = _root.createEmptyMovieClip("sixthSenseIndicatorXvm", _root.getNextHighestDepth());
        sixthSenseIndicatorXvm._y = 80;
        sixthSenseIndicatorXvm._alpha = 0;

        icon = (UILoaderAlt)(sixthSenseIndicatorXvm.attachMovie("UILoaderAlt", "icon", 0));

        var il:IconLoader = new IconLoader(this, completeLoadSixthSenseIcon);
        il.init(icon, [ Defines.SIXTH_SENSE_IMG, "" ], false);

        icon.source = il.currentIcon;
        icon.onLoadInit = icon_onLoadInit;
    }

    function icon_onLoadInit(mc:MovieClip)
    {
        icon.setSize(mc._width, mc._height);
    }

    private function completeLoadSixthSenseIcon(event)
    {
        //Logger.add("completeLoadSixthSenseIcon");

        var $this = this;
        _global.setTimeout(function() { $this.onUpdateStage(); }, 1);

        // DEBUG
        //var a = "fade"; _global.setInterval(function() { a = a == "fade" ? "active" : "fade"; _root.sixthSenseIndicator.gotoAndPlay(a) }, 3000);
    }

    private function onUpdateStage(e)
    {
        if (icon.content._width != undefined)
            sixthSenseIndicatorXvm._x = BattleState.screenSize.width / 2 - icon.content._width / 2;
    }

    // context: _root.sixthSenseIndicator

    private function sixthSenseIndicator_gotoAndPlay(frame)
    {
        //Logger.add("sixthSenseIndicator_gotoAndPlay: " + frame);

        if (frame == "active")
            SoundManager.playSound("sixthsense", "normal", "");

        if (icon.source == "")
        {
            _root.sixthSenseIndicator.gotoAndPlay2(frame);
            return;
        }

        switch (frame)
        {
            case "active":
                var timeline = new TimelineLite();
                timeline.insert(TweenLite.to(_root.sixthSenseIndicatorXvm, 0.2, { _alpha:100, ease:Linear.easeNone } ), 0);
                timeline.append(TweenLite.from(_root.sixthSenseIndicatorXvm, 0.2, { tint:"0xFFFFFF", ease: Linear.easeNone } ), 0);
                break;
            case "inactive":
 		TweenLite.to(_root.sixthSenseIndicatorXvm, 0.2, {_alpha:70});
                break;
            case "fade":
 		TweenLite.to(_root.sixthSenseIndicatorXvm, 0.5, {_alpha:0});
                break;
        }
    }
}
