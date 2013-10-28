package net.wg.gui.lobby.battleResults
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.data.VO.IconVO;


   public class CustomAchievement extends SoundListItemRenderer
   {
          
      public function CustomAchievement() {
         super();
         this.loader.hideLoader = false;
      }

      public var loader:UILoaderAlt;

      protected var _dataDirty:Boolean = false;

      override public function dispose() : void {
         if(this.loader)
         {
            this.loader.dispose();
            this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onComplete);
            this.loader = null;
         }
         super.dispose();
      }

      override public function setData(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         this.data = param1;
         this._dataDirty = true;
         this.drawLoader();
      }

      protected function drawLoader() : void {
         if(this._dataDirty)
         {
            if(data == null)
            {
               return;
            }
            if(this.getDataOwnValue("isRare",false))
            {
               this.tryToLoadRareAchievement();
            }
            else
            {
               if(!(this.loader == null) && (data.icon))
               {
                  this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onComplete);
                  if(data.icon  is  IconVO)
                  {
                     this.loader.source = data.icon.big;
                  }
                  else
                  {
                     this.loader.source = data.icon;
                  }
               }
            }
            this._dataDirty = false;
         }
      }

      protected function tryToLoadRareAchievement() : void {
         if(this.getDataOwnValue("rareIconId",null))
         {
            this.loader.source = "img://" + data.rareIconId;
            this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onComplete);
         }
      }

      protected function getDataOwnValue(param1:String, param2:*) : * {
         var _loc3_:* = undefined;
         if(data)
         {
            _loc3_ = data.hasOwnProperty(param1)?data[param1]:param2;
            if(_loc3_  is  Function)
            {
               return _loc3_();
            }
         }
         return _loc3_;
      }

      private function changeSaturation() : void {
         this.loader.alpha = 0.9;
         App.utils.commons.setSaturation(this.loader,0);
      }

      protected function onComplete(param1:UILoaderEvent) : void {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onComplete);
         if((data.hasOwnProperty("inactive")) && (data.inactive))
         {
            this.changeSaturation();
         }
      }
   }

}