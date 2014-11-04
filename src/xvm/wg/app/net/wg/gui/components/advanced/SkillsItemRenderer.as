package net.wg.gui.components.advanced
{
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import scaleform.clik.controls.StatusIndicator;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.tankman.RankElement;
    import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.geom.ColorTransform;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.events.PersonalCaseEvent;
    
    public class SkillsItemRenderer extends ListItemRenderer
    {
        
        public function SkillsItemRenderer()
        {
            super();
        }
        
        protected static var DATA_CHANGED:String = "dataChanged";
        
        private static var PROGRESS_BAR_WIDTH:uint = 54;
        
        private static var PROGRESS_BAR_HEIGHT:uint = 18;
        
        public var loader:UILoaderAlt;
        
        public var loadingBar:StatusIndicator;
        
        public var _titleLabel:TextField;
        
        public var bg:MovieClip;
        
        public var level_mc:SkillsLevelItemRenderer;
        
        public var rank_mc:RankElement;
        
        public var notActive:MovieClip;
        
        public var roleIco:UILoaderAlt;
        
        public var role_ico_path:String = "";
        
        private var _model:CarouselTankmanSkillsModel;
        
        private var isNewSkill:Boolean = false;
        
        override public function setData(param1:Object) : void
        {
            if(param1 == null)
            {
                return;
            }
            super.setData(param1);
            invalidate(DATA_CHANGED);
        }
        
        override public function set data(param1:Object) : void
        {
            super.data = param1;
            invalidate(DATA_CHANGED);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            removeEventListener(ButtonEvent.CLICK,this.onShowSkillTab);
            this.level_mc.dispose();
            this.level_mc = null;
            this.rank_mc.dispose();
            this.rank_mc = null;
            this.loader.dispose();
            this.loader = null;
            this.loadingBar.dispose();
            this.loadingBar = null;
            this.roleIco.dispose();
            this.roleIco = null;
            this.bg = null;
            this.notActive = null;
            this._titleLabel = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            if(isInvalid(DATA_CHANGED))
            {
                this.setup(this.data);
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
        }
        
        private function setup(param1:Object) : void
        {
            var _loc2_:ColorTransform = null;
            this._model = CarouselTankmanSkillsModel(param1);
            this.isNewSkill = this._model.isNewSkill;
            buttonMode = true;
            this.roleIco = this.rank_mc.icoLoader;
            if(this.model.icon != null)
            {
                this.loader.visible = !this.isNewSkill;
                this.loader.source = this.model.icon;
            }
            else
            {
                this.loader.visible = false;
            }
            this.rank_mc.visible = !this.model.isCommon;
            if(!this.model.isCommon)
            {
                this.role_ico_path = this.model.roleIcon;
                this.roleIco.source = this.role_ico_path;
                this.rank_mc.gotoAndPlay(this.model.enabled?"enabled":"disabled");
            }
            if(!this.model.isActive || !this.model.enabled)
            {
                _loc2_ = new ColorTransform();
                _loc2_.alphaMultiplier = 1;
                _loc2_.redMultiplier = 0.6;
                _loc2_.greenMultiplier = 0.6;
                _loc2_.blueMultiplier = 0.6;
                this.loader.transform.colorTransform = _loc2_;
            }
            else
            {
                this.loader.transform.colorTransform = new ColorTransform();
            }
            this.bg.gotoAndPlay(!this.isNewSkill?!this.model.isActive || !this.model.enabled?"not_active_up":"active_up":"new_skill");
            this.notActive.visible = (!this.model.isActive || !this.model.enabled) && !this.isNewSkill;
            this.loadingBar.visible = !this.isNewSkill;
            this._titleLabel.visible = !this.isNewSkill;
            if(!this.isNewSkill)
            {
                this.level_mc.visible = false;
                if(this.model.level == 100)
                {
                    if(this.loadingBar is StatusIndicator)
                    {
                        this.loadingBar.visible = false;
                    }
                    this._titleLabel.visible = false;
                }
                if(this.loadingBar is StatusIndicator)
                {
                    this.loadingBar.position = this.model.level;
                    if(Number(this.model.level) != 0)
                    {
                        this.loadingBar.setActualSize(PROGRESS_BAR_WIDTH,PROGRESS_BAR_HEIGHT);
                    }
                }
                this._titleLabel.text = this.model.level.toString() + "%";
                this.removeEventListener(ButtonEvent.CLICK,this.onShowSkillTab);
            }
            else
            {
                this.rank_mc.visible = false;
                if(this.model.skillsCountForLearn > 1)
                {
                    this.level_mc.visible = true;
                    this.level_mc.updateText(this.model.skillsCountForLearn - 1);
                }
                else
                {
                    this.level_mc.visible = false;
                }
                this.addEventListener(ButtonEvent.CLICK,this.onShowSkillTab);
            }
            this.level_mc.alpha = this.level_mc.visible?1:0;
        }
        
        private function get model() : CarouselTankmanSkillsModel
        {
            return this._model;
        }
        
        private function onRollOver(param1:MouseEvent) : void
        {
            if(this.model.name == Values.EMPTY_STR && this.model.tankmanID == Values.DEFAULT_INT)
            {
                return;
            }
            if(this.isNewSkill)
            {
                App.toolTipMgr.showSpecial(Tooltips.TANKMAN_NEW_SKILL,null,this.model.tankmanID);
            }
            else
            {
                App.toolTipMgr.showSpecial(Tooltips.TANKMAN_SKILL,null,this.model.name,this.model.tankmanID);
            }
        }
        
        private function onRollOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public function onShowSkillTab(param1:ButtonEvent) : void
        {
            dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.CHANGE_TAB_ON_TWO,true));
        }
    }
}
