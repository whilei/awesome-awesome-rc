# Awesome AwesomeWM RC

This is the default **awesome-git** `rc.lua`, but structured for better customization and modularity.
Initially, i did it for myself, because i needed something to start with,
and i decided to share because i didn't find anything similar. 
None of the logic was touched, but everything was reformatted to match the code style that i like.

## Structure

The main `rc.lua` file only load the modules it was split into.
Each module can have its own submodules, and they are all loaded from `init.lua`.

module | description
-------- | -----------
`bindings` | mouse and key bindings
`config` | various variables for apps/tags etc...
`modules` | third-party libraries (e.g. [bling](https://github.com/BlingCorp/bling), [lain](https://github.com/lcpz/lain))
`rules` | client rules
`signals` | all signals are connected here
`widgets` | all widgets are defined here

The `widgets` module could be better structured, might redo it later.

Feel free to submit PRs!

## Credits

[This config](https://git.linuxit.us/spider/awesome/src/commit/921c5019df6a03915e09efcb1336bbca518a4401) was used as a base.