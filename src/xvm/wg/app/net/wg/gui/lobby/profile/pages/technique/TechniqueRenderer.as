package net.wg.gui.lobby.profile.pages.technique
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.profile.components.*;
    import scaleform.clik.constants.*;

    public class TechniqueRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function TechniqueRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.mouseChildren = true;
            this.masteryIcon.mouseChildren = false;
            this.masteryIcon.buttonMode = true;
            buttonMode = true;
            hitArea = this.hit;
            return;
        }

        public override function set mouseChildren(arg1:Boolean):void
        {
            super.mouseChildren = true;
            return;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA))
            {
                loc1 = false;
                if (data)
                {
                    loc1 = true;
                    loc5 = net.wg.gui.lobby.profile.pages.technique.TechniqueListVehicleVO(data);
                    this.vehicleTF.text = loc5.shortUserName;
                    this.battlesTF.text = getString(loc5.battlesCount);
                    this.winsTF.text = loc5.winsEfficiencyStr;
                    loc6 = loc5.avgExperience;
                    this.avgExpTF.text = loc6 != 0 ? getString(loc6) : "";
                    this.nationIcon.source = loc5.nationIconPath;
                    this.typeIcon.source = loc5.typeIconPath;
                    this.tankSmallIcon.source = loc5.tankIconPath;
                    loc7 = getSmallMasteryIconPath(loc5.markOfMastery);
                    if (loc7)
                    {
                        this.masteryIcon.source = loc7;
                    }
                    else
                    {
                        this.masteryIcon.unload();
                    }
                    this.masteryIcon.data = loc5;
                    this.levelMC.gotoAndStop(loc5.level);
                }
                else
                {
                    this.masteryIcon.unload();
                    this.masteryIcon.data = null;
                }
                loc3 = numChildren;
                loc4 = 0;
                while (loc4 < loc3)
                {
                    loc2 = getChildAt(loc4);
                    if (loc2 != this.background)
                    {
                        loc2.visible = loc1;
                    }
                    ++loc4;
                }
            }
            return;
        }

        internal static function getSmallMasteryIconPath(arg1:int):String
        {
            if (arg1 > 0)
            {
                return "../maps/icons/library/proficiency/class_icons_" + arg1 + ".png";
            }
            return null;
        }

        internal static function getString(arg1:Number):String
        {
            if (App.utils)
            {
                return App.utils.locale.integer(arg1);
            }
            return arg1.toString();
        }

        public var vehicleTF:flash.text.TextField;

        public var battlesTF:flash.text.TextField;

        public var winsTF:flash.text.TextField;

        public var avgExpTF:flash.text.TextField;

        public var nationIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var typeIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var tankSmallIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var masteryIcon:net.wg.gui.lobby.profile.components.TechMasteryIcon;

        public var levelMC:flash.display.MovieClip;

        public var background:flash.display.MovieClip;

        public var hit:flash.display.MovieClip;
    }
}
