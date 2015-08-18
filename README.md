# cordova-clickr
A generic clicker application for setting up and messing around in a
coffescript / react / reflux / cordova workflow

Requires [node](https://nodejs.org/) and 
[libsass](https://github.com/sass/libsass). Both are most likely available
through your favorite package manager.

To setup, clone the repo, navigate to the cloned directory, and call

    $ npm install
    $ grunt
    $ cordova platform add <android/ios/etc>
    $ cordova run

# license
[apache2](http://www.apache.org/licenses/LICENSE-2.0)


# project stack / organization
Application logic is in a dialect of CoffeeScript called cjsx
(Coffescript JSX), which allows you to write react components with a
pseudo-html syntax.

Styles are done with SCSS.


## build process
Before building the mobile app, you need to build the website by calling
`grunt`, or `grunt dev` for continuous file watching & recompilation

### scripts
CJSX is collected by `browserify`, which starts at `init.cjsx` and `lib.cjsx`
and looks through `require` calls, compiling those into a single file.

the scripts are split into two blocks (lib and behavior scripts) in order to
avoid recompiling the library files whenever a change is made in a
application logic script. *This has the downside of polluting the global
namespace*. See `lib.cjsx` for the files that are effectively `require`d at
the top of every file.

### style
To include a stylesheet, `@include` it in `index.scss`.


## overview of react/reflux magic
You don't need to read this section if you already know how react / reflux
works, this is jsut a quick overview to bring people up to speed without having
to go off on large tangents.

### stores
All shared state is supposed to be held in a store. Components can listen to
stores, and get internal state updates when something in that shared state
changes. 

When a store is updated, it triggers a re-render (expensive) in each listening
component. Values likely to change together should likely be in the same
store to avoid unecessary re-renders.

### actions
Actions alert stores to changes of some type. A store can register itself as
listening to a set of actions. When an action is fired, the corresponding
onAction methid in each listening store will be called.

For example, if `LoginStore` is listening to `userLogin`, then when `userLogin`
is fired, `LoginStore.onUserLogin` will automatically be called.

### components
Components are like custom DOM elements on the React Virtual DOM.*tl;dr,*

- *props*: values that are not going to change during the lifetime of a
    component, passed in from the component's parent
- *state*: values that are likely to change during the lifetime of a component.
- `render`: Draw the component as a React virtual DOM element
- `getInitialState` 
- `getDefaultProps`

There's a lot of useful stuff in the React API, so go read
[The React Tutoirials](https://facebook.github.io/react/docs/tutorial.html)
when you have questions / some free time.
