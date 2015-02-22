# Hi! I'm the guy from Ruby Planet! And I love clear code.
# It was painful for me to read initial version, so I've refactored all names.
# Please Enjoy R and this MOOC. If you are interested in detailed information
# please read detailed comment at the end of code.
# Thanks for your review!

makeCacheMatrix <- function(original_matrix = matrix()) {
  # By default original_matrix is the empty matrix

  # Initializing variable supposed for cached solution
  cached_solution <- NULL

  # Setting/Getting original matrix
  set_matrix <- function(arg) {
    original_matrix <<- arg
    cached_solution <<- NULL
  }
  get_matrix <- function() original_matrix

  # Setting/Getting cached solution
  set_solved <- function(solution) cached_solution <<- solution
  get_solved <- function() cached_solution

  # Return list of functions list of functions:
  #  - `get_matrix`/`set_matrix` get/set the value of the original matrix
  #  - `get_solved`/`set_solved` get/set the value of the inverted matrix

  list(
    set_matrix = set_matrix, # ...$set_matrix
    get_matrix = get_matrix, # ...$get_matrix
    set_solved = set_solved,
    get_solved = get_solved)
}

## Consumer of makeCacheMatrix
cacheSolve <- function(cache_matrix, ...) {
  # Get "solved" matrix
  # If solution isn't cached it will be null
  solution <- cache_matrix$get_solved()
  if(!is.null(solution)) {
    # If solution is cached it will be returned
    message("Getting cached matrix")
    return(solution)
  } else {
    # Solve it...
    solution <- solve(cache_matrix$get_matrix(), ...)
    # Put in cache just before return
    cache_matrix$set_solved(solution)
    return(solution)
  }
}

## But how to check if this works ... and really caches?
## First of all create matrix.

## This small matrix will *just* show you the message...
## There is no difference in sence of time for such small matrix
# m <- matrix(rnorm(16), nrow = 4)

## This will give metioned difference...
# m <- matrix(rnorm(16000000), nrow = 4000)

## Assign vector with function to `mv` variable
# mv <- makeCacheMatrix(m)

## Call cacheSolve() with `mv` as argument
# cacheSolve(mv)

## You will get result with delay:
# ...
# [n,  ] -1.0133707610  0.5960284005 -4.543966e-01
# [n+1,]  1.7333438756  0.1842437258  3.645269e-01

## Call it again cacheSolve() with `mv` as argument
## You will get result from cache. Here is output:
# Getting cached matrix
# ...
# [n, ] -1.0133707610  0.5960284005 -4.543966e-01
# [n+1,]  1.7333438756  0.1842437258  3.645269e-01
