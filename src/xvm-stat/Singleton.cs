using System;
using System.Reflection;

namespace wot
{
  /// generic Singleton<T> (потокобезопасный с использованием generic-класса и с отложенной инициализацией)

  /// <typeparam name="T">Singleton class</typeparam>
  public class Singleton<T> where T : class
  {
    /// Защищенный конструктор по умолчанию необходим для того, чтобы
    /// предотвратить создание экземпляра класса Singleton
    protected Singleton()
    {
    }

    /// Фабрика используется для отложенной инициализации экземпляра класса
    private sealed class SingletonCreator<S> where S : class
    {
      //Используется Reflection для создания экземпляра класса без публичного конструктора
      private static readonly S instance = (S)typeof(S).GetConstructor(
                  BindingFlags.Instance | BindingFlags.NonPublic,
                  null,
                  new Type[0],
                  new ParameterModifier[0]).Invoke(null);

      public static S CreatorInstance
      {
        get
        {
          return instance;
        }
      }
    }

    public static T Instance
    {
      get
      {
        return SingletonCreator<T>.CreatorInstance;
      }
    }

  }
}
