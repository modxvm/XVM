package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IBaseDAAPIModuleMeta;


   public interface IDAAPIModule extends IBaseDAAPIModuleMeta
   {
          
      function get disposed() : Boolean;
   }

}