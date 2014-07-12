package net.wg.gui.components.advanced
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.filters.GlowFilter;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.controls.StatusIndicator;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.lobby.tankman.*;
   import net.wg.data.constants.Tooltips;
   import flash.geom.ColorTransform;
   import net.wg.gui.events.PersonalCaseEvent;
   
   public class SkillsItemRenderer extends ListItemRenderer
   {
      
      public function SkillsItemRenderer() {
         super();
      }
      
      private static const PROGRESS_BAR_WIDTH:uint = 54;
      
      private static const PROGRESS_BAR_HEIGHT:uint = 18;
      
      protected static const DATA_CHANGED:String = "dataChanged";
      
      private static function getRankGlowFilter() : Array {
         var _loc1_:Array = [];
         var _loc2_:Number = 16724246;
         var _loc3_:Number = 0.5;
         var _loc4_:Number = 6;
         var _loc5_:Number = 6;
         var _loc6_:Number = 4;
         var _loc7_:Number = 3;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc10_:GlowFilter = new GlowFilter(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
         _loc1_.push(_loc10_);
         return _loc1_;
      }
      
      public var loader:UILoaderAlt;
      
      public var loadingBar:StatusIndicator;
      
      public var _titleLabel:TextField;
      
      public var bg:MovieClip;
      
      public var level_mc:MovieClip;
      
      public var rank_mc:RankElement;
      
      public var notActive:MovieClip;
      
      public var roleIco:UILoaderAlt;
      
      public var role_ico_path:String = "";
      
      override protected function onDispose() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         removeEventListener(ButtonEvent.CLICK,this.onShowSkillTab);
         this.rank_mc.dispose();
         this.rank_mc = null;
         this.loader.dispose();
         this.loader = null;
         this.loadingBar.dispose();
         this.loadingBar = null;
         this.roleIco.dispose();
         this.roleIco = null;
         this.bg = null;
         this.level_mc = null;
         this.notActive = null;
         this._titleLabel = null;
         super.onDispose();
      }
      
      override protected function draw() : void {
         if(isInvalid(DATA_CHANGED))
         {
            this.setup(this.data);
         }
      }
      
      override public function set data(param1:Object) : void {
         super.data = param1;
         invalidate(DATA_CHANGED);
      }
      
      override public function setData(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         invalidate(DATA_CHANGED);
      }
      
      override protected function configUI() : void {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         if(!data.hasOwnProperty("name") && !data.hasOwnProperty("tankmanID") && !(data.name == null))
         {
            return;
         }
         if(data.isNewSkill)
         {
            App.toolTipMgr.showSpecial(Tooltips.TANKMAN_NEW_SKILL,null,data.tankmanID);
         }
         else
         {
            App.toolTipMgr.showSpecial(Tooltips.TANKMAN_SKILL,null,data.name,data.tankmanID);
         }
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
      
      public function setup(param1:Object) : void {
         var c:ColorTransform = null;
         var data:Object = param1;
         if(data == null)
         {
            return;
         }
         buttonMode = true;
         this.roleIco = this.rank_mc.icoLoader;
         try
         {
            if(data.icon != null)
            {
               this.loader.visible = !data.isNewSkill;
               this.loader.source = data.icon;
            }
            else
            {
               this.loader.visible = false;
            }
            this.rank_mc.visible = !data.isCommon;
            if(!data.isCommon)
            {
               this.role_ico_path = data.roleIcon;
               this.roleIco.source = this.role_ico_path;
               this.rank_mc.gotoAndPlay(data.enabled?"enabled":"disabled");
            }
            if(!data.isActive || !data.enabled)
            {
               c = new ColorTransform();
               c.alphaMultiplier = 1;
               c.redMultiplier = 0.6;
               c.greenMultiplier = 0.6;
               c.blueMultiplier = 0.6;
               this.loader.transform.colorTransform = c;
            }
            else
            {
               this.loader.transform.colorTransform = new ColorTransform();
            }
            this.bg.gotoAndPlay(!data.isNewSkill?!data.isActive || !data.enabled?"not_active_up":"active_up":"new_skill");
            this.notActive.visible = (!data.isActive || !data.enabled) && !data.isNewSkill;
            this.loadingBar.visible = !data.isNewSkill;
            this._titleLabel.visible = !data.isNewSkill;
            if(!data.isNewSkill)
            {
               this.level_mc.visible = false;
               if(data.level == 100)
               {
                  if(this.loadingBar is StatusIndicator)
                  {
                     this.loadingBar.visible = false;
                  }
                  this._titleLabel.visible = false;
               }
               if(this.loadingBar is StatusIndicator)
               {
                  this.loadingBar.position = Number(data.level);
                  if(Number(data.level) != 0)
                  {
                     this.loadingBar.setActualSize(PROGRESS_BAR_WIDTH,PROGRESS_BAR_HEIGHT);
                  }
               }
               this._titleLabel.text = String(data.level) + "%";
               this.removeEventListener(ButtonEvent.CLICK,this.onShowSkillTab);
            }
            else
            {
               this.rank_mc.visible = false;
               if(data.skillsCountForLearn > 1)
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
               if(!this.hasOwnProperty(ButtonEvent.CLICK))
               {
                  this.addEventListener(ButtonEvent.CLICK,this.onShowSkillTab);
               }
            }
            this.level_mc.alpha = Number(this.level_mc.visible);
         }
         catch(e:Error)
         {
            DebugUtils.LOG_DEBUG(" ERROR setup");
         }
      }
      
      public function onShowSkillTab(param1:ButtonEvent) : void {
         dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.CHANGE_TAB_ON_TWO,true));
      }
   }
}
