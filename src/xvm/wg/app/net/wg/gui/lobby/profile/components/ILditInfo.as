package net.wg.gui.lobby.profile.components
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.data.managers.IToolTipParams;
   
   public interface ILditInfo extends IDisposable
   {
      
      function get description() : String;
      
      function set description(param1:String) : void;
      
      function get iconPath() : String;
      
      function set iconPath(param1:String) : void;
      
      function get text() : String;
      
      function set text(param1:String) : void;
      
      function get tooltip() : String;
      
      function set tooltip(param1:String) : void;
      
      function set toolTipParams(param1:IToolTipParams) : void;
      
      function get toolTipParams() : IToolTipParams;
   }
}
