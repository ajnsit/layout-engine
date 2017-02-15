# An extremely simple Elm Grid Layout Engine

## To run the Elm Version (HTML UI)

### NOTE: This is old code which doesn't work with recent Elm versions (which don't have FRP Signals)

Run with -

```
elm-package install
elm-reactor
```

Then open `http://localhost:8000/Main.elm` in a browser.


## To run the Haskell Version (Commandline)

Run with -

```
cd haskell-port
stack build
stack exec layout-engine-exe
```

