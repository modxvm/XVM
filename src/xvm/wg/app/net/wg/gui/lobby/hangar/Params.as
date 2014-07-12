package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.ParamsMeta;
   import net.wg.infrastructure.base.meta.IParamsMeta;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import net.wg.gui.components.controls.WgScrollingList;
   import flash.display.DisplayObject;
   import scaleform.clik.interfaces.IDataProvider;
   import net.wg.utils.IHelpLayout;
   import net.wg.data.constants.Directions;
   import scaleform.clik.data.DataProvider;
   
   public class Params extends ParamsMeta implements IParamsMeta, IHelpLayoutComponent
   {
      
      public function Params() {
         super();
         this.paramsListeners = new ParamsListener();
      }
      
      public var list:WgScrollingList;
      
      private var paramsListeners:ParamsListener = null;
      
      private var _helpLayout:DisplayObject;
      
      public function as_setValues(param1:Array) : void {
         var _loc2_:Number = 28;
         this.list.height = _loc2_ * param1.length;
         this.list.visible = Boolean(param1.length);
         this.list.dataProvider = this.setupDataProvider(param1);
      }
      
      public function as_highlightParams(param1:String) : void {
         var _loc4_:ParamsVO = null;
         var _loc2_:IDataProvider = this.list.dataProvider;
         var _loc3_:uint = _loc2_.length;
         for each(_loc4_ in _loc2_)
         {
            _loc4_.selected = this.paramsListeners.getParams(param1).indexOf(_loc4_.text) > -1;
         }
         this.list.invalidateData();
      }
      
      public function showHelpLayout() : void {
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         var _loc2_:Object = _loc1_.getProps(_width,_height,Directions.LEFT,LOBBY_HELP.HANGAR_VEHICLE_PARAMETERS,0,0);
         this._helpLayout = _loc1_.create(root,_loc2_,this);
      }
      
      public function closeHelpLayout() : void {
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         _loc1_.destroy(this._helpLayout);
      }
      
      override protected function configUI() : void {
         super.configUI();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function onDispose() : void {
         this.list.dispose();
         this.list = null;
         this.paramsListeners.dispose();
         this.paramsListeners = null;
         if(this._helpLayout)
         {
            this.closeHelpLayout();
            this._helpLayout = null;
         }
         super.onDispose();
      }
      
      private function setupDataProvider(param1:Array) : IDataProvider {
         var _loc3_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         for each(_loc3_ in param1)
         {
            _loc2_.push(new ParamsVO(_loc3_));
         }
         return _loc2_;
      }
   }
}
