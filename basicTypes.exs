# Booleans
Elixir supports true & false as booleans

# Atoms
An Atom is a contant whose value is its own name.Some other languages call these symbols.
They are often useful to enumerate over distinct values.Eg

:apple
:orange
Atoms are equal if their names are equal

:apple == :apple
# true

Often they are used to express the state of an operation, by using values such as :ok and :error.

The booleans true & false are also atoms
true == :true
# true

is_atom(false)
# true

Elixir allows you to skip the leading : for the atoms false, true and nil.

# Strings
Strings in Elixir are delimited by double quotes, & they are encoded in UTF-8:
Eg "String"

Elixir also supports string interpolation
string = :world
"hellö #{string}"
# "hellö world"

# Anonymous functions

Elixir also provides anonymous functions. Anonymous functions allow us to store &
pass executable code around as if it was an integer or a string.
They are delimited by the keywords fn & end

add = fn a, b -> a + b end
add.(1, 2)
# 3

Parenthesised arguments after the anonymous function indicate that we want the function to be evaluated,
not just its definition returned. Note that a dot (.) between the variable & parentheses is required to invoke an anonymous function.
The dot ensures there is no ambiguity between calling the anonymous function matched to a variable add & a named function add/2.
NOTE Elixir makes a clear distinction between anonymous functions & named functions.

Anonymous functions are also closures & as such they can access variables that are in scope when the function is defined.

double = fn a -> add.(a, a) end
double.(2)
# 4

A variable assigned inside a function does not affect its surrounding environment
x = 42
# 42

(fn -> x = 0 end).()
# 0

x
# 42

# (Linked) Lists
Elixir uses square brackets to specify a list of values. Values can be of any type

[1, 2, true, 3]

Two lists can be concatenated or subtracted using the ++/2 and --/2 operators respectively

# concatination
[1, 2, 3] ++ [4, 5, 6]
# [1, 2, 3, 4, 5, 6]

# subtraction
[1, true, 2, false, 3, true] -- [true, false]
# [1, 2, 3, true]

List operators never modify the existing list. Concatenating to or removing elements from a list returns a new list.
We say that Elixir data structures are immutable. One advantage of immutability is that it leads to clearer code.
You can freely pass the data around with the guarantee no one will mutate it in memory - only transform it.

The head is the first element of a list & the tail is the remainder of the list. They can be retrieved with the functions hd/1 and tl/1.

list = [1, 2, 3]
hd(list)
# 1

tl(list)
# [2, 3]

Keep in mind single-quoted & double-quoted representations are not equivalent in Elixir as they are represented by different types

'hello' == "hello"
# false

Single quotes are charlists, double quotes are strings.


# Tuples
Elixir uses curly brackets to define tuples. Like lists, tuples can hold any value

{:ok, "hello"}

tuple_size {:ok, "hello"}
# 2

It is also possible to put an element at a particular index in a tuple with put_elem/3

tuple = {:ok, "hello"}
put_elem(tuple, 1, "world")
# {:ok, "world"}
tuple
# {:ok, "hello"}

Notice that put_elem/3 returned a new tuple. The original tuple stored in the tuple variable was not modified. Like lists, tuples are also immutable.
Every operation on a tuple returns a new tuple, it never changes the given one.

# Lists or tuples?
What is the difference between lists and tuples?

Lists are stored in memory as linked lists, meaning that each element in a list holds its value and points to the following element until the end of the list is reached.
This means accessing the length of a list is a linear operation: we need to traverse the whole list in order to figure out its size.

Tuples, on the other hand, are stored contiguously in memory. This means getting the tuple size or accessing an element by index is fast.
However, updating or adding elements to tuples is expensive because it requires creating a new tuple in memory:
