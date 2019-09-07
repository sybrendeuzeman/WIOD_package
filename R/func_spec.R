#' @title Calculate Functional Specialization in Trade
#' @description Calculates the functional specialization in trade measure as used by 
#' Marcel P Timmer, Sébastien Miroudot and Gaaitzen J de Vries (2018), Functional specialisation in trade.
#' 
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @param bilateral: If TRUE a full set of bilateral functional specialization measures are calculated. Otherwise, only global.
#' @param aggregation: A vector with ones in and zeros at place of country, ones will be aggregated. 
#' @param functions: Vector with functions that are used. !!TO DO: provide this together with data!!
#' @return The input-output table list with either the bilateral FS measures (bfs_<function>) or global FS (fs_<function> measures
#' and a description of the countries and industries (bfs_<function>_descr or fs_<function>) for use in [export_dataframe()].
#'
#' @description
#' Labor shares for different functions are needed. As of now, this is only available for WIOD2013 from 1999 to 2011. 
#' Add these to iot first via [load_extra_iot()] or [load_extra_iots()]. If not found, the function will not change the IOT.
#' 
#' Full Reference: Marcel Timmer, Sébastien Miroudot and Gaaitzen de Vries (2018), 
#' Functional specialisation in trade., 
#' Journal of Economic Geography, Volume 19, Issue 1, Pages 1–30
#' 
#' 
#'   
#' @examples 
#' iot <- load_iot("WIOD2013", 2000)
#' iot <- load_extra_iot(iot, "joeg2019")
#' iot <- func_spec(iot)
#' iot <- func_spec(iot, bilateral = TRUE)
#' 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' iots <- load_extra_iots(iots, "joeg2019")
#' iots <- on_iots(func_spec, iots)
#' iots <- on_iots(func_spec, iots, bilateral = TRUE)
#' df_fs <- export_dataframe(c("fs_mgt", "fs_rd", "fs_mar", "fs_fab"), iots)
#' df_bfs <- export_dataframe(c("bfs_mgt", "bfs_rd", "bfs_mar", "bfs_fab"), iots)
#' 
#' @export
func_spec <- function(iot, bilateral = FALSE, aggregation = NULL , functions = c("mgt", "rd", "mar", "fab")){
  
  # Check if extra data is there, otherwise return original IOT
  if (is.null(iot$joeg2019)){
    print(paste("Necessary supplemental data for ", toString(iot$year), " not yet present.", sep = ""))
    iot <- load_extra_iot(iot, "joeg2019")
    if (is.null(iot$joeg2019)){
      return(iot)
    }
  }
  
  # Use vax_functional to get domestic VAX-D
  iot <- vax_functional(iot)
  vax_tot = matrix(0, iot$c , iot$c)
  vax_list = list()
  
  # Find VAX-D attributable to a certain function
  for (fun in functions){
    vax_fun <- sweep(iot$vax, MARGIN = 1, iot$joeg2019$lsh * iot$joeg2019[[paste("lsh_", fun, sep = "")]], '*')  
    
    # Aggregate industries to the country-level
    ind_block <- matrix(1, 1, iot$n)
    aggr <- kronecker(diag(iot$c), ind_block)
    vax_fun <- aggr %*% vax_fun
    vax_tot <- vax_tot + vax_fun
    
    vax_list[[paste("vax_", fun, sep = "")]] <- vax_fun
  }

  if (!bilateral){
    if (is.null(aggregation)){
      for (fun in functions){
        vax_fun = vax_list[[paste("vax_", fun, sep = "")]]
        sh_fun_glob <- sum(vax_fun) / sum(vax_tot)
        sh_fun <- rowSums(vax_fun) / rowSums(vax_tot)
        fs <- sh_fun / sh_fun_glob
        colnames(iot$countries) <- "country"
        iot[[paste("fs_", fun, sep = "")]] <- fs
        iot[[paste("fs_", fun, "_descr", sep = "")]] <- iot$countries
      }
      return(iot)
    }
    
    if (!is.null(aggregation)){
      for (fun in functions){
        vax_fun = vax_list[[paste("vax_", fun, sep = "")]]
        sh_fun_glob <- sum(vax_fun) / sum(vax_tot)
        sh_fun <- sum(vax_fun * aggregation) / sum(vax_tot * aggregation)
        fs <- sh_fun / sh_fun_glob
        iot[[paste("fs_", fun, "_aggr", sep = "")]] <- fs
      }
      return(iot)
    }
  }
  if (bilateral){
    for (fun in functions){
      vax_fun = vax_list[[paste("vax_", fun, sep = "")]]
      sh_fun_glob <- colSums(vax_fun) / colSums(vax_tot)
      sh_fun <- vax_fun / vax_tot
      fs <- sweep(t(sh_fun), MARGIN = 1, sh_fun_glob, "/")
      fs <- t(fs)
      colnames(fs) <- iot$countries
      colnames(iot$countries) <- "country"
      iot[[paste("bfs_", fun, sep = "")]] <- fs
      iot[[paste("bfs_", fun, "_descr", sep = "")]] <- iot$countries
    }
    return(iot)
  }
}