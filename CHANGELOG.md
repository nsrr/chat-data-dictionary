## 0.3.0 (September 4, 2014)

### Changes
- Removed extraneous variables (e.g. child_age, eligibility criteria)
- Add "Treatment Arm" to standard set of Spout graphs
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-chat\nsrr-prep\_releases\0.3.0\`
    - `chat-baseline-dataset-0.3.0.csv`
    - `chat-followup-dataset-0.3.0.csv`

## 0.2.0 (August 18, 2014)

### Changes
- Removed small set of subjects from dataset due to data being censored by CHAT investigators
- Clarified key variables like `male` and `ageyear_bin` with Data Coordinating Center
- Improved display names, descriptions, and labels for many variables
- Set commonly used flag to true for many variables
- Added `unittype` variable to distinguish type of PSG equipment used for data collection
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-chat\nsrr-prep\_releases\0.2.0\`
    - `chat-baseline-dataset-0.2.0.csv`
    - `chat-followup-dataset-0.2.0.csv`
- **Gem Changes**
  - Updated to spout 0.9.0.beta1

## 0.1.0 (July 1, 2014)

### Changes
- Created [KNOWNISSUES.md](https://github.com/sleepepi/chat-data-dictionary/blob/master/KNOWNISSUES.md) as a means to track problematic variables/values in dataset
- Reached 100% Spout coverage
- Fixed issue of Sleep and Health Questionnaire variables containing data from two different questions
- Linked variables to forms
- Added forms that match paper questionnaires
- The SAS export script now drops extraneous variables
- Initial import of the CHAT variables and domains
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-chat\nsrr-prep\_releases\0.1.0\`
    - `chat-baseline-dataset-0.1.0.csv`
    - `chat-followup-dataset-0.1.0.csv`
- **Gem Changes**
  - Use of Ruby 2.1.2 is now recommended
  - Updated to spout 0.8.0.rc3
