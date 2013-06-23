module Main where

import Test.QuickCheck.Arbitrary (Arbitrary(..))
import Test.Hspec
import Test.Hspec.QuickCheck (prop)

fib :: Integer -> Integer
fib n
  | n <= 2    = 1
  | otherwise = fib (n-1) + fib (n-2)

fibCPS :: Integer -> (Integer -> a) -> a
fibCPS n k
  | n <= 2    = k 1
  | otherwise = fibCPS (n-1) $
                \val1 -> fibCPS (n-2) $
                         \val2 -> k (val1 + val2)

fibWithCPS :: Integer -> Integer
fibWithCPS n = fibCPS n id


data FibStream a = Done a
                 | StillWorking Integer (Integer -> a)

newtype Small = Small Integer deriving (Show)
instance Arbitrary Small where
  arbitrary = fmap (Small . (`mod` 32)) arbitrary
  shrink = const []


main :: IO ()
main = hspec $ do
  describe "fibonacci in cps" $ do
    prop "matches the original fib" $ \(Small n) ->
      fib n == fibWithCPS n
