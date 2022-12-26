# YakTUNE
## What's it do?
This program will open a tune saved in a .csv format which is simpler and easier to manage. It then converts that into a .PDTS file to be opened and loaded using the DSC Tuning Software.


## How to use
1. Change parameters in a properly formatted (yourtune).csv file.
2. Run the YakTUNE.exe program.
3. Navigate to and select (yourtune).csv to open.
4. Change the name and folder is desired and save as a .PDTS file
5. Open this newly created .PDTS file in DSC Tuning software.
6. **Confirm the values of the tables.** *Currently an error is shown for Velocity Table 2, but it appears this loads correctly. A message box is supplied with the values to confirm*
7. Edit the tune further, or write to the controller using DSC Tuning software.

## What do all the parameters mean
### Mode and Front/Rear
This is just the name of the mode and front or rear. It is important that these stay in order since it affects how the .pdts file is assembled.
### Comfort
Use this parameter to set the stiffness of the shock at the comfort rate. The scale is 0-100 and corresponds to a percentage of the stiffness of the shock from min to max. *This is not the same as the % used in DSC Tuning software*
### ZeroG
Use this parameter to set the stiffness of the shock at the center of the G Table. The scale is 0-100 and corresponds to a percentage of the stiffness of the shock from min to max. *This is not the same as the % used in DSC Tuning software*
### MaxG
Use this parameter to set the maximum stiffness of the shock at the edge of the G Table. The scale is 0-100 and corresponds to a percentage of the stiffness of the shock from min to max. *This is not the same as the % used in DSC Tuning software, and the shock calibration table produced by this program will exceed this value, this is not an error - it accounts for the velocity table as well*
### Comfort Sensitivity
Same as DSC Tuning software parameter
### Comfort G Rate Max
Same as DSC Tuning software parameter
### G Limit Threshold
Same as DSC Tuning software parameter. This is for the speed table.
### Speed Factor
Use this parameter to set the additonal damping at 150mph on the speed table. The program will auto fill from 0% at 60 mph to this value at 150 mph. *This is not the same as the % used in DSC Tuning software*
### Fast Compression | Med Compression |	Slow Compression |	Slow Rebound |	Med Rebound |	Fast Rebound
These are the +/- deltas for the velocity table. The scale is 0-100 and corresponds to a percentage of the stiffness of the shock from min to max. *This is not the same as the % used in DSC Tuning software*
### Curb Factor
This is a factor to change how aggressively damping is reduced on the inside wheel during turns. This factor determines the "shape" of the G table. The results are reasonable for 0-100, but higher numbers could be used.
### Brake Decay
Same as DSC Tuning software parameter
### Brake Threshold
Same as DSC Tuning software parameter
### Brake Min Speed
Same as DSC Tuning software parameter

## How to create your own "baseline" from an existing .PDTS tune

UNDER CONSTRUCTION

## How to change more advanced tables, or use on cars other than VW

UNDER CONSTRUCTION
*The program is written for the VW shocks with shock values of 240 mA full soft, to 2000 mA full stiff. Files are included that can be edited for other configurations however. This has not been tested so please post any issues if you find any.*

## How to install
1. Download an installer from the releases tab.
2. Open this file, and approve any security requests.
The installer and program were compiled using MATLAB>
