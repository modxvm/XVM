package net.wg.gui.lobby.training
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IMinimapEntry;
   import flash.display.MovieClip;
   import flash.filters.BitmapFilter;
   
   public class MinimapEntry extends UIComponent implements IMinimapEntry
   {
      
      public function MinimapEntry() {
         super();
      }
      
      private static var ms_lastLitEntry:MinimapEntry = null;
      
      public static function unhighlightLastEntry() : void {
         if(ms_lastLitEntry)
         {
            ms_lastLitEntry.lightPlayer(false);
         }
      }
      
      public var player:MovieClip;
      
      public var selfIcon:MovieClip;
      
      public var markMC:MovieClip;
      
      public var teamPoint:MovieClip;
      
      public var hover:MovieClip;
      
      public var backMarker:MovieClip;
      
      public var m_type:String = "";
      
      private var entryName:String = "";
      
      private var vehicleClass:String = "";
      
      private var markLabel:String = "";
      
      private var isTeamKiller:Boolean = false;
      
      private var isDead:Boolean = false;
      
      private var isDeadPermanent:Boolean = false;
      
      private var isPostmortem:Boolean = false;
      
      private var isMarketLit:Boolean = false;
      
      private var playingTimeoutId:Number = NaN;
      
      public function update(param1:Object) : void {
         invalidate();
      }
      
      override protected function configUI() : void {
         super.configUI();
      }
      
      public function init(param1:String, param2:String, param3:String, param4:String) : void {
         this.m_type = param1;
         this.entryName = param2;
         this.vehicleClass = param3;
         this.markLabel = param4;
         this.validateNow();
      }
      
      public function showAction(param1:String) : void {
         if(this.markMC != null)
         {
            this.markMC.gotoAndStop(1);
         }
         this.markLabel = param1;
         validateNow();
      }
      
      public function lightPlayer(param1:Boolean) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(this.player != null)
         {
            _loc2_ = 1;
            _loc3_ = 4;
            if(!(ms_lastLitEntry == null) && (param1))
            {
               if(ms_lastLitEntry != this)
               {
                  ms_lastLitEntry.player.litIcon.gotoAndStop(_loc2_);
               }
               else
               {
                  ms_lastLitEntry = null;
               }
            }
            if(this.player.litIcon.currentFrame == (param1?_loc2_:_loc3_))
            {
               if(param1)
               {
                  ms_lastLitEntry = this;
               }
               else
               {
                  ms_lastLitEntry = null;
               }
               if(this.getMinimap().visible)
               {
                  App.utils.scheduler.envokeInNextFrame(this.playPlayer);
               }
               else
               {
                  this.player.litIcon.gotoAndStop(param1?_loc3_:_loc2_);
               }
            }
         }
      }
      
      private function playPlayer() : void {
         this.player.litIcon.play();
         App.utils.scheduler.cancelTask(this.playPlayer);
      }
      
      public function get colorSchemeName() : String {
         return "vm_" + (this.entryName != null?this.entryName:this.m_type);
      }
      
      public function setEntryName(param1:String) : void {
         if(param1 != this.entryName)
         {
            this.entryName = param1;
            invalidate();
         }
      }
      
      public function setDead(param1:Boolean) : void {
         this.isDead = true;
         this.isDeadPermanent = param1;
         invalidate();
      }
      
      public function setPostmortem(param1:Boolean) : void {
         this.isPostmortem = param1;
         invalidate();
      }
      
      public function isTeamPoint() : Boolean {
         return this.m_type == "points" && !(this.teamPoint == null);
      }
      
      private function isBackMarker() : Boolean {
         return this.m_type == "backgroundMarker" && !(this.backMarker == null);
      }
      
      private function updateType() : void {
         if(this.m_type != null)
         {
            gotoAndStop(this.m_type);
         }
      }
      
      private function updateIfEntryIsPlayer() : void {
         var _loc1_:String = null;
         if(this.player != null)
         {
            _loc1_ = App.colorSchemeMgr.getAliasColor(this.colorSchemeName);
            if(!this.isDead)
            {
               if(this.isPostmortem)
               {
                  this.player.gotoAndStop("postmortem");
               }
               else
               {
                  if(_loc1_ != null)
                  {
                     this.player.gotoAndStop(_loc1_);
                  }
                  this.player.litIcon.icon.gotoAndStop(this.vehicleClass);
               }
            }
            else
            {
               _loc1_ = _loc1_ != null?_loc1_:"green";
               this.player.gotoAndStop("dead");
               this.player.icon.marker.gotoAndStop(this.vehicleClass + "-" + _loc1_);
               this.player.icon.gotoAndPlay("show");
               this.player.icon.isDeadPermanent = this.isDeadPermanent;
            }
         }
      }
      
      override protected function draw() : void {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:BitmapFilter = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.updateType();
         this.updateIfEntryIsPlayer();
         if(this.selfIcon != null)
         {
            this.selfIcon.gotoAndStop(this.entryName);
            if(this.rotation != 0)
            {
               this.markMC.rotation = -this.rotation;
            }
         }
         if(this.isTeamPoint())
         {
            this.teamPoint.gotoAndStop(this.entryName);
            _loc1_ = "teamPoint";
            _loc2_ = _loc1_ + this.entryName + this.vehicleClass;
            _loc3_ = App.colorSchemeMgr.getAliasColor(_loc2_);
            _loc4_ = App.colorSchemeMgr.getScheme(_loc2_).adjustOffset;
            this.teamPoint.pointType.gotoAndStop(_loc3_);
            this.teamPoint.pointType.teamColor.gotoAndStop(this.markLabel);
            if(_loc4_ != null)
            {
               this.teamPoint.pointType.teamColor.filters = [_loc4_];
            }
            else
            {
               this.teamPoint.pointType.teamColor.filters = [];
            }
         }
         else if(this.isBackMarker())
         {
            this.backMarker.gotoAndStop(this.entryName);
            _loc5_ = "backMarker";
            _loc6_ = App.colorSchemeMgr.getAliasColor(_loc5_ + this.entryName + this.markLabel);
            this.backMarker.marker.gotoAndStop(_loc6_);
         }
         else if(this.markMC != null)
         {
            if(this.markLabel != null)
            {
               this.markMC.gotoAndStop(this.markLabel);
            }
         }
         
         
         super.draw();
      }
      
      private function getMinimap() : MovieClip {
         return MovieClip(this.parent);
      }
   }
}
