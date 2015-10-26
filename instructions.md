INSTRUCTIONS
============
Just drop into your modules folder or use the box-cli to install

`box install autodeploy`

## Settings
You can add configuration settings to your `ColdBox.cfc` under a structure called `autodeploy`:

```js
autodeploy = {
    // The tag file location, realtive or absolute
    "tagFile" : "config/_deploy.tag",
    // The model to use for running deployment commands. Must be a valid WireBox mapping
    "deployCommandObject" :  ""
};
```

## Deploy Command Object
You can optionally create and register a deploy command object via WireBox.  This command object must implement one method:

```
function execute(){}
```

Which will be executed upon a new timestamp change.
