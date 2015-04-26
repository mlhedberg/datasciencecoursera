## The two functions below create a vector that caches the inverse of a Matrix. 
## If the inverse has already been calculated and the matrix has not changed,
## the cached data storing the value of the matrix inverse rather than recalculating.

## The first function, makeCacheMatrix creates a list of functions that can store 
## and retreive the value of the matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
  ## initialize a variable that will store value for the matrix inverse with NULL value
  i <- NULL
  ## Defines the set function
  set <- function(y) {
    ## Will search all parent frames for a defined value of x and set it to y
    X <<- y
    ## Will set value of matrix inverse, i, to NULL
    i <<- NULL
  }
  ## Defined the get function, which returns the value of x
  get <- function() x
  ## Defines the setinverse function, which calculates inverse and sets value to i
  setinverse <- function(solve) i <<- solve
  ## Defines getinverse function, which returns value for matrix inverse, i
  getinverse <- function() i
  ## Creates a special vector, which is a list containing all 4 functions
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## The function below will check the special vector created in function 1 to see
## if the matrix inverse has already been calculated. If it has, it returns the 
## cached value. If not, it calculates the matrix inverse and sets the value of 
## the inverse in the cache

cacheSolve <- function(x, ...) {
  ## Sets i to the value of the cache variable, i, in the special vector using the 
  ## getinverse function
  i <- x$getinverse()
  ## 'If' loop will return the cached data for the value of the inverse if i in not NULL
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  ## If I is NULL, the value of the matrix is retrived using the get function and set
  ## to object data
  data <- x$get()
  ## Inverse of the matrix is calculated using the solve function
  i <- solve(data, ...)
  ## Value of the matrix inverse is cached in the special vector using setinverse function
  x$setinverse(i)
  ## The value of the matrix inverse is returned
  i
}
