package net.wg.gui.lobby.techtree.nodes
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.techtree.controls.ExperienceLabel;
   import net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon;
   import net.wg.gui.lobby.techtree.constants.NodeState;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.techtree.MenuHandler;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.TTSoundID;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.lobby.profile.components.SimpleLoader;
   import flash.events.Event;


   public class ResearchItem extends Renderer
   {
          
      public function ResearchItem() {
         super();
      }

      public var typeIcon:MovieClip;

      public var levelIcon:MovieClip;

      public var nameField:TextField;

      public var xpLabel:ExperienceLabel;

      private var extraIcon:ExtraIcon;

      override public function cleanUp() : void {
         if(this.xpLabel != null)
         {
            this.xpLabel.dispose();
         }
         super.cleanUp();
      }

      override public function isAvailable4Buy() : Boolean {
         if(!dataInited)
         {
            return false;
         }
         return !(container == null) && (this.containerEx.canInstallItems()) && (_valueObject.state & NodeState.INSTALLED) == 0 && (super.isAvailable4Buy());
      }

      override public function isActionEnabled() : Boolean {
         var _loc1_:Boolean = super.isActionEnabled();
         if((_loc1_) && stateProps.enough == NodeState.ENOUGH_MONEY)
         {
            _loc1_ = !(container == null) && (this.containerEx.canInstallItems()) && (_valueObject.state & NodeState.INSTALLED) == 0;
         }
         return _loc1_;
      }

      override public function populateUI() : void {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = 0;
         if(this.nameField != null)
         {
            _loc1_ = getItemName();
            this.nameField.wordWrap = true;
            this.nameField.autoSize = TextFieldAutoSize.CENTER;
            this.nameField.text = _loc1_;
         }
         if(this.typeIcon != null)
         {
            _loc2_ = getItemType();
            if(_loc2_.length > 0)
            {
               this.typeIcon.visible = true;
               this.typeIcon.gotoAndPlay(_loc2_);
            }
            else
            {
               this.typeIcon.visible = false;
            }
         }
         if(this.levelIcon != null)
         {
            _loc3_ = getLevel();
            if(_loc3_ > -1)
            {
               this.levelIcon.gotoAndStop(_loc3_);
            }
         }
         if(this.xpLabel != null)
         {
            this.xpLabel.visible = !this.isAutoUnlocked();
            if(this.xpLabel.visible)
            {
               this.xpLabel.setOwner(this,_doValidateNow);
            }
         }
         if(button != null)
         {
            button.label = getNamedLabel(stateProps.label);
            button.enabled = this.isActionEnabled();
            if(button.setAnimation(stateProps.id,stateProps.animation))
            {
               button.visible = stateProps.visible;
            }
            button.setOwner(this,_doValidateNow);
         }
         this.applyExtraSource();
         super.populateUI();
      }

      override public function getExtraState() : Object {
         return {
            "rootState":(this.containerEx != null?this.containerEx.getRootState():0),
            "isParentUnlocked":(this.containerEx != null?this.containerEx.hasUnlockedParent(matrixPosition.row-1,index):false)
         }
         ;
      }

      override public function showContextMenu() : void {
         if(button != null)
         {
            button.endAnimation(true);
         }
         MenuHandler.getInstance().showResearchItemMenu(this);
      }

      override public function toString() : String {
         return "[ResearchItem " + index + ", " + name + "]";
      }

      public function isAutoUnlocked() : Boolean {
         return (dataInited) && (_valueObject.state & NodeState.AUTO_UNLOCKED) > 0;
      }

      public function isInstalled() : Boolean {
         return (dataInited) && (_valueObject.state & NodeState.INSTALLED) > 0;
      }

      public function isAvailable4Install() : Boolean {
         if(!dataInited)
         {
            return false;
         }
         return !(container == null) && (this.containerEx.canInstallItems()) && (inInventory()) && (_valueObject.state & NodeState.INSTALLED) == 0;
      }

      public function click2Install() : void {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_INSTALL,0,_index,_entityType));
      }

      override public function set container(param1:INodesContainer) : void {
         if(param1  is  IResearchContainer)
         {
            _container = param1;
         }
      }

      public function get containerEx() : IResearchContainer {
         return _container != null?_container as IResearchContainer:null;
      }

      override protected function preInitialize() : void {
         super.preInitialize();
         _entityType = NodeEntityType.RESEARCH_ITEM;
         soundId = TTSoundID.RESEARCH_ITEM;
         _tooltipID = Tooltips.TECHTREE_MODULE;
         isDelegateEvents = true;
      }

      override protected function handleClick(param1:uint=0) : void {
         super.handleClick(param1);
         MenuHandler.getInstance().hideMenu();
         if(button != null)
         {
            button.endAnimation(true);
         }
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN,0,_index,_entityType));
      }

      private function applyExtraSource() : void {
         var _loc1_:String = _valueObject.extraInfo;
         if(!this.extraIcon && !(_loc1_ == null) && !(_loc1_ == ""))
         {
            this.extraIcon = new ExtraIcon();
            this.extraIcon.addEventListener(SimpleLoader.LOADED,this.onExtraIconLoaded,false,0,true);
            this.extraIcon.visible = false;
            addChild(this.extraIcon);
         }
         if(this.extraIcon)
         {
            this.extraIcon.setSource(_loc1_);
            this.extraIcon.visible = !((button) && (button.visible) || (this.xpLabel) && (this.xpLabel.visible));
            if(this.extraIcon.visible)
            {
               this.extraIcon.alpha = stateProps.index == 0?0.5:1;
            }
         }
      }

      private function onExtraIconLoaded(param1:Event) : void {
         this.extraIcon.x = this.typeIcon.x + this.typeIcon.width - this.extraIcon.width - 2;
         this.extraIcon.y = this.typeIcon.y + this.typeIcon.height - this.extraIcon.height - 2;
      }
   }

}