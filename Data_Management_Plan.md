# Project Description

Create software that will open a netstation file and process it using best practice procedures with minimal user input. The user will only need to define the location of the files, the relevant event markers, and the time windows of interest. Each participant's data will be opened, converted to a .set file, filtered, broken channels interpolated, average referenced, epoched, artifact rejected, ICA cleaned, split into conditions and averaged for each condition. The software will output details about the results of various steps of the processing (number and identity of interpolated channels, number of epochs generated, number of epochs rejected for each condition as well as total, and number of components rejected), as well as publication quality figures (showing averaged ERPs for each condition, topographies at relevant time points, and eye channels), and a 3D matrix of data containing voltages representing participants x time x condition.

# Data Organisation

## Data input
### What data will be used?
The data will consist of one experiment's worth of EEG data. This will take the form of a single .RAW file for each participant in the experiment which contains the EEG recording voltages as well as event markers denoting specific conditions and their time of presentation. Each participant's data will be approximately 1.5GB and there will be 20 participants collected.

### File Management
All data will be stored in a single folder with a consistent naming scheme. The namning scheme will take the form 'Participant0000.RAW' where the value 0000 increments for each individual as they are run

## Data output
### What data will be produced?
Output of the software will include:
A cell array containing a labelled 3D matrix for each condition consisting of voltages that takes the structure [electrode x timepoint x participant]
