package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.tankman.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class SkillsItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function SkillsItemRenderer()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onShowSkillTab);
            this.rank_mc.dispose();
            this.loader.dispose();
            this.bg = null;
            this.level_mc = null;
            this.notActive = null;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(DATA_CHANGED)) 
            {
                this.setup(this.data);
            }
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            invalidate(DATA_CHANGED);
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
            {
                return;
            }
            super.setData(arg1);
            invalidate(DATA_CHANGED);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            return;
        }

        internal function onRollOver(arg1:flash.events.MouseEvent):void
        {
            if (!data.hasOwnProperty("name") && !data.hasOwnProperty("tankmanID") && !(data.name == null)) 
            {
                return;
            }
            if (data.isNewSkill) 
            {
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN_NEW_SKILL, null, data.tankmanID);
            }
            else 
            {
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN_SKILL, null, data.name, data.tankmanID);
            }
            return;
        }

        internal function onRollOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public function setup(arg1:Object):void
        {
            var data:Object;
            var c:flash.geom.ColorTransform;

            var loc1:*;
            c = null;
            data = arg1;
            if (data == null) 
            {
                return;
            }
            buttonMode = true;
            this.roleIco = this.rank_mc.icoLoader;
            try 
            {
                if (data.icon == null) 
                {
                    this.loader.visible = false;
                }
                else 
                {
                    this.loader.visible = !data.isNewSkill;
                    this.loader.source = data.icon;
                }
                this.rank_mc.visible = !data.isCommon;
                if (!data.isCommon) 
                {
                    this.role_ico_path = data.roleIcon;
                    this.roleIco.source = this.role_ico_path;
                    this.rank_mc.gotoAndPlay(data.enabled ? "enabled" : "disabled");
                }
                if (!data.isActive || !data.enabled) 
                {
                    c = new flash.geom.ColorTransform();
                    c.alphaMultiplier = 1;
                    c.redMultiplier = 0.6;
                    c.greenMultiplier = 0.6;
                    c.blueMultiplier = 0.6;
                    this.loader.transform.colorTransform = c;
                }
                else 
                {
                    this.loader.transform.colorTransform = new flash.geom.ColorTransform();
                }
                this.bg.gotoAndPlay(data.isNewSkill ? "new_skill" : !data.isActive || !data.enabled ? "not_active_up" : "active_up");
                this.notActive.visible = (!data.isActive || !data.enabled) && !data.isNewSkill;
                this.loadingBar.visible = !data.isNewSkill;
                this._titleLabel.visible = !data.isNewSkill;
                if (data.isNewSkill) 
                {
                    this.rank_mc.visible = false;
                    if (data.skillsCountForLearn > 1) 
                    {
                        this.level_mc.visible = true;
                        this.level_mc.rankTf.text = (data.skillsCountForLearn - 1).toString();
                        this.level_mc.rankTf.filters = null;
                        this.level_mc.rankTf.filters = getRankGlowFilter();
                    }
                    else 
                    {
                        this.level_mc.visible = false;
                    }
                    if (!this.hasOwnProperty(scaleform.clik.events.ButtonEvent.CLICK)) 
                    {
                        this.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onShowSkillTab);
                    }
                }
                else 
                {
                    this.level_mc.visible = false;
                    if (data.level == 100) 
                    {
                        if (this.loadingBar is scaleform.clik.controls.StatusIndicator) 
                        {
                            this.loadingBar.visible = false;
                        }
                        this._titleLabel.visible = false;
                    }
                    if (this.loadingBar is scaleform.clik.controls.StatusIndicator) 
                    {
                        this.loadingBar.position = Number(data.level);
                        if (Number(data.level) != 0) 
                        {
                            this.loadingBar.setActualSize(PROGRESS_BAR_WIDTH, PROGRESS_BAR_HEIGHT);
                        }
                    }
                    this._titleLabel.text = String(data.level) + "%";
                    this.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onShowSkillTab);
                }
                this.level_mc.alpha = Number(this.level_mc.visible);
            }
            catch (e:Error)
            {
                DebugUtils.LOG_DEBUG(" ERROR setup");
            }
            return;
        }

        public function onShowSkillTab(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.events.PersonalCaseEvent(net.wg.gui.events.PersonalCaseEvent.CHANGE_TAB_ON_TWO, true));
            return;
        }

        internal static function getRankGlowFilter():Array
        {
            var loc1:*=[];
            var loc2:*=16724246;
            var loc3:*=0.5;
            var loc4:*=6;
            var loc5:*=6;
            var loc6:*=4;
            var loc7:*=3;
            var loc8:*=false;
            var loc9:*=false;
            var loc10:*=new flash.filters.GlowFilter(loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9);
            loc1.push(loc10);
            return loc1;
        }

        internal static const PROGRESS_BAR_WIDTH:uint=54;

        internal static const PROGRESS_BAR_HEIGHT:uint=18;

        protected static const DATA_CHANGED:String="dataChanged";

        public var loader:net.wg.gui.components.controls.UILoaderAlt;

        public var loadingBar:scaleform.clik.controls.StatusIndicator;

        public var _titleLabel:flash.text.TextField;

        public var bg:flash.display.MovieClip;

        public var level_mc:flash.display.MovieClip;

        public var rank_mc:net.wg.gui.lobby.tankman.RankElement;

        public var notActive:flash.display.MovieClip;

        public var roleIco:net.wg.gui.components.controls.UILoaderAlt;

        public var role_ico_path:String="";
    }
}
