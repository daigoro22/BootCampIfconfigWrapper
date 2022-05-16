module Lib
    ( someFunc
    ) where

import System.Process
import System.IO

someFunc :: IO ()
someFunc = do
    (_, Just hOut, _, _) <- createProcess (proc "ifconfig" []) { std_out = CreatePipe }
    text <- hGetContents hOut
    putStrLn text
