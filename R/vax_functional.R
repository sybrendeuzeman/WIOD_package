
#' @title VAX-Domestic for Functional Specialization
#' @description The Domestic Value Added Export that is used in the measure of functional specialization in
#' Timmer,Miroudot and De Vries (2018), Functional specialisation in trade.
#' 
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @details
#' Used [func_spec]
#' 
#' Full Reference: Marcel Timmer, Sébastien Miroudot and Gaaitzen de Vries (2018), 
#' Functional specialisation in trade., 
#' Journal of Economic Geography, Volume 19, Issue 1, Pages 1–30
#' 
#' @examples
#' iot <- load_iot("WIOD2013", 2000)
#' iot <- vax_functional(iot)
#' 
#' @import Matrix
#' @export
vax_functional <- function(iot){
  domestic_block <- matrix(1,iot$n, iot$n)
  select_domestic <- kronecker(diag(iot$c), domestic_block)
  A <- coefficient(iot)
  domestic_iot <- Matrix(diag(iot$c * iot$n) - select_domestic * A)
  domestic_leontiefs <- as.matrix(solve(domestic_iot))
  
  aggr_fin <- kronecker(diag(iot$cf), matrix(1,iot$f,1))
  exp_fin <- iot$FD %*%  aggr_fin
  
  aggr_int <- kronecker(diag(iot$c), matrix(1,iot$n,1))
  exp_int <- iot$I %*% aggr_int
  
  exp_block <- matrix(1, iot$n, 1)
  select_export <- matrix(1, iot$n * iot$c, iot$c) - kronecker(diag(iot$c), exp_block)
  
  exp_dem <- select_export * (exp_fin + exp_int)
  
  Y <- domestic_leontiefs %*% exp_dem
  v_sh = iot$VA / iot$S
  v_sh[is.nan(v_sh)] <- 0
  vax <- sweep(Y, MARGIN = 1, v_sh, '*')
  
  iot$vax <- as.matrix(vax) 
  return(iot)
}