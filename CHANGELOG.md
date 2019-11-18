## 0.11.0 (November 18, 2019)

- Remove EEG spectral summary variables
- Remove empty head circumference variables (not collected)
- The CSV datasets generated from a SAS export are located here:
  - `\\rfawin\bwh-sleepepi-chat\nsrr-prep\_releases\0.11.0\`

## 0.10.0 (October 22, 2019)

- Swap out BMI z-score change variables (chg_bmiz for bmiz_change)
- Add `omai0p` to nonrandomized dataset
- Set key neurocognitive variables as commonly used
- Add Epworth scale total variables
- The CSV datasets generated from a SAS export are located here:
  - `\\rfawin\bwh-sleepepi-chat\nsrr-prep\_releases\0.10.0\`

## 0.9.1 (March 5, 2018)

- Update variable display names and units
- Update domain name from 'fm' to 'sex_2'
- Update folder names to include abbreviations

## 0.9.0 (February 12, 2018)

- Incorporate many new variable labels
- Spell out abbreviations and acronyms in variable display names
- Fix ICSD variable display names and calculations
- Remove redundant time in bed and sleep time variables
- The CSV datasets generated from a SAS export are located here:
  - `\\rfawin\bwh-sleepepi-chat\nsrr-prep\_releases\0.9.0\`

## 0.8.0 (April 3, 2017)

- Make all variable names lowercase in core CSV datasets
- Change name of subject identifier variable from 'obf_pptid' to 'nsrrid'
- Add ICSD AHI variables
- The CSV datasets generated from a SAS export are located here:
  - `\\rfawin\bwh-sleepepi-chat\nsrr-prep\_releases\0.8.0\`
- **Gem Changes**
  - Updated to spout 0.12.0

## 0.7.0 (January 19, 2017)

- Correct Thoraco-abdominal Asynchrony values based on EDF fixes
- Update HRV and EEG Spectral datasets based on EDF fixes
- Note: EDF fixes are detailed at https://www.sleepdata.org/datasets/chat/pages/polysomnography-introduction.md
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-chat\nsrr-prep\_releases\0.7.0\`

## 0.6.0 (November 11, 2016)

- Add Thoraco-Abdominal Asynchrony data calculated and submitted by an NSRR user
- Correct issue with HRV summary dataset from follow-up
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-chat\nsrr-prep\_releases\0.6.0\`
    - `chat-baseline-dataset-0.6.0.csv`
    - `chat-baseline-eeg-band-summary-0.6.0.csv`
    - `chat-baseline-eeg-spectral-summary-0.6.0.csv`
    - `chat-baseline-hrv-5min-0.6.0.csv`
    - `chat-baseline-hrv-summary-0.6.0.csv`
    - `chat-followup-dataset-0.6.0.csv`
    - `chat-followup-eeg-band-summary-0.6.0.csv`
    - `chat-followup-eeg-spectral-summary-0.6.0.csv`
    - `chat-followup-hrv-5min-0.6.0.csv`
    - `chat-followup-hrv-summary-0.6.0.csv`
    - `chat-nonrandomized-dataset-0.6.0.csv`
    - `chat-nonrandomized-eeg-band-summary-0.6.0.csv`
    - `chat-nonrandomized-eeg-spectral-summary-0.6.0.csv`

## 0.5.1 (August 11, 2016)

- Clean up variable display names
- Clarify meaning of `slh3c_ck` variable
- Fix issue with form linking for SLHQ variables

## 0.5.0 (July 21, 2016)

- Remove `income` variable (duplicate)
- Remove `siteid` variable (replaced by `clusterid`)
- Clarify income-related variable (`par5` and `par5_rc`) definitions
- Add `ref4` (race) to non-randomized subject dataset
- Include updated EEG spectral datasets, including nonrandomized
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-chat\nsrr-prep\_releases\0.5.0.rc\`
    - `chat-baseline-dataset-0.5.0.csv`
    - `chat-baseline-eeg-band-summary-0.5.0.csv`
    - `chat-baseline-eeg-spectral-summary-0.5.0.csv`
    - `chat-baseline-hrv-5min-0.5.0.csv`
    - `chat-baseline-hrv-summary-0.5.0.csv`
    - `chat-followup-dataset-0.5.0.csv`
    - `chat-followup-eeg-band-summary-0.5.0.csv`
    - `chat-followup-eeg-spectral-summary-0.5.0.csv`
    - `chat-followup-hrv-5min-0.5.0.csv`
    - `chat-followup-hrv-summary-0.5.0.csv`
    - `chat-nonrandomized-dataset-0.5.0.csv`
    - `chat-nonrandomized-eeg-band-summary-0.5.0.csv`
    - `chat-nonrandomized-eeg-spectral-summary-0.5.0.csv`

## 0.4.1 (January 19, 2016)

- Fixed naming convention of several forms
- **Gem Changes**
  - Updated to spout 0.11.0
  - Updated to Ruby 2.3.0

## 0.4.0 (December 17, 2015)

- Add EEG spectral analysis and HRV analysis datasets
- Add 'nonrandomized' dataset for subjects with screening PSG, but not randomized
- Update race3 categories to 1=White, 2=Black, 3=Other (matches other NSRR datasets)
- **Gem Changes**
  - Updated to spout 0.10.2
  - Updated to Ruby 2.2.3
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-chat\nsrr-prep\_releases\0.4.0\`
    - `chat-baseline-dataset-0.4.0.csv`
    - `chat-baseline-eeg-band-summary-0.4.0.csv`
    - `chat-baseline-eeg-spectral-summary-0.4.0.csv`
    - `chat-baseline-hrv-5min-0.4.0.csv`
    - `chat-baseline-hrv-summary-0.4.0.csv`
    - `chat-followup-dataset-0.4.0.csv`
    - `chat-followup-eeg-band-summary-0.4.0.csv`
    - `chat-followup-eeg-spectral-summary-0.4.0.csv`
    - `chat-followup-hrv-5min-0.4.0.csv`
    - `chat-followup-hrv-summary-0.4.0.csv`
    - `chat-nonrandomized-dataset-0.4.0.csv`

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
