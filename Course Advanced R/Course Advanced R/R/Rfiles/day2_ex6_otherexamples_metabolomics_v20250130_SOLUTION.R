# -------------------------------------------------------------------- #
#  Course Introduction to R
#    Other examples
#
# 
#  input:   metabolomics_vYYYYMMDD.xlsx
#  output:  metabolomics_prepared_vYYYYMMDD.Rdata
#  purpose: -
#
#  remarks: features in rows (carrying numbers) 
#           sample names (carrying letters)
#          There are 2 groups plus a quality control, being pooled sample

#  author:  Sereina Herzog
#  status:  06.02.2025
# -------------------------------------------------------------------- #

 # clear workspace
   rm(list=ls(all=TRUE))
  
 # general information about data set version  
  
   date_prepared <- "20250206" 
  
 
# ------------------------- #
#  PATHS ----
# ------------------------- #
  
  # paths laptop
    
    path_Rfiles <- "R/Rfiles/"
  
    path_Rdata <- "R/Rdata/"
    
      
# ------------------------- #
#  LIBRARIES ----
# ------------------------- #
  
    library(tidyverse)
    library(ggplot2)
    library(readxl) # good package for .xlsx

 
# ------------------------- #
#  FUNCTIONS ----
# ------------------------- #
 
     # not needed in this exercise
  
    
    
# --------------------------------------------------------------------------- #
#  INPUT ----
# --------------------------------------------------------------------------- #
  # ------------------------- #
  ##  file names input ----
  # ------------------------- #
   
    # get name of file in folder Rdata 
       file_input <- 
          list.files(path = path_Rdata, pattern = "metabolomics") %>% 
          .[str_detect(string = ., pattern = "xlsx")]
      
      # other solution: file_input <- "metabolomics_v20250129.xlsx"
        
  # ------------------------- #
  ##  file names output ----
  # ------------------------- #  
    
   
    # create output name for dataset
      file_output_rdata <- paste0("metabolomics_prepared_v",
                                  date_prepared,
                                  ".Rdata")
    
  
  
  
# --------------------------------------------------------------------------- #
#  INFORMATION GENERAL ----
# --------------------------------------------------------------------------- #

    info <- list()

  ## General information ----
    info_general <-
      tibble(Topic = c("Original data file",
                       
                       "Date prepared",
                       "Current data file"
                       ),

             Name = c(file_input,
                    
                      date_prepared,
                      file_output_rdata
                    )
      )

      info$general <- info_general


# --------------------------------------------------------------------------- #
#  DATA IMPORT ----
# --------------------------------------------------------------------------- #
   
  # get filename and group information
      
      dt_fg <-
        readxl::read_xlsx(path = paste0(path_Rdata, file_input), 
                          sheet = "Intro R_Example Datafile",
                          range = cell_rows(1:2),
                          col_names = FALSE)
      
  # get filename and values with features    
      dt_values <-
        readxl::read_xlsx(path = paste0(path_Rdata, file_input), 
                          sheet = "Intro R_Example Datafile",
                          skip = 2,
                          col_names = as.character(c("features", dt_fg[1,-1])))
      
# --------------------------------------------------------------------------- #
#  DATA PREPARATION ----
# --------------------------------------------------------------------------- #
      
      #  remarks: features in rows (carrying numbers) 
      #           sample names (carrying letters)
      #          There are 2 groups plus a quality control, being pooled sample
   
  # prepare dt_file_group - switch from wide to long
      
      dt_file_group  <-
      
        tibble(filename = as.vector(as.character(dt_fg[1,-1])),
               group = as.vector(as.character(dt_fg[2,-1])))
   
  # prepare dt_values - from wide to long
      dt_values_long <- 
      dt_values %>% 
        pivot_longer(cols = -features, names_to = "filename")
  
  # combine information
     dt_metabolomic <-
       
      left_join(x = dt_values_long,
                y = dt_file_group,
                by = c("filename" = "filename"))
      
             
  
      
    # check class of all parameters in dataset
      str(dt_metabolomic)

# --------------------------------------------------------------------------- #
# Testing plots ----
# --------------------------------------------------------------------------- #
      
    library(gtsummary)  
  # investigate data
    x <-  
      dt_metabolomic %>% 
        group_by(features, group) %>% 
        summarize(n_valid = sum(!is.na(value)))
    x
    
    x %>% 
      filter(group == "Blank")
    
      # range n_valid per group level
        x %>% 
          group_by(group) %>% 
          summarise(nv_min = min(n_valid),
                    nv_max = max(n_valid))
         
        x %>% 
          filter(n_valid ==0)
        
    
  # check one feature
    int_feature <- 1    
    
    dt_metabolomic %>% 
      filter(features == int_feature)
    
        dt_metabolomic %>% 
          filter(features == int_feature) %>% 
          gtsummary::tbl_summary(data =.,
                                 by = group,
                                 include = value,
                                 type = all_continuous() ~ "continuous2",
                                 statistic = all_continuous() ~ c("{median} ({p25}, {p75})", "{min}, {max}"))
      
        dt_metabolomic %>% 
          filter(features == int_feature) %>% 
          filter(group != "Blank") %>% 
          
          ggplot(aes(x = group, y = log10(value), fill = group)) +
            geom_boxplot(alpha = 0.3) +
            geom_point(aes(colour = group), alpha = 0.5) +
            theme_bw()
        
# --------------------------------------------------------------------------- #
# Dictionary ----
# --------------------------------------------------------------------------- #
 # sometimes detailed dictionary is available
  
   # dictionary <-
   #    tibble(parameter = names(dt_supraclavicular),
   #           parameter_label = c("Subject ID",
   #                               'Gender',
   #                               'BMI',
   #                               
   #                               'Total opioid consumption [mg]'),
   #           parameter_info = c("Subject ID",
   #                              'Gender',
   #                              'Body mass index',
   #                             
   #                              'Total opioid consumption')
   #           )  
   #    
   # info$dictionary <- dictionary    
        
# --------------------------------------------------------------------------- #
# SAVE ----
# --------------------------------------------------------------------------- #
 
      save(
        # information about dataset
          info,
          
        # datasets  
          dt_metabolomic,
       
        
        # path & name where workspace is saved as Rdata
        file = paste0(path_Rdata, file_output_rdata)
      
      )    
        
 
   
          