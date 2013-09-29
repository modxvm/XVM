package net.wg.gui.lobby.tankman 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.events.*;
    
    public class PersonalCaseSkillsItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function PersonalCaseSkillsItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            if (this.icon) 
            {
                this.icon.dispose();
            }
            if (this.rank) 
            {
                this.rank.dispose();
            }
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            buttonMode = true;
            allowDeselect = false;
            super.configUI();
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            return;
        }

        public function showTooltip(arg1:flash.events.MouseEvent=null):void
        {
            if (this.isHeader) 
            {
                App.toolTipMgr.hide();
            }
            else 
            {
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN_SKILL, null, data.title, data.tankmanID);
            }
            return;
        }

        public function hideTooltip(arg1:flash.events.MouseEvent=null):void
        {
            if (!this.isHeader) 
            {
                App.toolTipMgr.hide();
            }
            return;
        }

        public function onSelect(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (!this.isHeader) 
            {
                App.toolTipMgr.hide();
            }
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
            {
                if (this.visible) 
                {
                    this.visible = false;
                }
                return;
            }
            if (!this.visible) 
            {
                this.visible = true;
            }
            super.setData(arg1);
            var loc1:*=new flash.geom.Point(mouseX, mouseY);
            loc1 = this.localToGlobal(loc1);
            if (this.hitTestPoint(loc1.x, loc1.y, true) && !this.isHeader) 
            {
                setState("over");
                App.utils.scheduler.scheduleTask(this.showTooltip, 100);
            }
            else 
            {
                this.hideTooltip();
            }
            this.initVisibleElements();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(this.UPDATE_DATA) && this.isData) 
            {
                this.updateData();
            }
            return;
        }

        internal function updateData():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.isHeader) 
            {
                this._name.text = App.utils.locale.makeString("#dialogs:addSkillWindow/label/" + data.title).toUpperCase();
                this.desc.text = data.rankId == "common" || data.selfSkill ? "" : "#item_types:tankman/Skill_not_be_used";
                this.rank.visible = false;
            }
            else 
            {
                this.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.doubleClickHandler);
                this._name.text = data.name;
                this.desc.visible = true;
                this.desc.text = data.desc;
                if (data.title != "common") 
                {
                    if (!this.icon.visible) 
                    {
                        this.icon.visible = true;
                    }
                    loc1 = "../maps/icons/tankmen/skills/big/" + data.title + ".png";
                    this.icon.source = loc1;
                    if (data.rankId == "common") 
                    {
                        this.rank.visible = false;
                    }
                    else 
                    {
                        this.rank.visible = true;
                        this.rank.gotoAndStop(data.enabled ? "enabled" : "disabled");
                        loc2 = "../maps/icons/tankmen/roles/small/" + data.rankId + ".png";
                        this.rank.setData(loc2, data.enabled);
                        this.rank.validateNow();
                    }
                }
                else 
                {
                    this.rank.visible = false;
                }
            }
            this.isData = false;
            return;
        }

        internal function initVisibleElements():void
        {
            this.isHeader = data.isHeader;
            if (data.isHeader) 
            {
                enabled = false;
            }
            this.isData = true;
            invalidate(this.UPDATE_DATA);
            return;
        }

        internal function doubleClickHandler(arg1:flash.events.MouseEvent):void
        {
            DebugUtils.LOG_DEBUG("[PersonalCaseSkillsItemRenderer] : [doubleClickHandler : dispatch event]");
            dispatchEvent(new flash.events.Event(SKILL_DOUBLE_CLICK, true));
            return;
        }

        internal const UPDATE_DATA:String="updateData";

        public static const SKILL_DOUBLE_CLICK:String="skillDoubleClick";

        public var clickArea:flash.display.MovieClip;

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var rank:net.wg.gui.lobby.tankman.SkillsItemsRendererRankIcon;

        public var _name:flash.text.TextField;

        public var desc:flash.text.TextField;

        internal var isHeader:Boolean=false;

        internal var isData:Boolean=false;

        public var focusIndicatorUI:flash.display.MovieClip;
    }
}
