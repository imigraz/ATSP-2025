# -------------------------------------------------------------------- #
#  Advanced course in R
#    Dataset ’supraclavicular’
#
# 
#  input:   supraclavicular (.xlsx)
#  output:  supraclavicular_prepared (.Rdata)
#  purpose: add labels
#
#  remarks: - 
#  author:  YOUR NAME
#  status:  DATE
# -------------------------------------------------------------------- #

 # clear workspace
   rm(list=ls(all=TRUE))
  
 # general information about dataset version  
   date_received <- "20240304"
   date_prepared <- "20240305" 
  
 
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
 
   # none here
    
    
   
    
# --------------------------------------------------------------------------- #
#  INPUT ----
# --------------------------------------------------------------------------- #
  # ------------------------- #
  ##  file names input ----
  # ------------------------- #
   
    # name of data file in folder Rdata 
     file_input <- "supraclavicular_v20240304.xlsx"
        
    
    ### note ----
    # # nice way to find all files in a folder with a certain pattern:
    #   list.files(path = paste0(path_Rdata), 
    #              pattern = "supraclavicular_v") 
      
        
  # ------------------------- #
  ##  file names output ----
  # ------------------------- #  
    
   
    # create output name for dataset
      file_output_rdata <- paste0("supraclavicular_prepared_v", date_prepared, ".Rdata")
    
  
  
  
# --------------------------------------------------------------------------- #
#  INFORMATION GENERAL ----
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
   # save on 'dt_supraclavicular'   
    # hint: 
    #   - look at argument 'sheet'  
    #   - look at argument 'na' for problem in BMI
     
      
      
  
            
# --------------------------------------------------------------------------- #
#  DATA PREPARATION ----
# --------------------------------------------------------------------------- #
  # Hint: look how dataset struma was prepared
      
   # check class of all parameters in dataset
     
      
   # change data type and add labels to factors
      
      
      
      
      
      
      
      
      
      
      
      
      
  # check class of all parameters in dataset
  
      
   
      
# --------------------------------------------------------------------------- #
# Dictionary ----
# --------------------------------------------------------------------------- #
 # sometimes detailed dictionary is available
  
      # sometimes detailed dictionary is available
      
      dictionary <-
        tibble(parameter = names(dt_supraclavicular),
               parameter_label = c("Subject ID",
                                   "Anesthetic group",
                                   'Gender',
                                   'BMI',
                                   'Age [years]',
                                   'Fentanyl pain medication [μg]',
                                   'Alfentanil pain medication [mg]',
                                   'Midazolam pain medication [mg]',
                                   'Onset sensory [minutes]',
                                   'Onset first sensory [minutes]',
                                   'Onset motor [minutes]',
                                   'Nerve block censor',
                                   'Time btw onset of 4 nerve sensory block first request for an analgesic',
                                   'Medication (analgesic) within 48 hours',
                                   'Maximum postop verbal pain score (at rest)',
                                   'Maximum postop verbal pain score (with movement)',
                                   'Total opioid consumption [mg]'),
               parameter_info = c("Subject ID",
                                  "Anesthetic group",
                                  'Gender',
                                  'Body mass index',
                                  'Age [years]',
                                  'Fentanyl pain medication [μg]',
                                  'Alfentanil pain medication [mg]',
                                  'Midazolam pain medication [mg]',
                                  'Time to 4 nerve sensory block onset or if block failed the observed worst outcome of any patient (50)',
                                  'Time to first sensory block or if block failed an imputed value of 15',
                                  'Time to complete motor block or if block failed the observed worst outcome of any patient (50)',
                                  'Failed block, did not achieve complete sensory and motor block',
                                  'Time from the onset of 4 nerve sensory block until the first request for an analgesic',
                                  'Patients who did not take any analgesic medication were censored at 48 hours',
                                  'Maximum postop verbal pain score (at rest) [11-point Likert scale: 0 = no pain, 10 = maximum pain]',
                                  'Maximum postop verbal pain score (with movement) [11-point Likert scale: 0 = no pain, 10 = maximum pain]',
                                  'Total opioid consumption')
        )  
      
      info$dictionary <- dictionary     
        
# --------------------------------------------------------------------------- #
# SAVE ----
# --------------------------------------------------------------------------- #
        
      save(
        # information about dataset
          info,
          
        # datasets  
          dt_supraclavicular,
       
        
        # path & name where workspace is saved as Rdata
        file = paste0(path_Rdata, file_output_rdata)
      
      )    
        
 
   
          