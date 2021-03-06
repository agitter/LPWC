#' Best Lag
#'
#' This function computes the best lags for a dataset using weighted correlation
#'
#' @param data a matrix with columns representing different timepoints
#' @param max.lag a numeric value of the maximum lag allowed
#' @param timepoints a vector of time points used in the dataset
#' @param C a numeric value of C used in computing weighted correlation
#' @return a vector of best lags used in the dataset
#'
#'
#'
#' @author Thevaa Chandereng, Anthony Gitter
#'
#'

best.lag <- function(data, timepoints, max.lag = NULL, C){
  data <- as.matrix(data)
  if(is.null(max.lag)){
    max.lag <- floor(length(timepoints) / 4)
  }
  stopifnot(dim(data)[2] == length(timepoints), max.lag <= length(timepoints) / 4,
            is.numeric(max.lag), is.numeric(C))
  shift <- rep(NA, dim(data)[1])
  for(i in 1:dim(data)[1]){
    lags <- rep(NA, (dim(data)[1]))
    bcorr <- rep(NA, (dim(data)[1]))
    for(j in 1:dim(data)[1]){
      if(i != j){
        corr <- rep(NA, max.lag * 2 + 1)
        for(k in max.lag:1){
          allw <- weight(t = timepoints, lag = k, C = C)
          corr[max.lag - k + 1] <- allw$w0 *
            wt.corr(data[i, 1:(length(timepoints) - k)],
                    data[j, (k + 1):length(timepoints)],
                    w = allw$w)
        }
        corr[max.lag + 1] <- cor(data[i, ], data[j, ])
        for(m in 1:max.lag){
          allw <- weight(t = timepoints, lag = m, C = C)
          corr[max.lag + m + 1] <- allw$w0 *
            wt.corr(data[j, 1:(length(timepoints) - m)],
                    data[i, (m + 1):length(timepoints)],
                    w = allw$w)
        }
        val <- max.lag:-max.lag
        lags[j] <- val[which.max(corr)]
        bcorr[j] <- max(corr)
      }
    }
    lags <- lags[- i]
    bcorr <- bcorr[- i]
    shift[i] <- score(bcorr, lags)
  }
  return(shift)
}
