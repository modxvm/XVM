package net.wg.gui.lobby.fortifications.battleRoom
{
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.rally.interfaces.IManualSearchRenderer;
   import flash.text.TextField;
   import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
   import net.wg.data.constants.Values;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.infrastructure.interfaces.IUserProps;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   
   public class SortieListRenderer extends TableRenderer implements IManualSearchRenderer
   {
      
      public function SortieListRenderer() {
         super();
         UIID = 33;
         preventAutosizing = true;
      }
      
      public var commander:TextField = null;
      
      public var divisionName:TextField = null;
      
      public var commandSize:TextField = null;
      
      public var commandMaxSize:TextField = null;
      
      private var _creatorName:String = null;
      
      override public function setData(param1:Object) : void {
         var _loc2_:Array = null;
         this.data = param1;
         if(this.data)
         {
            _loc2_ = SortieRenderVO(param1).sortieID;
            if(!(_loc2_[0] == Values.DEFAULT_INT) && !(_loc2_[1] == Values.DEFAULT_INT))
            {
               startSimulationDoubleClick();
            }
            else
            {
               stopSimulationDoubleClick();
            }
         }
         else
         {
            stopSimulationDoubleClick();
         }
         invalidateData();
      }
      
      public function update(param1:Object) : void {
         this.data = param1;
         if(this.data)
         {
            this.populateUI(SortieRenderVO(param1));
         }
      }
      
      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         mouseEnabled = true;
         mouseChildren = true;
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.commander.mouseEnabled = false;
         this.divisionName.mouseEnabled = false;
         this.commandSize.mouseEnabled = false;
         this.commandMaxSize.mouseEnabled = false;
      }
      
      override protected function onDispose() : void {
         this.commander = null;
         this.divisionName = null;
         this.commandSize = null;
         this.commandMaxSize = null;
         super.onDispose();
      }
      
      override protected function draw() : void {
         var _loc1_:SortieRenderVO = null;
         mouseEnabled = true;
         mouseChildren = true;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               _loc1_ = SortieRenderVO(data);
               this.visible = true;
               this.populateUI(_loc1_);
            }
            else
            {
               this.visible = false;
            }
         }
      }
      
      protected function populateUI(param1:SortieRenderVO) : void {
         var _loc2_:String = null;
         var _loc3_:IUserProps = null;
         if(param1.creatorName)
         {
            _loc3_ = App.utils.commons.getUserProps(param1.creatorName,"","",param1.igrType);
            _loc3_.rgb = param1.color;
            App.utils.commons.formatPlayerName(this.commander,_loc3_);
            _loc2_ = this.commander.htmlText;
         }
         else
         {
            _loc2_ = "";
         }
         if(this._creatorName != _loc2_)
         {
            this._creatorName = _loc2_;
            this.commander.htmlText = _loc2_;
         }
         _loc2_ = String(param1.playerCount);
         if(_loc2_ != this.commandSize.text)
         {
            this.commandSize.text = _loc2_;
         }
         _loc2_ = "/" + String(param1.commandSize);
         if(_loc2_ != this.commandMaxSize.text)
         {
            this.commandMaxSize.text = _loc2_;
         }
         this.divisionName.text = param1.divisionName;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void {
         super.handleMouseRelease(param1);
         var _loc2_:uint = 0;
         App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_CLICK,_loc2_);
      }
   }
}
