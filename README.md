# dssr2017-DTHenare

# Project Description

This software opens a set of netstation files and processes them using best practice procedures with minimal user input. The user will only need to define the event markers that will be epoched, AND navigate to the location of the first file. Each participant's data will be opened, converted to a .set file, filtered, broken channels interpolated, average referenced, epoched, artifact rejected, split into conditions and averaged for each condition. The software will output details about the results of various steps of the processing (number and identity of interpolated channels, number of epochs generated, number of epochs rejected for each condition as well as total, and number of components rejected), as well as summary statistics describing the outcome of the preprocessing steps.

# How to use

To run the pipeline you will need to create a folder which holds all of the netstation files which will be run through the pipeline. This will take the form of a single .RAW file or .set for each participant in the experiment which contains the EEG recording voltages as well as event markers denoting specific conditions and their time of presentation. All data will be stored in a single folder.

Next you will need to copy the triggerNames.txt file from the [pipelineFolder] into the folder which holds all of your data. Once it has copied, open the txt file and edit it so that it contains a list of the event names that you would like to be epoched.

Once this is set up, right click the run_EGPGPipeline.m file in the [pipelineFolder] and click run. Matlab will open and the file explorer will popup. Navigate to the first participant file and click 'open'. The software will now process all files in the folder and save each participant's output within a folder where the data is stored.

# Interpreting output

Output of the software will include:
- A matlab file containing a summary of the outcome of specific processing steps for all participants. This will provide details about; number of channels rejected, indices of channels rejected, number of epochs generated, total number of epochs rejected, number of epochs rejected per condition, number of epochs rejected by each test, number of components rejected)
- A .set file containing the cleaned and processed epochs for each condition.

# Contributing

Do not try to contribute to this, I don't need you or your dirty code.

# Installation

To install the software you can clone the repository to your local machine or download and unzip the files. Make sure you add both the pipeline folders and the data folders to your matlab path in order to run.

# Dependencies

MATLAB                                    http://www.mathworks.com/products/matlab.html
Statistics and Machine Learning toolbox   https://www.mathworks.com/products/statistics.html
EEGLAB toolbox                            https://sccn.ucsd.edu/eeglab/
ERPLAB plugin for EEGLAB                  http://www.erpinfo.org/erplab.html
ADJUST plugin for EEGLAB                  install through EEGLAB extensions manager
CleanLine plugin for EEGLAB               install through EEGLAB extensions manager

# Examples



# Example data
