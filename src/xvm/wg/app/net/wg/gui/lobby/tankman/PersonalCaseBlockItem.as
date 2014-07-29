package net.wg.gui.lobby.tankman
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.PersonalCaseEvent;
    import scaleform.gfx.Extensions;
    import net.wg.data.constants.Cursors;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.managers.impl.TooltipProps;
    
    public class PersonalCaseBlockItem extends UIComponent
    {
        
        public function PersonalCaseBlockItem()
        {
            super();
        }
        
        private static var NEW_SKILLS_PADDING:int = 11;
        
        public var skills:UILoaderAlt;
        
        public var extra:TextField;
        
        public var value:TextField;
        
        public var label:TextField;
        
        private var model:Object;
        
        private var _tankmanID:int = -1;
        
        private var _skillName:String = null;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.skills.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            this.skills.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseOver);
            this.skills.removeEventListener(MouseEvent.CLICK,this.skills_mouseClickHandler);
            this.skills.removeEventListener(ButtonEvent.CLICK,this.skills_buttonClickHandler);
            this.skills.dispose();
            this.skills = null;
            this.extra = null;
            this.value = null;
            this.label = null;
            this.model = null;
            this._skillName = null;
        }
        
        override protected function configUI() : void
        {
            this.skills.buttonMode = true;
            super.configUI();
            var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.GET_TANKMAN_ID,true);
            _loc1_.tankmanIdDelegate = this.getTankmanID;
            dispatchEvent(_loc1_);
        }
        
        public function set setData(param1:Object) : void
        {
            var _loc3_:String = null;
            this.model = param1;
            var _loc2_:String = Extensions.isScaleform?MENU.profile_stats_items(this.model.name):this.model.name;
            if((this.model.hasOwnProperty("imageType")) && this.model.imageType == "new_skill")
            {
                _loc2_ = MENU.PROFILE_STATS_ITEMS_READYTOLEARN;
                _loc3_ = "../maps/icons/tankmen/skills/small/" + this.model.image;
                this.addListenersToIcon();
                this.skills.x = this.value.x + this.value.width - this.skills.width + NEW_SKILLS_PADDING;
                this.value.visible = false;
            }
            else if((this.model.hasOwnProperty("imageType")) && this.model.imageType == "role")
            {
                _loc3_ = "../maps/icons/tankmen/roles/small/" + this.model.image;
                this.skills.y = this.skills.y + 2;
            }
            else if((this.model.hasOwnProperty("imageType")) && this.model.imageType == "skill")
            {
                _loc3_ = "../maps/icons/tankmen/skills/small/" + this.model.image;
                this.addListenersToIcon();
            }
            
            
            if(_loc3_)
            {
                this.skills.source = _loc3_;
            }
            this.label.text = _loc2_;
            if(!(this.model.value == null) && !(this.model.value == undefined))
            {
                this.value.text = this.model.value.toString();
            }
            if((this.model.hasOwnProperty("extra")) && !(this.model.extra == null) && !(this.model.extra == ""))
            {
                this.extra.text = this.model.extra.toString();
            }
            else
            {
                this.extra.visible = false;
            }
        }
        
        private function addListenersToIcon() : void
        {
            this.skills.buttonMode = true;
            this.skills.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            this.skills.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseOver);
            this.skills.addEventListener(MouseEvent.CLICK,this.skills_mouseClickHandler);
            this.skills.addEventListener(ButtonEvent.CLICK,this.skills_buttonClickHandler);
        }
        
        private function onMouseOver(param1:MouseEvent) : void
        {
            App.cursor.setCursor(Cursors.BUTTON);
            if(!this.model.hasOwnProperty("name") && !this.model.hasOwnProperty("tankmanID") && !(this.model.name == null))
            {
                return;
            }
            if((this.model.hasOwnProperty("imageType")) && this.model.imageType == "new_skill")
            {
                App.toolTipMgr.showSpecial(Tooltips.TANKMAN_NEW_SKILL,TooltipProps.DEFAULT,this._tankmanID);
            }
            else
            {
                App.toolTipMgr.showSpecial(Tooltips.TANKMAN_SKILL,null,this._skillName,this._tankmanID);
            }
        }
        
        public function getTankmanID(param1:int, param2:String) : void
        {
            this._tankmanID = param1;
            this._skillName = param2;
        }
        
        private function onMouseOut(param1:MouseEvent) : void
        {
            App.cursor.setCursor(Cursors.ARROW);
            App.toolTipMgr.hide();
        }
        
        private function skills_buttonClickHandler(param1:ButtonEvent) : void
        {
            this.dispatchPersonalCaseEvent();
        }
        
        private function skills_mouseClickHandler(param1:MouseEvent) : void
        {
            this.dispatchPersonalCaseEvent();
        }
        
        private function dispatchPersonalCaseEvent() : void
        {
            dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.CHANGE_TAB_ON_TWO,true));
        }
    }
}
