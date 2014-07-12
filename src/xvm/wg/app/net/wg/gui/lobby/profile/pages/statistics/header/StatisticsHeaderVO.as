package net.wg.gui.lobby.profile.pages.statistics.header
{
   import net.wg.gui.lobby.profile.data.ProfileBaseInfoVO;
   import net.wg.gui.lobby.profile.components.ILditInfo;
   import net.wg.data.managers.IToolTipParams;
   
   public class StatisticsHeaderVO extends ProfileBaseInfoVO implements ILditInfo
   {
      
      public function StatisticsHeaderVO(param1:Object) {
         super(param1);
      }
      
      public var type:String = "";
      
      private var _description:String = "";
      
      private var _text:String = "";
      
      private var _tooltip:String = "";
      
      private var _toolTipParams:IToolTipParams;
      
      public var additionalData:Object;
      
      private var _iconPath:String = "";
      
      public function get description() : String {
         return this._description;
      }
      
      public function set description(param1:String) : void {
         this._description = param1;
      }
      
      public function get text() : String {
         return this._text;
      }
      
      public function set text(param1:String) : void {
         this._text = param1;
      }
      
      public function get tooltip() : String {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void {
         this._tooltip = param1;
      }
      
      public function set toolTipParams(param1:IToolTipParams) : void {
         this._toolTipParams = param1;
      }
      
      public function get toolTipParams() : IToolTipParams {
         return this._toolTipParams;
      }
      
      public function get iconPath() : String {
         return this._iconPath;
      }
      
      public function set iconPath(param1:String) : void {
         this._iconPath = param1;
      }
      
      override protected function onDispose() : void {
         this.additionalData = null;
         this._toolTipParams = null;
         super.onDispose();
      }
   }
}
