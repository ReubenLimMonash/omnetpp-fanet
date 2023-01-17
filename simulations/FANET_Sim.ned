package fanet.simulations;

//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
//

import inet.node.inet.AdhocHost;
import inet.node.aodv.AodvRouter;
import inet.node.wireless.AccessPoint;
import inet.node.inet.WirelessHost;
import inet.node.inet.ManetRouter;
import inet.routing.aodv.Aodv;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.physicallayer.wireless.apsk.packetlevel.ApskScalarRadioMedium;
import inet.physicallayer.wireless.common.contract.packetlevel.IRadioMedium;
import inet.node.inet.AdhocHost;
import inet.environment.common.PhysicalEnvironment;
import inet.visualizer.contract.IIntegratedVisualizer;
//import inet.visualizer.common.IntegratedMultiVisualizer;
//import inet.visualizer.canvas.integrated.IntegratedCanvasVisualizer;
//import inet.visualizer.common.IntegratedVisualizer;

module GatewayHost extends WirelessHost
{
    parameters:
        numWlanInterfaces = 2;
        wlan[0].mgmt.typename = "Ieee80211MgmtSta";
        wlan[0].agent.typename = "Ieee80211AgentSta";
        
        wlan[1].mgmt.typename = "Ieee80211MgmtAdhoc";
        wlan[1].agent.typename = "";
        forwarding = true;
    submodules:
        aodv: Aodv {
            @display("p=825,226");
        }
    connections:
        aodv.socketOut --> at.in++;
        aodv.socketIn <-- at.out++;
}

network fanet
{
    parameters:
        @display("bgb=1000,1000;bgg=100,1,grey95");
        @figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);

        int numHosts;
        int lastHostIndex;
        
    submodules:
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=100,50");
//        }
		visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=100,50");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=68,314");
        }
        gatewayNode: AodvRouter {
            @display("p=500,500;i=device/drone_s");
        }
        adhocNode[numHosts]: AodvRouter{
            @display("i=device/drone_s");
        }
        GCS: AodvRouter{
            @display("i=device/controller_s");
        }
//        baseStation: AccessPoint;
}

network OneScalarRadioMedium extends fanet
{
    submodules:
        radioMedium: Ieee80211ScalarRadioMedium;
}

network TwoScalarRadioMedium extends fanet
{
    submodules:
        radioMedium1: Ieee80211ScalarRadioMedium;
        radioMedium2: Ieee80211ScalarRadioMedium;
}

network ApskScalarRadioMedium extends fanet
{
    submodules:
        radioMedium: <default("ApskScalarRadioMedium")> like IRadioMedium;
        physicalEnvironment: PhysicalEnvironment {
            @display("p=100,350");
        }
}

network fanet_adhoc_hosts
{
    // Uses WirelessHost
 	parameters:
        @display("bgb=1000,1000;bgg=100,1,grey95");
        @figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);

        int numPackets;
        int numHosts;
        // int numRepeats;
        int uavRadius;
        int packetSize;
        int sendingRate;
        int swarmDistance = default(100);
        int swarmHeight = default(100);
        // double uavSpeed;
        double simulationTime = default(100.0);
        int gcsY;
        int travelDistance;
//        string csvFileName = default("/home/reuben/Documents");
    submodules:
        radioMedium: Ieee80211ScalarRadioMedium;
        
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=100,50");
        }
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=100,50");
//        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=68,314");
        }
        gatewayNode: AdhocHost {
            @display("p=500,500;i=device/drone_s");
        }
        adhocNode[numHosts]: AdhocHost{
            @display("i=device/drone_s");
        }
        GCS: AdhocHost{
            @display("i=device/controller_s");
        }
}

network fanet_adhoc_hosts_test
{
    // Uses WirelessHost
 	parameters:
        @display("bgb=1000,1000;bgg=100,1,grey95");
        @figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);

        int numPackets;
        int numHosts;
        // int numRepeats;
        int uavRadius;
        int packetSize;
        int sendingRate;
        int swarmDistance = default(100);
        int swarmHeight = default(100);
        // double uavSpeed;
        double simulationTime = default(100.0);
        int gcsY;
        int travelDistance;
//        string csvFileName = default("/home/reuben/Documents");
    submodules:
        radioMedium: Ieee80211ScalarRadioMedium;
        
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=100,50");
        }
//        visualizer: IntegratedMultiVisualizer {
//            @display("p=100,50");
//        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=68,314");
        }
        gatewayNode: AdhocHost {
            @display("p=500,500;i=device/drone_s");
        }
        adhocNode[numHosts]: AdhocHost{
            @display("i=device/drone_s");
        }
        GCS: AdhocHost{
            @display("i=device/controller_s");
        }
}