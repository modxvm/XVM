package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.base.meta.IQuestsCurrentTabMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;


   public interface IQuestsTab extends IViewStackContent, IQuestsCurrentTabMeta, IDAAPIModule
   {
          
      function get questContent() : QuestContent;

      function set questContent(param1:QuestContent) : void;
   }

}