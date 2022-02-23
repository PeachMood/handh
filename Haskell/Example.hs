import RandomLists

-- Prints all random lists from the list
printLists :: [[Int]] -> Int -> IO ()
printLists [] _ = return ()
printLists (list : otherLists) number = do
    putStrLn $ "List " ++ (show number) ++ ": " ++ (show list)
    printLists otherLists (number + 1)

-- Program entry point
main :: IO ()
main = do
    lists <- generateLists 5
    printLists lists 0