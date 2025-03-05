# -------------------------------------------------------------------- #
#  Advanced course in R
#    Dataset ’struma’
#
# 
#  input:   struma.xlsx
#  output:  struma_prepared.Rdata
#  purpose: add labels
#
#  remarks: - 
#  author:  Sereina Herzog
#  status:  29.02.2024
# -------------------------------------------------------------------- #

 # clear workspace
   rm(list=ls(all=TRUE))
  
 # general information about dataset version  
   date_received <- "20240229"
   date_prepared <- "20250220" 
  
 
# ------------------------- #
#  PATHS ----
# ------------------------- #
  
  # paths relative to R project
   
    
    path_Rfiles <- "R/Rfiles/"
  
    path_Rdata <- "R/Rdata/"
    
      
# ------------------------- #
#  LIBRARIES ----
# ------------------------- #
  # if you have not yet installed these packages via Tools -> Install Packages...
    
    library(tidyverse)
    library(ggplot2)
    library(readxl)

 
# ------------------------- #
#  FUNCTIONS ----
# ------------------------- #
 
    roundM <- function(x, n = 0) {
      scale <- 10^n
      sign(x) * trunc(abs(x) * scale + 0.5) / scale
    } 
   
    
# --------------------------------------------------------------------------- #
#  INPUT ----
# --------------------------------------------------------------------------- #
  # ------------------------- #
  ##  file names input ----
  # ------------------------- #
   
    # name of data file in folder Rdata 
     file_input <- "struma_v20240229.xlsx"
        
    
    ### note ----
    # # nice way to find all files in a folder with a certain pattern:
    #   list.files(path = paste0(path_Rdata), 
    #              pattern = "struma_v") 
      
        
  # ------------------------- #
  ##  file names output ----
  # ------------------------- #  
    
   
    # create output name for dataset
      file_output_rdata <- paste0("struma_prepared_v", date_prepared, ".Rdata")
    
  
  
  
# --------------------------------------------------------------------------- #
#  GENERATE ----
# --------------------------------------------------------------------------- #

    # It is good habit to keep track on information regarding the data set we use
    
    info <- list()

  ## General information ----
    info_general <-
      tibble(Topic = c("Original data file",
                       "Date original data received",
                       
                       "Date prepared",
                       "File used for preparation",
                       "Current data file"
                       ),

             Name = c(file_input,
                      date_received,
                     
                      date_prepared,
                      str_split(string = rstudioapi::getSourceEditorContext()$path,
                                pattern = "/", simplify = TRUE) %>% as.character %>% last(),
                      file_output_rdata
                    )
      )

   
      info$general <- info_general


# --------------------------------------------------------------------------- #
#  DATA IMPORT ----
# --------------------------------------------------------------------------- #
      
      dt_struma <-
        readxl::read_xlsx(path = paste0(path_Rdata, file_input),
                          col_names = TRUE)

  
            
# --------------------------------------------------------------------------- #
#  DATA PREPARATION ----
# --------------------------------------------------------------------------- #
      
   # check class of all parameters in dataset
      str(dt_struma)
      
   # change data type and add labels to factors
      dt_struma <-  
        dt_struma %>% 
        
          # subject ID should be characters
            mutate(PatId = as.character(PatId)) %>% 
        
          # change all categorical parameters to factors and add labels
          mutate(gender = factor(gender, 
                                levels = c(1, 2),
                                labels = c("male", "female")),
                 bloodgrp = factor(bloodgrp, 
                                 levels = c(0, 1, 2, 3), 
                                 labels = c("0", "A", "B", "AB")),
                 smoking = factor(smoking,
                                  levels = c(0, 1),
                                  labels = c("non smoker",
                                             "smoker")),
                 MED = factor(MED,
                                     levels = c(0, 1),
                                     labels = c("no",
                                                "yes"))) 
        
        
      
    # check class of all parameters in dataset
      str(dt_struma)
      
    ### note ----  
      # # apply same factor levels to several parameter
      # mutate(across(c(par1_yn, par2_yn), ~ factor(.x,
      #                                             levels = c(0, 1),
      #                                             labels = c("no", "yes"))))
      
# --------------------------------------------------------------------------- #
# Dictionary ----
# --------------------------------------------------------------------------- #
 # sometimes detailed dictionary is available
  
   dictionary <-
      tibble(parameter = names(dt_struma),
             parameter_label = c('patient ID',
                                 'date of inclusion',
                                 'gender',
                                 'blood group',
                                 'smoking level',
                                 'systolic blood pressure [mmHg]',
                                 'weight [kg]',
                                 'weight after 1 year [kg]',
                                 'height [cm]',
                                 'abdominal grith [cm]',
                                 'hip size [cm]',
                                 'FT3',
                                 'FT4',
                                 'TSH',
                                 'age [years]',
                                 'medication'),
             parameter_info = c('',
                                '',
                                '',
                                '',
                                '',
                                '',
                                'weight after 1 year of therapy',
                                '',
                                '',
                                '',
                                'a hormone of the thyroid gland',
                                'a hormone of the thyroid gland',
                                'a hormone of the thyroid gland',
                                'age at inclusion',
                                '',
                                ''
                                )
             )  
      
  info$dictionary <- dictionary    
        
# --------------------------------------------------------------------------- #
# SAVE ----
# --------------------------------------------------------------------------- #
        
      save(
        # information about dataset
          info,
          
        # datasets  
          dt_struma,
       
        
        # path & name where workspace is saved as Rdata
        file = paste0(path_Rdata, file_output_rdata)
      
      )    
        
 
   
          