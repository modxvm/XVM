/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vehiclemarkers.ui.*;

    public class DamageTextComponent extends VehicleMarkerComponentBase
    {
        public function DamageTextComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATEHEALTH, showDamage);
        }

        //private var damage:MovieClip;

        //public function init()
        //{
            //damage = proxy.createHolder();
        //}
//
        /**
         * Show floating damage indicator
         * @param	cfg damageText config section for current state
         * @param	newHealth value of new health
         * @param	delta absolute damage
         * @param	flag  damage source: 0 - "FROM_UNKNOWN", 1 - "FROM_ALLY", 2 - "FROM_ENEMY", 3 - "FROM_SQUAD", 4 - "FROM_PLAYER"
         * @param	damageType damage kind: "shot", "fire", "ramming", "world_collision", "death_zone", "drowning"
         */
        public function showDamage(e:XvmVehicleMarkerEvent):void
        {

            //if (!cfg.visible)
                //return;
        }
//
            //var text:String = defineText(cfg, newHealth, delta, flag, damageType);
//
            //var color:Number;
            //if (cfg.color == null)
            //{
                //color = ColorsManager.getDamageSystemColor(Utils.damageFlagToDamageSource(flag), proxy.damageDest,
                    //damageType, proxy.isDead, proxy.isBlowedUp);
            //}
            //else
            //{
                //color = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.color), delta, flag, damageType);
            //}
//
            //var shadowColor:Number;
            //if (cfg.shadow.color == null)
            //{
                //shadowColor = ColorsManager.getDamageSystemColor(Utils.damageFlagToDamageSource(flag), proxy.damageDest,
                    //damageType, proxy.isDead, proxy.isBlowedUp);
            //}
            //else
            //{
                //shadowColor = proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.shadow.color), delta, flag, damageType);
            //}
//
            //// TODO: dynamic alpha?
            ////var alpha = proxy.formatDynamicAlpha(cfg.alpha);
            ////var shadowAlpha = proxy.formatDynamicAlpha(cfg.shadow.alpha);
//
            //var tf:TextField = createTextField(color, shadowColor, cfg);
//
            //tf.htmlText = "<textformat leading='-2'><p class='xvm_damageText'>" + text + "</p></textformat>";
            ////com.xvm.Logger.add("dmg: " + flagToDamageSource(flag) + ", " + proxy.damageDest + " - color=" + color);
            ////com.xvm.Logger.add(tf.htmlText);
//
            //var dummy = new DamageTextAnimation(cfg, tf); // defines and starts
        //}
//
        //public function updateState(state_cfg:Object)
        //{
            //damage._visible = true;
        //}
//
        //// PRIVATE METHODS
//
        //private function createTextField(color:Number, shadowColor:Number, cfg):TextField
        //{
            //var n = damage.getNextHighestDepth();
            //var tf: TextField = damage.createTextField("txt" + n, n, cfg.x, cfg.y, 200, 100);
//
            //tf.antiAliasType = "advanced";
            //tf.multiline = true;
            //tf.wordWrap = false;
//
            //tf.html = true;
            //tf.styleSheet = Utils.createStyleSheet(Utils.createCSSFromConfig(cfg.font, color, "xvm_damageText"));
        ///*
        //public static function createCSSFromConfig(config_font:Object, color:Number, className:String):String
        //{
            //return createCSS(className,
                //color,
                //config_font && config_font.name ? config_font.name : "$FieldFont",
                //config_font && config_font.size ? config_font.size : 13,
                //config_font && config_font.align ? config_font.align : "center",
                //config_font && config_font.bold ? true : false,
                //config_font && config_font.italic ? true : false);
        //}
        //*/
//
            //tf.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance, cfg.shadow.angle, shadowColor,
                //cfg.shadow.alpha, cfg.shadow.size, cfg.shadow.strength) ];
//
            //tf._x -= (tf._width / 2.0);
//
    ///*        var b1:flash.display.BitmapData = new flash.display.BitmapData(16, 16);
            //var matrix:flash.geom.Matrix = new flash.geom.Matrix()
            //b1.draw(proxy.xvm.clanIconComponent.m_clanIcon, matrix);
            //tf.setImageSubstitutions([ { subString:"[", image:b1 } ]);*/
//
            //return tf;
        //}
//
        //private function defineText(cfg:Object, newHealth:Number, delta:Number, damageFlag:Number, damageType:String):String
        //{
            //var msg = (newHealth < 0) ? Locale.get(cfg.blowupMessage) : cfg.damageMessage;
            //var text = proxy.formatDynamicText(msg, newHealth, delta, damageFlag, damageType);
            //// For some reason, DropShadowFilter is not rendered when textfield contains only one character,
            //// so we're appending empty prefix and suffix to bypass this unexpected behavior
            //// UPD: But with .html=true all is OK.
            //return /* " " + */ text /* + " "*/;
        //}
    }
}


//class DamageTextAnimation
//{
    //// Animates textField and cleans it up.
//
    //private var tf:TextField;
    //private var timeline:TimelineLite;
//
    //private static var EMERGE_DURATION:Number = 0.3;
    //private static var TINT_DURATION:Number = 0.3;
    //// Opacity animates in last N seconds of movement animation
    //private static var FADEOUT_DURATION:Number = 0.5;
    //private static var FADEOUT_TIME_OFFSET:Number = - FADEOUT_DURATION;
//
    ///**
     //*  Legend:
     //*   # : operation in progress
     //*   + : operation complete and result is visible
     //*
     //*              0s    0.5s  1s    1.5s  delay Xs
     //*  emerge      ###++ +++++ +++++ +++++ ~ ~ ~ -----
     //*  tint        ###
     //*  moveUpward  ##### ##### ##### ##### ~ ~ ~ +++++
     //*  fadeOut     ----- ----- ----- ----- ~ ~ ~ #####
     //*/
//
     ///**
      //* In case of whiteFlash coding:
      //* Tint recolors Glow? Recolors shadowFilter?
      //* Make two movieclips?
      //* Use GraphicsUtil.createShadowFilter and tween filter?
      //*/
//
    //public function DamageTextAnimation(cfg:Object, tf:TextField)
    //{
        //this.tf = tf;
//
        //var movementDuration:Number = cfg.speed;
        //var distanceUpward:Number = - cfg.maxRange + cfg.y;
//
        //timeline = new TimelineLite({onComplete:removeTextField});
//
        //timeline.insert(emerge(), 0);
        //timeline.insert(tint(), 0);
        //timeline.insert(moveUpward(movementDuration, distanceUpward), 0);
        //timeline.append(fadeOut(), FADEOUT_TIME_OFFSET);
    //}
//
    //private function emerge():TweenLite
    //{
        //return TweenLite.from(tf, EMERGE_DURATION, { _alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    //}
//
    //private function tint():TweenLite
    //{
        //return TweenLite.from(tf, TINT_DURATION, { tint:"0xFFFFFF", ease: Linear.easeNone, cacheAsBitmap:true } );
    //}
//
    //private function moveUpward(movementDuration:Number, distanceUpward:Number):TweenLite
    //{
        //return TweenLite.to(tf, movementDuration, { _y:distanceUpward, ease:Linear.easeNone, cacheAsBitmap:true } );
    //}
//
    //private function fadeOut():TweenLite
    //{
        //return TweenLite.to(tf, FADEOUT_DURATION, { _alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    //}
//
    //private function removeTextField():Void
    //{
        //tf.removeTextField();
        //delete tf;
    //}
//}
