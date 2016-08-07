{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( printBuckets
    ) where

import           Control.Lens
import           Network.AWS
import           Network.AWS.S3
import           System.Environment (getArgs)
import           System.IO

example :: FilePath -> IO ListBucketsResponse
example f = do
    e <- newEnv Tokyo $ FromFile "default" f
    l <- newLogger Debug stdout
    runResourceT . runAWS (e & envLogger .~ l) $ send listBuckets

printBuckets :: IO ()
printBuckets = do
    args <- getArgs
    let f = args !! 0
    ex <- example f
    print $ [ x ^. bName | x <- ex ^. lbrsBuckets ]
