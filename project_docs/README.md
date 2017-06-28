# Parameter file information
EGPG uses information stored in the parameters file to choose the specific values that will be used for different processing steps.
For example filter values and epoching lengths a dictated by values stored in the Parameters file.
This document provides specific information about what each variable in the Parameters file represents.

The Parameters.m file contains a single variable called PARAMETERS which is a struct. This struct holds all relevant variables.

# Variables
**runICA** - This variable should be either a 0 or a 1 and tells the pipeline whether it should run ICA and apply automated methods for detecting and removing artifact components.
	0 = Don't use ICA
	1 = Use ICA

**horizThresh** - This variable is the value in microvolts which will be used to test for the presence of horizontal eye movements. Any epoch containing a failure of this criteria will be removed. By default this value is 32, which means the voltage difference between electrodes on the outer canthi of each eye must stay below 32 microvolts or the epoch is rejected.

**amp** - The EGI amp used for recording the data. The amp used changes the data in a number of ways which need to be accounted for.

## ERP
This is a struct variable which holds a number of values used during the preprocessing of the data which will be use to create ERPs.

**ERP.highpass** - This is the high pass filter value in Hz.

**ERP.lowpass** - This is the low pass filter value in Hz.

**ERP.epochMin** - The time in seconds that an epoch will begin, relative to the event trigger.

**ERP.epochMax** - The time in seconds that an epoch will begin, relative to the event trigger.

**ERP.downsampleRate** - The sampling rate in Hz that will be used for resampling at the beginning of the pipeline.

## ICA
This is a struct variable which holds a number of values used during the preprocessing of the data which will be used to run ICA and generate ICA components.

**ICA.highpass** - This is the high pass filter value in Hz.

**ICA.lowpass** - This is the low pass filter value in Hz.

**ICA.epochMin** - The time in seconds that an epoch will begin, relative to the event trigger.

**ICA.epochMax** - The time in seconds that an epoch will begin, relative to the event trigger.

**ICA.downsampleRate** - The sampling rate in Hz that will be used for resampling at the beginning of the pipeline.
