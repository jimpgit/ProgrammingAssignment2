# This function creates a special "matrix" object that can cache its inverse
#
#  local instance variables: 
#    1. m_cached - inverted matrix 
#    1. x_cached - base input matrix
#  input: the base matrix
#  output: list that contains 4 functions:
#    1. set()          sets/resets the base matrix and nulls out the inverted matrix
#    2. get()          returns the base matrix
#    3. setMatrix()    sets the inverted matrix
#    4. getMatrix()    returns the inverted matrix
#  
makeCacheMatrix<- function(x_in = matrix()) {
     
    # initialize the cached values
    base_m <- x_in      # base matrix
    inv_m <- NULL       # inverted matrix 
     
    # create functions to be saved in a list and returned
    #
    # sets/resets the base matrix and nulls out the inverted matrix
    set <- function(base_in) {
        base_m <<- base_in
        inv_m  <<- NULL
    }
    # returns the base matrix
    get <- function() {
        base_m
    }  
    # sets the inverted matrix
    setMatrix <- function(inv_in) {
        inv_m <<- inv_in
    }
    # returns the inverted matrix
    getMatrix <- function() {
        inv_m
    }  
       
    # return the functions in a list
    return(
        list(
            set = set, 
            get = get,
            setMatrix = setMatrix,
            getMatrix = getMatrix)
        )  
}

# This function computes the inverse of the special "matrix" returned by makeCacheMatrix
#
#  input: vector of functions
#    1. set()          sets/resets the base matrix and nulls out the inverted matrix
#    2. get()          returns the base matrix
#    3. setMatrix()    sets the inverted matrix
#    4. getMatrix()    returns the inverted matrix
#  output: inverted matrix
#  process: retrieve cached value and check to see if there is a cached inverted matrix:
#    if there is, return it
#    if not, get the base matrix, invert the matrix, cache it, and return it
#
cacheSolve <- function(func_v, ...) {
                
    # initialize variables
    inv_m <- func_v$getMatrix()
     
    # retrieve cached value and check to see if there is a cached inverted matrix
    if(!is.null(inv_m)) {
        # there is, return it
        message("   getting cached data")
        return(inv_m)
    }
  
    # there is not, get the base matrix
    data <- func_v$get()
    # invert the matrix
    inv_m <- solve(data, ...)
    # cache it
    func_v$setMatrix(inv_m)
    message("   initializing cached data")
    # return it
    return(inv_m)
}

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
#
###################################################################
#
# This function tests makeCacheMatrix
#
#  input: base matrix
#  output: test result
#  process: 
#    1. test makeCacheMatrix: get(), SetMatrix(), and getMatrix()
#    2. test makeCacheMatrix: set(), get(), SetMatrix(), and getMatrix()
#
test_makeCacheMatrix <- function(x_in = numeric()) {
  
    # create the vector of functions
    func_v <- makeCacheMatrix(x_in)
    
    # using initial data, test: get(), get(matrix(), setMatrix()     
    # get() test
    get_test <- func_v$get()
    cat("get() test: matrix = \n")
    print(get_test[1,1:5])
    
    # getMatrix() test
    getMatrix_test <- func_v$getMatrix()
    cat("\ngetMatrix() test: matrix = \n")
    print(getMatrix_test[1,1:5])
    
    # setMatrix() test: get() then setMatrix() then getMatrix()
    get_test <- func_v$get()  
    func_v$setMatrix(solve(get_test))
    getMatrix_test <- func_v$getMatrix()
    cat("\nget(), setMatrix(), getMatrix() test: matrix = \n")
    print(getMatrix_test[1,1:5])
  
    # using set() data, test: get(), get(matrix(), setMatrix()     
    # set() test
    func_v$set(x_in + 5)
    set_test <- func_v$get()
    cat("\n\nset() test: \n")
    print(set_test[1,1:5])
    
    # get() test
    get_test <- func_v$get()
    cat("\nget() test: \n")
    
    print(get_test[1,1:5])
    # getMatrix() test
    getMatrix_test <- func_v$getMatrix()
    cat("\ngetMatrix() test: matrix = \n")
    print(getMatrix_test[1,1:5]) 
    
    # setMatrix() test: get() then setMatrix() then getMatrix()
    get_test <- func_v$get()
    func_v$setMatrix(solve(get_test))
    getMatrix_test <- func_v$getMatrix()
    cat("\nget(), setMatrix(), getMatrix() test: matrix = \n")
    print(getMatrix_test[1,1:5])
}  

# This function tests cacheSolve
#
#  input: base matrix
#         timer flag: TRUE: display elapsed time, FALSE: display inverted mmatrix 
#  output: test result: elapsed time or inverted matrix
#
test_cacheSolve <- function(x_in = numeric(), timer=FALSE) {
  
    # create the vector of functions
    func_v <- makeCacheMatrix(x_in)
  
    # test cacheSolve() initially, so no cached inverted matrix
    cat("\n\ncacheSolve_test: initial \n")
    if(timer) {
        time_result <- system.time(cacheSolve(func_v))
        print(time_result)
    } else {
        cacheSolve_test <- cacheSolve(func_v) 
        cat("   cacheSolve_test: matrix = \n")
        print(cacheSolve_test[1,1:5])
    }
  
    # test cacheSolve() with cached inverted matrix
    cat("\n\ncacheSolve_test: cached \n")
    if(timer) {
        time_result <- system.time(cacheSolve(func_v))
        print(time_result)
    } else {
        cacheSolve_test <- cacheSolve(func_v) 
        cat("   cacheSolve_test: matrix = \n")
        print(cacheSolve_test[1,1:5])
    }
}  


