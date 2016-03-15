Welcome to the CellSpeed Simulation!
This is a simulation tool to help wireless industry professionals, and other intrerested users, gain intuition regarding wireless network parameters on LTE (4G) system performance.

Users of this tool can witness the impact of celluar design parameters by changing the values on the left.

Different screens can be monitored while making changes by selecting the tabs across the top of this page.

The target audience for this tool is:

* Owners of wireless spectrum

* Executives who manage staff that operate wireless networks

* Entry level engineers wanting to learning the business

* Marketing staff to develop an understanding of system limits and tradeoff on products

* Easy Customer Service tool to estimate customer experience

* Curious users

Some of these parameters can be measured personally using a publicly available application for Android devices called 'LTE Discovery'. It must be installed and active on a LTE (4G) device under a service subscription

please contact rfanalyticsbob@gmail.com to report errors.

Instructions:
This tools estimates loss of the radio signals using the Elgi propagation model. While this is not considered state of the art for radio prediction algorithms, it is publicly available and reasonably represents what happens in a cellular radio environment. A more modern prediction algorithm would utilize a very accurate data base of the height of terrain above sea level, accompanied with a clutter overlay - that maps objects on top of the earth (trees, buildings). This approach would use much computer processing resources to calculate how objects in the path between any location and the cell tower attenuate (reduce) the radio signal reveived. This approach is beyond the scope of this tool. This tool also only represents a common operating mode called 2 x 2 MIMO, using two PDCCH. Wireless enviroments change rapidly and could be represented as 'better' or 'worse' than results shown using this tool. Speed meaurements for a phone are represented from measurements made on a single device. Minor variation in performance does occur from device to device.

This tool is not intended to be accurate for any specific tower deployment, rather to accurately demonstrate the affect of parameter change. There are many more parameters in an operational wireless network that impact performance, but those listed here are major contributors and give good intuition on network design. Users can change input values on the left by making a selection in the drop down menus or 'click and hold' to pull the sliders.

Total number of users on site:
This value effectively demonstrates that as more people use the cell tower, the available maximum speed any single user can experience is divided among other users.

LTE Transmit Channel Size (MHz):
There are six LTE channel sizes that can be deployed per the 3GPP specification. They are 1.4, 3, 5, 10, 15, and 20 MHz. The size of the channel deployed is based on the spectrum available (owned) for a given tower in a given market. Larger channel sizes allow faster download speeds, albeit at a slight penalty of a phone being a bit less sensitive. This can be demonstrated by changing channel sizes for low signal levels (greater distance). Even greater speeds can be obtained by carrier aggregatting (adding) multiple channels, but that is outside the scope of this tool.

Base Station Frequency MHz):
The base station frequency for a tower can have a significant impact on performance. For simplicity, dominant frequencies for the US market are demonstrated. 735 represents a band termed 'The 700 band', 885 represents the first wireless band and is often refered to the 'Cellular' band, 1970 represents 'PCS' and 2135 'AWS'. More information on these frequency bands can be found by doing an internet search on 'FCC auctions, bandplans'.

Cell tower height (ft):
The height of the cell tower is an input to the Elgi propagation model, as well as the mobile receiver height (fixed at 5'). It is tempting to raise tower height to improve signals - that does work! What is not shown in this tool is that increasing tower height also causes interference to neighboring cell sites and it's users. This is a complex task managed by expert radio engineers at wireless companies. Tower height is a tradeoff between system coverage and capacity.

Mobile distance from tower (mi):
You can vary the simulated mobile distance from the tower, decreasing the received signal (RSRP) the further you move away. The 'Signal' tab most effectively demonstrates this in a graph but there is also an impact to download speed.

Transmit Power (watts):
This setting varies the transmitter power (per branch - or antenna) of the cell tower based on known base station vendor choices. The main impact is that the channel size dictates the number of subcarriers (small individual signals). The power chosen is equally divided among subcarriers. Large channel sizes have more subcarriers, so more power is required to create the same received signal as a smaller channel size. The base station transmits a Cell Reference Signal (CRS) and is received by the mobile and reported as Receive Signal Reference Power (RSRP) in units of dBm. The unit dBm is 10*log10(watts/.001) - this is a very small value and is used in a logrithmic scale to make using numbers manageable.

Antenna Gain (dBi):
The base station channels and directs radio energy in order to focus the use area and to help prevent reception of nearby cells. A main characterisitc of an antenna is its gain (dBi). Antenna gain is misunderstood as 'amplified', but is rather an increase in 'focus', and is contributor to system performance.
