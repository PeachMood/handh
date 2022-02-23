module RandomLists (generateLists) where

import System.Random (randomRIO, getStdRandom, randomR)
import Control.Monad (replicateM, when)
import Data.List (sort)

-- Returns a random number from 1 to "bound", not in a list "sizes".
getRandomSize :: [Int] -> Int -> IO (Int, [Int])
getRandomSize sizes bound = do
    let loop = do
        size <- getStdRandom $ randomR (1, bound)
        if elem size sizes
            then loop
            else return (size, size : sizes)
    loop

-- Returns a list with random numbers of random size.
getRandomList :: Int -> IO ([Int])
getRandomList size = replicateM size $ randomRIO (1, 100)

-- Returns a list of random lists. This is a helper function.
generateLists' :: Int -> [Int] -> IO([[Int]])
generateLists' 0 sizes = return []
generateLists' n sizes = do
    (randomSize, newSizes) <- getRandomSize sizes (5 * n)
    randomList <- getRandomList randomSize
    let sortedList = if (n - 1) `mod` 2 == 0
        then sort randomList
        else reverse $ sort randomList
    otherLists <- generateLists' (n - 1) newSizes
    return $ otherLists ++ [sortedList]

-- The main function that generates a list consisting of "n" lists of random size filled with random numbers.
-- List sizes do not match. Lists in even positions are sorted in ascending order, in odd ones - in descending order.
generateLists :: Int -> IO([[Int]])
generateLists n
    | n < 0 = error "The value of the n parameter must be positive."
    | otherwise = generateLists' n []
