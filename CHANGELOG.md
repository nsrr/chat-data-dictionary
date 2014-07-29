## 0.2.0

### Changes



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
