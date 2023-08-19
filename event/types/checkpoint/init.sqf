/**
 * Event - Checkpoint Module
 *
 * Description: This module is responsible for handling the event
 * to create TK checkpoints.
 */

#define THIS_MODULE event_checkpoint
#include "x_macros.sqf"

// Add to the list of possible types of events
[GVAR(event_types), "Checkpoint"] call BIS_fnc_arrayPush;

// Set minimum number of events of this type to exist
GVAR(event_checkpoint_amount) = 3;

// Set composition of the event
GVAR(event_checkpoint_composition) = "CheckPoint1_US_EP1";

// Set possible positions to generate the event at
GVAR(event_checkpoint_positions) = [
    [[3207.33,5493.7,0.094986], -29.0612],
    [[3832.9,3692.81,0.0811157], 49.5425],
    [[4061.88,1570.37,0.0597534], -93.6687],
    [[4119.31,1756.84,0.121704], -91.8756],
    [[4176.15,1992.26,0.0479736], 235.684],
    [[4196.33,10110.6,0.00986481], 16.434],
    [[4239.7,9528.44,0.0835114], -107.238],
    [[4242.48,9595.83,-0.0774841], -108.327],
    [[4388.67,10279.4,-0.0955048], 214.95],
    [[5067.74,10701.8,0.00486755], 44.316],
    [[5481.22,800.591,0.0012207], 134.594],
    [[6789.89,6956.37,-0.0457916], 84.9018],
    [[6900.76,5003.2,-0.0237122], -3.36721],
    [[7274.12,9566.13,-0.131805], -99.5295],
    [[7284.54,8600.37,-0.179291], 33.624],
    [[7296.05,9653.92,-0.0129623], -91.1526],
    [[7358.89,8483.63,-0.0400238], 40.9153],
    [[7422.29,8354.05,-0.15036], 220.056],
    [[7485.26,5649.51,0.0271301], 172.153],
    [[7807.33,5061.14,-0.0386658], 142.287],
    [[7870.25,3579.72,0.0975037], 249.625],
    [[8036.79,5101.91,0.0507813], -9.6678],
    [[8649.41,10472.4,-0.0343475], 185.742],
    [[9000.47,4293.46,-0.0437622], 135.653],
    [[9168.14,9458.57,-0.116776], 226.797],
    [[9246.38,8587.57,0.0800476], 108.164],
    [[9251.59,9333.69,0.0114594], 36.4327],
    [[9585.53,10251,0.00112915], 111.846],
    [[9752.76,10704.5,0.0408783], 67.2088],
    [[9843.34,6465.59,-0.099823], 171.605]
];

__cppfln(FUNC(THIS_MODULE,create),event\types\checkpoint\functions\fn_create.sqf);

MODULE(THIS_MODULE) = true;