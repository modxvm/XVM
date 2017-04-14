{
  "widgets": {
    "login": [
      {
        //"enabled": true,
        "$ref": { "file":"../default/widgetsTemplates.xc", "path":"test" }
      },
      {
        //"enabled": true,
        "$ref": { "file":"../default/widgetsTemplates.xc", "path":"test2" }
      }
    ],
    "lobby": [
      ${ "../default/widgetsTemplates.xc":"clock" },
      {
        //"enabled": true,
        "$ref": { "file":"../default/widgetsTemplates.xc", "path":"test" }
      },
      {
        //"enabled": true,
        "$ref": { "file":"../default/widgetsTemplates.xc", "path":"test2" }
      }
    ]
  }
}
