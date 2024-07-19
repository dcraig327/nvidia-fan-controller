# nvidia-fan-controller
basic script to create a linear fan curve for nvidia gpu's and have it run at login

## Requirements
* Linux
* nVidia GPU
* nVidia nonfree drivers

## tl;dr
* Run the command below in `Step 3` and seek help elsewhere if you get an error
* Read the instructions below starting at `Step 6`


## Instructions

1) Run the following command to open the NVIDIA Settings GUI.
```
nvidia-settings
```
2) Under the Thermal Settings section for a GPU you should be able to click the Enable GPU Fan Settings button, move the fan speed sliders and apply the new speed. If the Apply button or checkbox is greyed out for you, that's beyond the scope of this project.
3) Find your acceptable max fan speed by running the command below and listening to your gpu. Then reduce the 100 value to test the acceptable max speed of your gpu's fans. This is where the fans running at x% sound identical to the fans running at 100%.
```
nvidia-settings -a "GPUFanControlState=1"; nvidia-settings -a "GPUTargetFanSpeed=100"
```
4) Find your acceptable min fan speed by repeating step 3 entering 0 as the fan speed and raising it until you hear the fans.
5) Edit the `nvidia-fan-controller.sh` file entering your min and max fan values from above. The defaults are my settings. delay is the amount of milliseconds added between updates.
6) Move `nvidia-fan-controller.sh` where you like. Some suggestions:
```
$HOME/.local/share/nvidia-fan-controller/nvidia-fan-controller.sh
$XDG_DATA_HOME/nvidia-fan-controller/nvidia-fan-controller.sh
```
7) Make `nvidia-fan-controller.sh` executable
```
chmod u+x nvidia-fan-controller.sh
```
8) Edit `nvidia-fan-controller.service` verifying ExecStart points to `nvidia-fan-controller.sh`, Move the file:
```
$HOME/.config/systemd/user/nvidia-fan-controller.service
```
9) Setup the user service
```
systemctl --user enable nvidia-fan-controller
systemctl --user start nvidia-fan-controller
watch systemctl --user status nvidia-fan-controller
systemctl --user stop nvidia-fan-controller
```