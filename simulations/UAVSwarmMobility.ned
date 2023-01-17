package fanet.simulations;
//
// Copyright (C) 2006 Andras Varga
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//

//Date 30/4/2021
//Author Reuben
//Desc: Network to simulate various UAV swarm mobility models

import inet.environment.common.PhysicalEnvironment;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.AdhocHost;
import inet.physicallayer.wireless.common.contract.packetlevel.IRadioMedium;
import inet.physicallayer.wireless.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.canvas.integrated.IntegratedCanvasVisualizer;
import inet.visualizer.common.IntegratedMultiVisualizer;
import inet.visualizer.common.IntegratedVisualizer;

network UAV_Swarm_1
{
    parameters:
        @statistic[per](source=packetErrorRate(leaderUAVHost.wlan[0].radio.packetSentToUpper); record=figure; targetFigure=perPlot);
        @figure[perPlot](type=gauge; pos=100,300; size=50,50; minValue=0; maxValue=1; tickSize=0.1; label="Packet error rate");
        int numNodes = default(1);
    submodules:
        visualizer: IntegratedMultiVisualizer {
            parameters:
                @display("p=1000,1000");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,200");
        }
        //radioMedium: Ieee80211ScalarRadioMedium {
        radioMedium: <default("ApskScalarRadioMedium")> like IRadioMedium {
            parameters:
                @display("p=200,200");
        }
        GCSHost: AdhocHost {
            parameters:
                @display("p=300,500;i=device/controller_s");
        }
        leaderUAVHost: AdhocHost {
            parameters:
                @display("p=400,500;i=device/drone_s");
        }
//        AfollowerUAVHost: AdhocHost {
//            parameters:
//                @display("p=500,500;i=device/drone_s");
//        }
        BfollowerUAVHost: AdhocHost {
            parameters:
                @display("p=400,600;i=device/drone_s");
        }
        CfollowerUAVHost: AdhocHost {
            parameters:
                @display("p=400,400;i=device/drone_s");
        }
        physicalEnvironment: PhysicalEnvironment {
            @display("p=300,200");
        }
}
