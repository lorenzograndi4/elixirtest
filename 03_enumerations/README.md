# Enumeration excercises

Use the Enum module or plain recursion, if you like.

## 1 - Write a function that adds N to each element of the given list

    iex> Enumerations.add_n([1, 2, 3], 3)
    [4, 5, 6]
    iex> Enumerations.add_n([1], -1)
    [0]

## 2 - Write a function that counts the number of dots in a string.

    iex> Enumerations.count_dots("Hello.")
    1
    iex> Enumerations.count_dots("This is a test... How long this will work.")
    4

## 3 - Write a function that takes a string and returns a map with the word frequency.

    iex> Enumerations.freq("hello world this is world")
    %{"hello" => 1, "world" => 2, ...}
