module Main where

import Control.Monad
import Network.Browser
import Network.HTTP
import Lib

getURL :: String -> IO String
getURL url = do
  resp <- simpleHTTP $ getRequest url
  getResponseBody resp

main :: IO ()
main = do
  con <- getURL "http://www.google.com"
  putStrLn $ con
