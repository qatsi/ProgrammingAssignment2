# Hi! I'm the guy from Ruby Planet! And I love clear code.
# It was painfull for me to read initial version, so I've refactored all names.
# Please Enjoy R and this MOOC. If you are interested in detailed information
# please read detailed comment at the end of code.
# Thanks for your review!

makeCacheMatrix <- function(local_matrix = matrix()) {
  # By default local_matrix is the empty matrix

  # Initializing variable supposed for cached solution
  cached_solution <- NULL

  set_matrix <- function(arg) {
    local_matrix <<- arg
    cached_solution <<- NULL
  }
  get_matrix <- function() local_matrix

  # Setting cached solution
  set_solved <- function(solution) cached_solution <<- solution
  # Getting cached solution
  get_solved <- function() cached_solution

  # Return list of functions list of functions:
  #  - `set_matrix` - set the value of the matrix
  #  - `get_matrix` - get the value of the matrix
  #  - `set_solved` - set the value of the inverted matrix
  #  - `get_solved` - get the value of the inverted matrix

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
