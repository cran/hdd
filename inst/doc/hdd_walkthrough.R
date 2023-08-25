## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
	echo = FALSE,
	eval = TRUE,
	collapse = TRUE,
	comment = "#>"
)

## -----------------------------------------------------------------------------
# We conditionnaly run the code pieces
if(!file.exists("C:/Users/laurent.berge/DATA/MAG/Authors.txt")){
	message("This vignette takes the example of a data set of over 13GB on disk, and thus cannot be run non-locally.")
	knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
#  suppressPackageStartupMessages(library(data.table))
#  library(hdd)

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  library(hdd)
#  peek("_path/authors.txt")

## ---- results='asis'----------------------------------------------------------
#  tab = head(peek("C:/Users/laurent.berge/DATA/MAG/Authors.txt", view = FALSE))
#  if("pdf_document" %in% rmarkdown::all_output_formats(knitr::current_input())){
#    # tab = as.data.table(lapply(tab, function(x) fplot:::truncate_string(iconv(x, to="ASCII", sub = "£"), method = "trimMid", trunc = 16)))
#    tab = as.data.table(lapply(tab, iconv, to="ASCII", sub = "£"))
#  }
#  knitr::kable(tab)
#  

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  col_names = c("AuthorId", "Rank", "NormalizedName", "DisplayName",
#  			  "LastKnownAffiliationId",
#  			  "PaperCount", "CitationCount", "CreatedDate")
#  txt2hdd("_path/authors.txt", # The text file
#  		# dirDest: The destination of the HDD data => must be a directory
#  		dirDest = "_path/hdd_authors",
#  		chunkMB = 500, col_names = col_names)

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  authors = hdd("_path/hdd_authors")
#  summary(authors)

## -----------------------------------------------------------------------------
#  authors = hdd("C:/Users/laurent.berge/DATA/MAG/HDD/authors")
#  summary(authors)

## ---- echo = TRUE-------------------------------------------------------------
#  head(authors)

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  
#  fun_ascii = function(x){
#  	# selection of the first 3 columns
#  	res = x[, 1:3]
#  	# selection of only ascii names
#  	res[!is.na(iconv(NormalizedName, to = "ASCII"))]
#  }
#  
#  col_names = c("AuthorId", "Rank", "NormalizedName", "DisplayName",
#  			  "LastKnownAffiliationId",
#  			  "PaperCount", "CitationCount", "CreatedDate")
#  txt2hdd("_path/authors.txt", dirDest = "_path/hdd_authors_ascii",
#  		chunkMB = 500, col_names = col_names,
#  		preprocessfun = fun_ascii)

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  authors_ascii = hdd("_path/hdd_authors_ascii")
#  head(authors_ascii)

## -----------------------------------------------------------------------------
#  authors_ascii = authors[1:50, 1:3]
#  authors_ascii = authors_ascii[!is.na(iconv(NormalizedName, to = "ASCII"))]
#  head(authors_ascii)

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  names_einstein = authors[grepl("\\beinstein\\b", NormalizedName),
#  						 NormalizedName]
#  length(names_einstein)
#  head(names_einstein)

## -----------------------------------------------------------------------------
#  load("C:/Users/laurent.berge/Google Drive/R_packages/hdd/_DATA/names_einstein.RData")
#  length(names_einstein)
#  head(names_einstein)

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  authors[!is.na(iconv(NormalizedName, to = "ASCII")), 1:3,
#  		newfile = "_path/hdd_authors_ascii"]

## ---- echo = TRUE-------------------------------------------------------------
#  names_first = authors[1, NormalizedName, file = 1:.N]
#  head(names_first)

## ---- echo = TRUE-------------------------------------------------------------
#  names_last = authors[.N, NormalizedName, file = 1:.N]
#  head(names_last)

## ---- echo = TRUE, error = TRUE-----------------------------------------------
#  author_id = authors$AuthorId

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  # to read the full data set into memory:
#  base_authors = readfst("_path/hdd_authors")
#  # Alternative way
#  authors_hdd = hdd("_path/hdd_authors")
#  base_authors = authors_hdd[]

## ---- echo = TRUE, eval = FALSE-----------------------------------------------
#  # x: the original data set
#  # y: the data set you want to merge to x
#  cartesian_merge = function(x){
#  	merge(x, y, allow.cartesian = TRUE)
#  }
#  
#  hdd_slice(x, fun = cartesian_merge,
#  		  dir = "_path/result_merge", chunkMB = 100)
#  

