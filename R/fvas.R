#' @title Find Foreign and Regional Value Added Share
#' @description Calculates the foreign value added and regional value added shares as in 
#' Bart Los, Marcel P Timmer, Gaaitzen J de Vries
#' How global are global value chains? A new approach to measure international fragmentation#' 
#' 
#' @param iot: List with elements in a Input-Output Table (load via [load_iot()])
#' @param regions: Vector with categorisation of countries.
#' @param industries: Vector with categorisation of industries.
#' @return The input-output table list with 
#' the Foreign Value Added Share measure (fvas),
#' the Regional Foreign Value Added Share measure (rfvas), 
#' and the Global Foreign Value Added Share measure (gfvas)
#' and a description of the countries and industries 
#' (fvas_descr, rfvas_descr, gfvas_des) for use in [export_dataframe()].
#' 
#' @details regions defines the regions that are used to calculate RFVAS. 
#' If none selected, RFVAS will be equal to FVAS.
#' 
#' Full reference:
#' Bart Los, Marcel P Timmer, Gaaitzen J de Vries, 2015,
#' How global are global value chains? A new approach to measure international fragmentation
#' Journal of Regional Science, volume 55, issue 1, pages 66-92
#' 
#' @examples 
#' iot <- load_iot("WIOD2013", 2000)
#' iot <- fvas(iot)
#' 
#' iots <- load_iots("WIOD2013", 2000:2001)
#' NAFTA <- c("USA", "MEX", "CAN")
#' BENELUX <- c("BEL", "NLD", "LUX") 
#' regions <- countrycat(list(NAFTA, BENELUX), iots)
#' primary <- c("AtB", "C") 
#' transport <- c("60", "61", "62", "63")
#' industries <- industrycat(list(primary, transport), iots)
#' 
#' iots <- on_iots(fvas, iots, regions = regions, industries = industries)
#' df_gii <- export_dataframe(c("fvas", "rfvas", "gfvas"), iots)
#' 
#' @export
fvas <- function(iot, regions = "None", industries = "None"){
  iot <- fd_total(iot)
  iot <- leontief(iot)
  
  v_sh = iot$VA / iot$S
  v_sh[is.nan(v_sh)] <- 0
  
  first <- sweep(iot$L, MARGIN = 1, t(v_sh), '*')
  fvas_g <- sweep(first, MARGIN = 2, iot$fd_total, '*')  
  
  if (length(regions) == 1){ 
  if (regions == "None"){
    region_list = rep(1, iot$c)
  }
  }
  else{
    region_list = regions
  }
  
  # Select such that domestic VA is excluded
  select_c = matrix(1, iot$c, iot$c)
  for (i in 1:iot$c){
    select_c[i,i] = 0
  }
  select_n = matrix(1, iot$n, iot$n)
  select = kronecker(select_c, select_n)
  fvas_g_sel = fvas_g * select
  
  # Make aggregation in different regions
  c_mat = matrix(0, max(region_list),iot$c)
  for (row in 1:max(region_list)){
    c_mat[row, 1:iot$c] <- (region_list == row)
  }
  i_mat = matrix(1,1,iot$n)
  aggr <- kronecker(c_mat, i_mat)
  reg_vas <- aggr %*% fvas_g_sel
  
  # Calculate different measures
  iot$rfvas <- colSums(aggr * reg_vas) / colSums(fvas_g)
  gfvas <- colSums((1-aggr) * reg_vas) / colSums(fvas_g)
  fvas <- colSums(reg_vas) / colSums(fvas_g)

  #iot$rfvas <- rfvas
  iot$gfvas <- (gfvas)
  iot$fvas <- (fvas)
  
  iot$fvas_descr <- countryindustry_descr(iot, regions, industries)
  iot$gfvas_descr <- countryindustry_descr(iot, regions, industries)
  iot$rfvas_descr <- countryindustry_descr(iot, regions, industries)

  return(iot)
}