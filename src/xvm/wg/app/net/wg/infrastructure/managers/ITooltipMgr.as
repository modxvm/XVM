package net.wg.infrastructure.managers
{
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.IToolTipParams;
   
   public interface ITooltipMgr
   {
      
      function hide() : void;
      
      function showSpecial(param1:String, param2:ITooltipProps, ... rest) : void;
      
      function showComplex(param1:String, param2:ITooltipProps = null) : void;
      
      function showComplexWithParams(param1:String, param2:IToolTipParams, param3:ITooltipProps = null) : void;
      
      function show(param1:String, param2:ITooltipProps = null) : void;
      
      function showLocal(param1:String, param2:Object, param3:ITooltipProps = null) : void;
   }
}
