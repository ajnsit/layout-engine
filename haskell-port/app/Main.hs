module Main where

import Types
import Sample
import Layout

main :: IO ()
main = print $ layout (Position 1 1) input2
