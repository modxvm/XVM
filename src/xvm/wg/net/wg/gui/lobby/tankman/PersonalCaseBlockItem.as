package net.wg.gui.lobby.tankman 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class PersonalCaseBlockItem extends scaleform.clik.core.UIComponent
    {
        public function PersonalCaseBlockItem()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.skills.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            this.skills.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseOver);
            this.skills.removeEventListener(flash.events.MouseEvent.CLICK, this.skills_mouseClickHandler);
            this.skills.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.skills_buttonClickHandler);
            this.skills.dispose();
            this.skills = null;
            this.extra = null;
            this.value = null;
            this.label = null;
            this.model = null;
            this._skillName = null;
            return;
        }

        protected override function configUI():void
        {
            this.skills.buttonMode = true;
            super.configUI();
            var loc1:*=new net.wg.gui.events.PersonalCaseEvent(net.wg.gui.events.PersonalCaseEvent.GET_TANKMAN_ID, true);
            loc1.tankmanIdDelegate = this.getTankmanID;
            dispatchEvent(loc1);
            return;
        }

        public function set setData(arg1:Object):void
        {
            var loc2:*=null;
            this.model = arg1;
            var loc1:*=scaleform.gfx.Extensions.isScaleform ? MENU.profile_stats_items(this.model.name) : this.model.name;
            if (this.model.hasOwnProperty("imageType") && this.model.imageType == "new_skill") 
            {
                loc1 = MENU.PROFILE_STATS_ITEMS_READYTOLEARN;
                loc2 = "../maps/icons/tankmen/skills/small/" + this.model.image;
                this.addListenersToIcon();
                this.skills.x = this.value.x + this.value.width - this.skills.width + NEW_SKILLS_PADDING;
                this.value.visible = false;
            }
            else if (this.model.hasOwnProperty("imageType") && this.model.imageType == "role") 
            {
                loc2 = "../maps/icons/tankmen/roles/small/" + this.model.image;
                this.skills.y = this.skills.y + 2;
            }
            else if (this.model.hasOwnProperty("imageType") && this.model.imageType == "skill") 
            {
                loc2 = "../maps/icons/tankmen/skills/small/" + this.model.image;
                this.addListenersToIcon();
            }
            if (loc2) 
                this.skills.source = loc2;
            this.label.text = loc1;
            if (!(this.model.value == null) && !(this.model.value == undefined)) 
                this.value.text = this.model.value.toString();
            if (this.model.hasOwnProperty("extra") && !(this.model.extra == null) && !(this.model.extra == "")) 
                this.extra.text = this.model.extra.toString();
            else 
                this.extra.visible = false;
            return;
        }

        internal function addListenersToIcon():void
        {
            this.skills.buttonMode = true;
            this.skills.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            this.skills.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseOver);
            this.skills.addEventListener(flash.events.MouseEvent.CLICK, this.skills_mouseClickHandler);
            this.skills.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.skills_buttonClickHandler);
            return;
        }

        internal function onMouseOver(arg1:flash.events.MouseEvent):void
        {
            App.cursor.setCursor(net.wg.data.constants.Cursors.BUTTON);
            if (!this.model.hasOwnProperty("name") && !this.model.hasOwnProperty("tankmanID") && !(this.model.name == null)) 
                return;
            if (this.model.hasOwnProperty("imageType") && this.model.imageType == "new_skill") 
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN_NEW_SKILL, net.wg.data.managers.impl.TooltipProps.DEFAULT, this._tankmanID);
            else 
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN_SKILL, null, this._skillName, this._tankmanID);
            return;
        }

        public function getTankmanID(arg1:int, arg2:String):void
        {
            this._tankmanID = arg1;
            this._skillName = arg2;
            return;
        }

        internal function onMouseOut(arg1:flash.events.MouseEvent):void
        {
            App.cursor.setCursor(net.wg.data.constants.Cursors.ARROW);
            App.toolTipMgr.hide();
            return;
        }

        internal function skills_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.dispatchPersonalCaseEvent();
            return;
        }

        internal function skills_mouseClickHandler(arg1:flash.events.MouseEvent):void
        {
            this.dispatchPersonalCaseEvent();
            return;
        }

        internal function dispatchPersonalCaseEvent():void
        {
            dispatchEvent(new net.wg.gui.events.PersonalCaseEvent(net.wg.gui.events.PersonalCaseEvent.CHANGE_TAB_ON_TWO, true));
            return;
        }

        internal static const NEW_SKILLS_PADDING:int=11;

        public var skills:net.wg.gui.components.controls.UILoaderAlt;

        public var extra:flash.text.TextField;

        public var value:flash.text.TextField;

        public var label:flash.text.TextField;

        internal var model:Object;

        internal var _tankmanID:int=-1;

        internal var _skillName:String=null;
    }
}
