package net.wg.gui.lobby.dialogs
{
    import net.wg.infrastructure.base.meta.impl.DismissTankmanDialogMeta;
    import net.wg.infrastructure.base.meta.IDismissTankmanDialogMeta;
    import net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;
    import flash.text.TextField;
    import net.wg.gui.lobby.tankman.SkillDropModel;
    import net.wg.gui.components.common.InputChecker;
    import net.wg.data.Aliases;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.core.UIComponent;
    
    public class DismissTankmanDialog extends DismissTankmanDialogMeta implements IDismissTankmanDialogMeta
    {
        
        public function DismissTankmanDialog() {
            super();
        }
        
        private static var UPDATE_BLOCK:String = "updateBlock";
        
        private static var AUTO_UPDATE_INTERVAL:int = 3000;
        
        public var mainBlock:TankmanSkillsInfoBlock;
        
        public var questionTf:TextField;
        
        public var model:SkillDropModel;
        
        public var inputChecker:InputChecker;
        
        private var protectedState:Boolean = true;
        
        private var NONE_PROTECTED_MODE_PADDING:int = -6;
        
        private var PROTECTED_MODE_PADDING:int = 15;
        
        public function as_tankMan(param1:Object) : void {
            if(param1 == null)
            {
                return;
            }
            this.model = SkillDropModel.parseFromObject(param1);
            if(this.model.roleLevel < 100 && this.model.lastSkill == null && this.model.hasNewSkill == false)
            {
                this.protectedState = false;
                this.inputChecker.visible = false;
                this.questionTf.text = DIALOGS.DISMISSTANKMAN_MESSAGE;
                secondBtn.enabled = true;
                App.utils.scheduler.envokeInNextFrame(this.updateFocus,secondBtn);
            }
            else
            {
                secondBtn.enabled = false;
            }
            invalidate(UPDATE_BLOCK);
        }
        
        override protected function draw() : void {
            super.draw();
            if((this.model) && (isInvalid(UPDATE_BLOCK)))
            {
                this.setData();
            }
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            registerComponent(this.inputChecker,Aliases.INPUT_CHECKER_COMPONENT);
            this.inputChecker.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
            this.inputChecker.defaultInterval = AUTO_UPDATE_INTERVAL;
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.right = 14;
            App.utils.scheduler.envokeInNextFrame(this.updateFocus,this.inputChecker.getComponentForFocus());
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            this.model.dispose();
            this.mainBlock.dispose();
            App.utils.scheduler.cancelTask(this.updateFocus);
        }
        
        override protected function getBackgroundActualHeight() : Number {
            if(this.protectedState)
            {
                return this.inputChecker.y + this.inputChecker.height + this.PROTECTED_MODE_PADDING;
            }
            return this.questionTf.y + this.questionTf.height + this.NONE_PROTECTED_MODE_PADDING;
        }
        
        private function updateFocus(param1:UIComponent) : void {
            setFocus(param1);
        }
        
        private function setData() : void {
            this.mainBlock.nation = this.model.nation;
            this.mainBlock.tankmanName = this.model.tankmanName;
            this.mainBlock.portraitSource = this.model.tankmanIcon;
            this.mainBlock.roleSource = this.model.roleIcon;
            this.mainBlock.setSkills(this.protectedState?this.model.skillsCount:-1,this.model.preLastSkill,this.model.lastSkill,this.model.lastSkillLevel,this.model.hasNewSkill,this.model.newSkillsCount,this.model.lastNewSkillLevel);
            this.mainBlock.setRoleLevel(this.model.roleLevel);
        }
        
        private function onRequestFocusHandler(param1:FocusRequestEvent) : void {
            if(this.inputChecker.isInvalidUserText)
            {
                secondBtn.enabled = true;
                App.utils.scheduler.envokeInNextFrame(this.updateFocus,secondBtn);
            }
            else
            {
                secondBtn.enabled = false;
                setFocus(this.inputChecker.getComponentForFocus());
            }
        }
    }
}
