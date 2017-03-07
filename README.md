# EGPG Pipeline - An EEG processing general pipeline for simple ERP analysis

# Project Description

This software opens a set of EEG files and processes them with minimal user input. The user will only need to run the script, navigate to the location of the first file, and enter a small amount of information in dialog boxes at the start. Each participant's data will be opened, filtered, noisy channels interpolated, average referenced, epoched, artifact rejected, split into conditions and averaged for each condition. The software will output details about the results of various steps of the processing (number and identity of interpolated channels, number of epochs generated, number of epochs rejected for each condition as well as total, and number of components rejected), as well as a .set for each condition for each data file. It will also create a STUDY in eeglab which contains all participants and all conditions.

# Installation

To install the software you can clone the repository to your local machine or download and unzip the files. Make sure you add the pipeline folder (with subfolders) to your matlab path before you run.

# How to use

To run the pipeline you will need to create a folder which holds all of the EEG files which will be run through the pipeline. Currently these files must be either .RAW or .set files.

Once this is set up, right click the run_EGPGPipeline.m file in the EGPG_Pipeline folder and click run. Matlab will open and the file explorer will popup. Navigate to any one of the files in the folder and click 'open'. The software will now ask you to select the event labels that you would like to epoch around. It will then process all files in the folder and save each participant's output in an output folder which will be stored in the location of the input data.

# Interpreting output

Output of the software will include:
- A matlab file containing a summary of the outcome of specific processing steps for all participants. This will provide details about; number of channels rejected, indices of channels rejected, number of epochs generated, total number of epochs rejected, number of epochs rejected per condition, number of epochs rejected by each test, number of components rejected)
- A .set file containing the cleaned and processed epochs for each participant named "[filename]-cleaned.set".
- A .set file for each condition, for each participant named "[filename]-[triggername].set"
- A .study file which allows you to open all of the data in an eeglab STUDY for group analysis named Experiment-STUDY.study

# Contributing

If you would like to contribute to this project then send me an email (dhen061@aucklanduni.ac.nz) and let me know what you'd like to do.

# Dependencies

MATLAB                                    http://www.mathworks.com/products/matlab.html
Statistics and Machine Learning toolbox   https://www.mathworks.com/products/statistics.html
EEGLAB toolbox                            https://sccn.ucsd.edu/eeglab/
ERPLAB plugin for EEGLAB                  http://www.erpinfo.org/erplab.html
ADJUST plugin for EEGLAB                  install through EEGLAB extensions manager
CleanLine plugin for EEGLAB               install through EEGLAB extensions manager

# Examples



# Example data
