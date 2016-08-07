{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Lens
import           Network.AWS
import           Network.AWS.S3
import           System.IO

example :: IO ListBucketsResponse
example = do
    e <- newEnv Tokyo $ FromEnv "AWS_ACCESS_KEY_ID" "AWS_SECRET_ACCESS_KEY" Nothing
    runResourceT . runAWS e $ send listBuckets

printBuckets :: IO ()
printBuckets = do
    ex <- example
    print $ [ x ^. bName | x <- ex ^. lbrsBuckets ]

main :: IO ()
main = printBuckets
