package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.profile.components.TechMasteryIcon;
   import flash.display.MovieClip;
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import scaleform.clik.constants.InvalidationType;


   public class TechniqueRenderer extends SoundListItemRenderer
   {
          
      public function TechniqueRenderer() {
         super();
      }

      private static function getSmallMasteryIconPath(param1:int) : String {
         if(param1 > 0)
         {
            return "../maps/icons/library/proficiency/class_icons_" + param1 + ".png";
         }
         return null;
      }

      private static function getString(param1:Number) : String {
         if(App.utils)
         {
            return App.utils.locale.integer(param1);
         }
         return param1.toString();
      }

      public var vehicleTF:TextField;

      public var battlesTF:TextField;

      public var winsTF:TextField;

      public var avgExpTF:TextField;

      public var nationIcon:UILoaderAlt;

      public var typeIcon:UILoaderAlt;

      public var tankSmallIcon:UILoaderAlt;

      public var masteryIcon:TechMasteryIcon;

      public var levelMC:MovieClip;

      public var background:MovieClip;

      public var hit:MovieClip;

      override protected function configUI() : void {
         super.configUI();
         this.mouseChildren = true;
         this.masteryIcon.mouseChildren = false;
         this.masteryIcon.buttonMode = true;
         buttonMode = true;
         hitArea = this.hit;
      }

      override public function set mouseChildren(param1:Boolean) : void {
         super.mouseChildren = true;
      }

      override public function setData(param1:Object) : void {
         if(_baseDisposed)
         {
            return;
         }
         this.data = param1;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         var _loc2_:DisplayObject = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:TechniqueListVehicleVO = null;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         if(_baseDisposed)
         {
            return;
         }
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = false;
            if(data)
            {
               _loc1_ = true;
               _loc5_ = TechniqueListVehicleVO(data);
               this.vehicleTF.text = _loc5_.shortUserName;
               this.battlesTF.text = getString(_loc5_.battlesCount);
               this.winsTF.text = _loc5_.winsEfficiencyStr;
               _loc6_ = _loc5_.avgExperience;
               this.avgExpTF.text = _loc6_ == 0?"":getString(_loc6_);
               this.nationIcon.source = _loc5_.nationIconPath;
               this.typeIcon.source = _loc5_.typeIconPath;
               this.tankSmallIcon.source = _loc5_.tankIconPath;
               _loc7_ = getSmallMasteryIconPath(_loc5_.markOfMastery);
               if(_loc7_)
               {
                  this.masteryIcon.source = _loc7_;
               }
               else
               {
                  this.masteryIcon.unload();
               }
               this.masteryIcon.data = _loc5_;
               this.levelMC.gotoAndStop(_loc5_.level);
            }
            else
            {
               this.masteryIcon.unload();
               this.masteryIcon.data = null;
            }
            _loc3_ = numChildren;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = getChildAt(_loc4_);
               if(_loc2_ != this.background)
               {
                  _loc2_.visible = _loc1_;
               }
               _loc4_++;
            }
         }
      }
   }

}