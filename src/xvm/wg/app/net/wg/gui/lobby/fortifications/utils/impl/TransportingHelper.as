package net.wg.gui.lobby.fortifications.utils.impl
{
   import net.wg.gui.lobby.fortifications.utils.ITransportingHelper;
   import net.wg.gui.lobby.fortifications.cmp.build.IFortBuilding;
   import net.wg.gui.lobby.fortifications.interfaces.ITransportingHandler;
   import net.wg.utils.ICommons;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.display.DisplayObject;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import net.wg.data.constants.Errors;
   import net.wg.utils.IUtils;
   
   public class TransportingHelper extends Object implements ITransportingHelper
   {
      
      public function TransportingHelper(param1:Vector.<IFortBuilding>, param2:ITransportingHandler) {
         super();
         var _loc3_:IUtils = App.utils;
         this._commons = _loc3_.commons;
         _loc3_.asserter.assertNotNull(param1,"buildings" + Errors.CANT_NULL);
         _loc3_.asserter.assertNotNull(param2,"transportingHandler" + Errors.CANT_NULL);
         this._buildings = param1;
         this._transportingHandler = param2;
      }
      
      private var _buildings:Vector.<IFortBuilding> = null;
      
      private var _buildToExport:IFortBuilding = null;
      
      private var _buildToImport:IFortBuilding = null;
      
      private var _transportingHandler:ITransportingHandler = null;
      
      private var _commons:ICommons = null;
      
      public function dispose() : void {
         this.removeAllTransportingListeners();
         this._transportingHandler = null;
         this._buildings = null;
         this._buildToExport = null;
         this._buildToImport = null;
      }
      
      public function updateTransportMode(param1:Boolean, param2:Boolean) : void {
         var _loc3_:IFortBuilding = null;
         if(param1)
         {
            this.initTransportingEntering();
            this._transportingHandler.onStartExporting();
         }
         else
         {
            this._buildToExport = null;
            this._buildToImport = null;
            this.removeAllTransportingListeners();
         }
         for each(_loc3_ in this._buildings)
         {
            _loc3_.updateTransportMode(param1,false);
         }
      }
      
      private function initTransportingEntering() : void {
         var _loc1_:Vector.<IEventDispatcher> = this.getExportAvailableBuildingsHitArea();
         this._commons.addMultipleHandlers(_loc1_,MouseEvent.CLICK,this.onExportingClickHandler);
      }
      
      private function removeAllTransportingListeners() : void {
         var _loc1_:Vector.<IEventDispatcher> = this.getAllBuildingsHitArea();
         this._commons.removeMultipleHandlers(_loc1_,MouseEvent.CLICK,this.onExportingClickHandler);
         this._commons.removeMultipleHandlers(_loc1_,MouseEvent.CLICK,this.onImportClickHandler);
         App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
      }
      
      private function getAllBuildingsHitArea() : Vector.<IEventDispatcher> {
         var _loc2_:IFortBuilding = null;
         var _loc1_:Vector.<IEventDispatcher> = new Vector.<IEventDispatcher>();
         for each(_loc2_ in this._buildings)
         {
            if(_loc2_.isAvailable())
            {
               _loc1_.push(_loc2_.getCustomHitArea());
            }
         }
         return _loc1_;
      }
      
      private function getExportAvailableBuildingsHitArea() : Vector.<IEventDispatcher> {
         var _loc2_:IFortBuilding = null;
         var _loc1_:Vector.<IEventDispatcher> = new Vector.<IEventDispatcher>();
         for each(_loc2_ in this._buildings)
         {
            if(_loc2_.isAvailable())
            {
               if(_loc2_.isExportAvailable())
               {
                  _loc1_.push(_loc2_.getCustomHitArea());
               }
            }
         }
         return _loc1_;
      }
      
      private function getImportAvailableBuildingsHitArea() : Vector.<IEventDispatcher> {
         var _loc2_:IFortBuilding = null;
         var _loc1_:Vector.<IEventDispatcher> = new Vector.<IEventDispatcher>();
         for each(_loc2_ in this._buildings)
         {
            if(_loc2_.isAvailable())
            {
               if(_loc2_.isImportAvailable())
               {
                  _loc1_.push(_loc2_.getCustomHitArea());
               }
            }
         }
         return _loc1_;
      }
      
      private function onStageClickHandler(param1:MouseEvent) : void {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         while(_loc2_ != null)
         {
            if(_loc2_ is IFortBuilding)
            {
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         this.updateTransportMode(false,false);
         this.updateTransportMode(true,false);
      }
      
      private function onExportingClickHandler(param1:MouseEvent) : void {
         var _loc2_:Vector.<IEventDispatcher> = null;
         var _loc3_:IFortBuilding = null;
         if(App.utils.commons.isLeftButton(param1))
         {
            _loc2_ = this.getAllBuildingsHitArea();
            this._commons.removeMultipleHandlers(_loc2_,MouseEvent.CLICK,this.onExportingClickHandler);
            this._buildToExport = IFortBuilding(param1.currentTarget.parent);
            App.eventLogManager.logUIElement(this._buildToExport,EVENT_LOG_CONSTANTS.EVENT_TYPE_STEP_1,this._buildToExport.uid.length);
            for each(_loc3_ in this._buildings)
            {
               if(_loc3_.isAvailable())
               {
                  _loc3_.nextTransportingStep(this._buildToExport == _loc3_);
               }
            }
            this._transportingHandler.onStartImporting();
            _loc2_ = this.getImportAvailableBuildingsHitArea();
            this._commons.addMultipleHandlers(_loc2_,MouseEvent.CLICK,this.onImportClickHandler);
            App.stage.addEventListener(MouseEvent.CLICK,this.onStageClickHandler);
         }
      }
      
      private function onImportClickHandler(param1:MouseEvent) : void {
         var _loc2_:IFortBuilding = null;
         if(App.utils.commons.isLeftButton(param1))
         {
            App.utils.asserter.assertNotNull(this._buildToExport,"_buildToExport" + Errors.CANT_NULL);
            _loc2_ = IFortBuilding(param1.currentTarget.parent);
            if(_loc2_ != this._buildToExport)
            {
               this._buildToImport = _loc2_;
               this._buildToExport.exportArrow.hide();
               this._buildToImport.importArrow.hide();
               App.eventLogManager.logUIElement(this._buildToImport,EVENT_LOG_CONSTANTS.EVENT_TYPE_STEP_2,this._buildToImport.uid.length);
               this._transportingHandler.onTransportingSuccess(this._buildToExport,this._buildToImport);
               App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
            }
         }
      }
   }
}
