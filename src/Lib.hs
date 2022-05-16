module Lib
    ( someFunc
    ) where

import System.Process
import System.IO
import Data.Char

someFunc :: IO ()
someFunc = do
    (_, Just hOut, _, _) <- createProcess (proc "ifconfig" []) { std_out = CreatePipe }
    text <- hGetContents hOut
    putStrLn $ addHeader (lines text) ""

addHeader :: [String] -> String -> String
addHeader [] _ = ""
addHeader (l:ls) h
    | l =="" = '\n':l ++ residBody  ("") -- 空行の場合
    | isLetter (head l) =  '\n':l ++ residBody(header) -- ヘッダがある行の場合
    | otherwise = '\n':h ++ l ++ residBody(header) -- ヘッダ無しで空行以外の場合

    where
        header = if isLetter (head l)  then (fst $ span (/=':') l)++":" else h
        residBody = addHeader(ls)