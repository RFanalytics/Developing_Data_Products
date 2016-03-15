
# User interface for calculating path loss +
# mobile throughput
#

library(shiny)

# Define UI for path loss 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("CellSpeed"),
  
  # Sidebar with controls to select the frequency
  sidebarPanel(
    h5("Mobile phone height fixed at 5 ft"),
    
    selectInput("users", "Total number of users on site", selected = 1,
                list(1,2,5,10,20,50,100,150,200)),
    
    selectInput("channel", "LTE Transmit Channel size (MHz)", selected = 5,
                list(1.4, 3, 5, 10, 15, 20)),
    
    selectInput("frequency", "Base Station Frequency (MHz)",
                list(735, 885, 1970, 2135)),
    
    sliderInput("tower", "Cell tower height (ft)",
                min = 20, max = 300, value = 100, step = 10),
    
    sliderInput("miles", "Mobile distance from tower (mi)",
                min = 0.1, max = 10.0, value = 1.0, step = 0.1),
    
    selectInput("power", "Transmitter Power (watts)", selected = 60,
                list(1, 5, 10, 20, 40, 60, 80, 100, 120)),
    h6("Please note transmitter power is a vendor setting, actual power is equally divided by number of transmit branches, 2 for this simulation"),
    
    selectInput("antenna", "Antenna Gain (dBi)", selected= 16,
                 list(16, 14, 10, 6, 3))

  ),
  
  mainPanel(
    
    tabsetPanel(type = "tabs",
                tabPanel("Introduction", h3("Welcome to the CellSpeed Simulation!"),
                         h4("This is a simulation tool to help wireless industry professionals, and other intrerested users, 
                            gain intuition regarding wireless network parameters on LTE (4G) system performance."),
                         h3("  "), h3("  "),
                         h4("Users of this tool can witness the impact of celluar design parameters by changing
                            the values on the left."),
                         h3("  "), h3("  "),
                         h4("Different screens can be monitored while making changes by selecting the tabs
                            across the top of this page."),
                         h3("  "), h3("  "),
                         h4("The target audience for this tool is:"),
                         h5("   * Owners of wireless spectrum"),
                         h5("   * Executives who manage staff that operate wireless networks"),
                         h5("   * Entry level engineers wanting to learning the business"),
                         h5("   * Marketing staff to develop an understanding of system limits and tradeoff on products"),
                         h5("   * Easy Customer Service tool to estimate customer experience"),
                         h5("   * Curious users"),
                         h3("  "), h3("  "), h3("  "), h3("  "),
                         h5("Some of these parameters can be measured personally using a publicly available
                            application for Android devices called 'LTE Discovery'.   
                            It must be installed and active on a LTE (4G) device under a service subscription"),
                         h3("  "), h3("  "),
                         h5("please contact   rfanalyticsbob@gmail.com   to report errors.")),
                tabPanel("Instructions", h3("Instructions:"),
                         h3("  "), h3("  "), h3("  "),
                         h5("This tools estimates loss of the radio signals using the Elgi propagation model.  
                            While this is not considered state of the art for radio prediction algorithms, it is
                            publicly available and reasonably represents what happens in a cellular radio environment. 
                            A more modern prediction algorithm would utilize a very accurate data base of the height of
                            terrain above sea level, accompanied with a clutter overlay - that maps objects on top of the
                            earth (trees, buildings).  This approach would use much computer processing resources to 
                            calculate how objects in the path between any location and the cell tower attenuate (reduce)
                            the radio signal reveived. This approach is beyond the scope of this tool.  This tool also
                            only represents a common operating mode called 2 x 2 MIMO, using two PDCCH. Wireless enviroments change rapidly and
                            could be represented as 'better' or 'worse' than results shown using this tool.  Speed meaurements for
                            a phone are represented from measurements made on a single device.  Minor variation in performance does
                            occur from device to device. "),
                         h3("  "), h3("  "), h3("  "),
                         h4("This tool is not intended to be accurate for any specific tower deployment, rather
                            to accurately demonstrate the affect of parameter change.  There are many more parameters in 
                            an operational wireless network that impact performance, but those listed here are 
                            major contributors and give good intuition on network design.  Users can change input values on the left by
                            making a selection in the drop down menus or 'click and hold' to pull the sliders."),
                         h3("  "), h3("  "),
                         h3("Total number of users on site:"), 
                         h5("This value effectively demonstrates that as more people use the cell tower, 
                            the available maximum speed any single user can experience is divided among other users."),
                         h3("  "), h3(" "),
                         h3("LTE Transmit Channel Size (MHz):"),
                         h5("There are six LTE channel sizes that can be deployed per the 3GPP specification.  
                            They are 1.4, 3, 5, 10, 15, and 20 MHz.  The size of the channel deployed is based on
                            the spectrum available (owned) for a given tower in a given market.  Larger channel sizes
                            allow faster download speeds, albeit at a slight penalty of a phone being a bit less sensitive.
                            This can be demonstrated by changing channel sizes for low signal levels (greater distance).
                            Even greater speeds can be obtained by carrier aggregatting (adding) multiple channels, but
                            that is outside the scope of this tool. "),
                         h3("  "), h3("  "),
                         h3("Base Station Frequency MHz):"),
                         h5("The base station frequency for a tower can have a significant impact on performance. 
                            For simplicity, dominant frequencies for the US market are demonstrated. 
                            735 represents a band termed 'The 700 band', 885 represents the first wireless band 
                            and is often refered to the 'Cellular' band, 1970 represents 'PCS' and 2135 'AWS'.  
                            More information on these frequency bands can be found by doing an internet search
                            on 'FCC auctions, bandplans'. "),
                         h3("  "), h3("  "),
                         h3("Cell tower height (ft):"),
                         h5("The height of the cell tower is an input to the Elgi propagation model, as well as the 
                            mobile receiver height (fixed at 5').  It is tempting to raise tower height
                            to improve signals - that does work!  What is not shown in this tool is that increasing 
                            tower height also causes interference to neighboring cell sites and it's users.  This is
                            a complex task managed by expert radio engineers at wireless companies.  Tower height is
                            a tradeoff between system coverage and capacity."),
                         h3("  "), h3("  "),
                         h3("Mobile distance from tower (mi):"),
                         h5("You can vary the simulated mobile distance from the tower, decreasing the received signal
                            (RSRP) the further you move away.  The 'Signal' tab most effectively demonstrates this in 
                            a graph but there is also an impact to download speed."),
                         h3("  "), h3("  "),
                         h3("Transmit Power (watts):"),
                         h5("This setting varies the transmitter power (per branch - or antenna) of the cell tower 
                            based on known base station vendor choices. The main impact is that the channel size dictates
                            the number of subcarriers (small individual signals).  The power chosen is equally divided
                            among subcarriers.  Large channel sizes have more subcarriers, so more power is required to
                            create the same received signal as a smaller channel size.  The base station transmits a 
                            Cell Reference Signal (CRS) and is received by the mobile and reported as Receive Signal
                            Reference Power (RSRP) in units of dBm. The unit dBm is 10*log10(watts/.001) - this is a
                            very small value and is used in a logrithmic scale to make using numbers manageable."),
                         h3("  "), h3("  "),
                         h3("Antenna Gain (dBi):"),
                         h5("The base station channels and directs radio energy in order to focus the use area and
                            to help prevent reception of nearby cells.  A main characterisitc of an antenna is its
                            gain (dBi).  Antenna gain is misunderstood as 'amplified', but is rather an increase
                            in 'focus', and is contributor to system performance.")),
                tabPanel("Download Speed", 
                         h3("Maximum Download Speed (Mbps)",
                         verbatimTextOutput("fastest"),
                         h3("Minimum Download Speed (Mbps)"),
                         verbatimTextOutput("slowest"),
                         h3(""),
                         h4("Actual experienced download speed will be between the maximum and minimum."),
                         h4("The tower makes changes to all users every .001 th of a second."),
                         h4("Other users, and their applications compete for and share the bandwidth."),
                         h4("Other users distance from tower and their application activity change every .001 th of a  second."),
                         h3("Try for yourself, changing cellular system design parameters"),
                         h4("Note how number of users on a tower and channel size have the most impact."),
                         h4("Adding additional users (and their consumption traits) is the main thing that 
                            prevents maximum speed (for given inputs)."))),
                tabPanel("Signal", plotOutput("graph")),
                tabPanel("Summary",
                         h3("Freqency (MHz)"),
                         verbatimTextOutput("frequency"),
                         h3("Tower Height (ft)"),
                         verbatimTextOutput("tower"),
                         h3("Path Loss (dB) - tower to mobile"),
                         verbatimTextOutput("pathloss"),
                         h3("Transmit power per subcarrier (dBm)"),
                         verbatimTextOutput("crs"),
                         h3("RSRP (dBm) - receive power measured by phone"),
                         verbatimTextOutput("rsrp"),
                         h3("Maximum speed (Mbps) - single user"),
                         verbatimTextOutput("maxspeed"),
                         h3("Minimum speed (Mbps) - multiple users"),
                         verbatimTextOutput("worstspeed"))
                
                )         
                
  )
  
))
