### Programming Assignment 2

This assignment implements an R function that is able to cache potentially time-consuming computations.  For example, inverting a large matrix can potentially take a long time to compute.  If the contents of the vector are not changing, it may make sense to cache the value of the inverted matrix so that when we need it again, it can be looked up in the cache rather than recomputed. This Programming Assignment takes advantage of the scoping rules of the R language so that they can be manipulated to preserve state inside of an R object.

The R file consists of 4 functions:

1.  `makeCacheVector:` creates a special "vector" to hold the base vector and inverted matrix and functions to get and set them
2.  `cacheSolve`, calculates the inverted matrix if one does not yet exist, else it creates one and has it cached
3.  `test_makeCacheMatrix` tests the base functions in makeCacheVector
4.  `test_cache_solve` tests creation and caching of the inverted matrix
 

### Function headers from the file:


The first function, `makeCacheVector` creates a special "vector".  Here is the header: 

<!-- -->

    # This function creates a special "matrix" object that can cache its inverse
    #  local instance variables: 
    #    1. m_cached - inverted matrix 
    #    1. x_cached - base input matrix
    #  input: the base matrix#  output: list that contains 4 functions:
    #    1. set()        sets/resets the base matrix/nulls out the inverted matrix
    #    2. get()        returns the base matrix
    #    3. setMatrix()  sets the inverted matrix
    #    4. getMatrix()  returns the inverted matrix
    makeCacheMatrix<- function(x_in = matrix())
    
The following function, `cacheSolve`, calculates the inverted matrix of the special "vector" created with the above function.  Here is the header:  
    
    # This function computes inverse of the "matrix" returned by makeCacheMatrix
    #
    #  input: vector of functions
    #    1. set()        sets/resets base matrix and nulls out the inverted matrix
    #    2. get()        returns the base matrix
    #    3. setMatrix()    sets the inverted matrix
    #    4. getMatrix()    returns the inverted matrix
    #  output:  inverted matrix
    #  process: retrieve cached value check to see if there is cached inverted 
    #           matrix:
    #    if there is, return it
    #    if not, get the base matrix, invert the matrix, cache it, and return it
    cacheSolve <- function(func_v, ...)


Test routines are included to test the above two functions.  Here is information on the tests:

<!-- -->
        
    ###################################################################
    # Test Routines
    ###################################################################
    # test data:
    #
    # small_matrix  <- matrix(sample(1:10, 100, replace=TRUE), 10, 10)
    # medium_matrix <- matrix(sample(1:10, 10000, replace=TRUE), 100, 100)
    # big_matrix    <- matrix(sample(1:10, 1000000, replace=TRUE), 1000, 1000)
    #
    ###################################################################
    # sample test calls:
    #
    # test_makeCacheMatrix(medium_matrix)
    # test_cacheSolve(big_matrix, timer=TRUE)
    # test_cacheSolve(small_matrix)
    ###################################################################
    
    
The following function, `test_makeCacheMatrix`, tests the calculates the inverted matrix of the special "vector" created with the above function.  Here is the header:  
    
<!-- -->
    
    # This function tests makeCacheMatrix
    #
    #  input: base matrix
    #  output: test result
    #  process: 
    #    1. test makeCacheMatrix: get(), SetMatrix(), and getMatrix()
    #    2. test makeCacheMatrix: set(), get(), SetMatrix(), and getMatrix()
    #
    test_makeCacheMatrix <- function(x_in = numeric())
    

The following function, `test_cache_solve`, tests the calculates the inverted matrix of the special "vector" created with the above function.  Here is the header: 

<!-- -->

    # This function tests cacheSolve
    #
    #  input: base matrix
    #         timer flag: TRUE: display elapsed time, 
    #                     FALSE: display inverted mmatrix 
    #  output: test result: elapsed time or inverted matrix
    test_cacheSolve  <- function(x_in = numeric(), timer=FALSE)     


