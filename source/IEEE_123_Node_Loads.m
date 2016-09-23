%Creates an IEEE 123-node system output
%Doesn't track voltages, so low-voltage portions will be inited to high
%voltage (solver should fix)

%Prepare workspace
clear all;
close all;
clc;

%Output file name
OutputFile='C:\Code\testing\IEEE_123_New.glm';

%Flag to include the fault_check object for debugging
IncludeFaultCheck=0;

%Nominal voltage values
NomVoltageSUBLLH=115000;
NomVoltageLLH=4160;
NomVoltageLLL=480;
NomVoltageLNSub=NomVoltageSUBLLH/sqrt(3);
NomVoltageLNH=NomVoltageLLH/sqrt(3);
NomVoltageLNL=NomVoltageLLL/sqrt(3);

DeltaBASE=[complex(cosd(30),sind(30));
           complex(cosd(-90),sind(-90));
           complex(cosd(150),sind(150))];

WyeBASE=[complex(cosd(0),sind(0));
         complex(cosd(-120),sind(-120));
         complex(cosd(120),sind(120))];

VoltageLNSub=NomVoltageLNSub*WyeBASE;
VoltageLLH=NomVoltageLLH*DeltaBASE;
VoltageLLL=NomVoltageLLL*DeltaBASE;
VoltageLNH=NomVoltageLNH*WyeBASE;
VoltageLNL=NomVoltageLNL*WyeBASE;

VoltageVals=[VoltageLLH VoltageLLL VoltageLNH VoltageLNL];

%Starting voltages - assumes balanced at the feeder
StartVoltages=VoltageLNH*1.00;

%Swing node designation
SWINGNode=150;
%SWINGNode=9999;	%Substation transformer, but doesn't work right

%Spot Loads Table
%0 = YPQ, 1 = YI, 2 = YZ, 3=DPQ, 4=DI, 5=DZ
SpotLoadsRAW=[	0	40	20	0	0	0	0
				0	0	0	20	10	0	0
				0	0	0	0	0	40	20
				1	0	0	0	0	20	10
				2	0	0	0	0	40	20
				0	20	10	0	0	0	0
				0	40	20	0	0	0	0
				1	20	10	0	0	0	0
				2	40	20	0	0	0	0
				0	0	0	20	10	0	0
				0	0	0	0	0	40	20
				0	0	0	0	0	20	10
				0	40	20	0	0	0	0
				1	40	20	0	0	0	0
				2	0	0	40	20	0	0
				0	0	0	0	0	40	20
				1	40	20	0	0	0	0
				2	40	20	0	0	0	0
				0	0	0	0	0	40	20
				0	0	0	0	0	20	10
				0	0	0	0	0	20	10
				1	40	20	0	0	0	0
				2	0	0	0	0	40	20
				3	40	20	0	0	0	0
				2	40	20	0	0	0	0
				1	0	0	20	10	0	0
				0	0	0	20	10	0	0
				0	0	0	0	0	20	10
				0	20	10	0	0	0	0
				2	0	0	40	20	0	0
				1	20	10	0	0	0	0
				0	20	10	0	0	0	0
				1	35	25	35	25	35	25
				2	70	50	70	50	70	50
				0	35	25	70	50	35	20
				0	0	0	0	0	40	20
				0	20	10	0	0	0	0
				0	40	20	0	0	0	0
				0	40	20	0	0	0	0
				2	20	10	0	0	0	0
				0	0	0	20	10	0	0
				1	0	0	20	10	0	0
				0	0	0	20	10	0	0
				0	20	10	0	0	0	0
				2	0	0	0	0	40	20
				0	40	20	0	0	0	0
				1	0	0	75	35	0	0
				5	35	25	35	25	70	50
				0	0	0	0	0	75	35
				0	20	10	0	0	0	0
				0	40	20	0	0	0	0
				0	20	10	0	0	0	0
				0	40	20	0	0	0	0
				0	0	0	0	0	40	20
				2	0	0	0	0	40	20
				0	0	0	0	0	40	20
				4	105	80	70	50	70	50
				0	0	0	40	20	0	0
				2	40	20	0	0	0	0
				0	0	0	40	20	0	0
				0	40	20	0	0	0	0
				0	0	0	0	0	20	10
				0	0	0	0	0	20	10
				0	0	0	0	0	40	20
				0	0	0	20	10	0	0
				0	0	0	40	20	0	0
				0	40	20	0	0	0	0
				1	0	0	40	20	0	0
				0	0	0	0	0	40	20
				0	40	20	0	0	0	0
				0	0	0	20	10	0	0
				0	0	0	20	10	0	0
				0	40	20	0	0	0	0
				0	0	0	40	20	0	0
				2	0	0	0	0	40	20
				0	0	0	0	0	20	10
				0	0	0	0	0	40	20
				0	0	0	0	0	40	20
				0	0	0	40	20	0	0
				0	0	0	40	20	0	0
				0	40	20	0	0	0	0
				0	20	10	0	0	0	0
				1	20	10	0	0	0	0
				2	40	20	0	0	0	0
				0	20	10	0	0	0	0
                ];

%Spot loads location [Bus VLevel]
SpotLoadsLoc=[  1	3;
				2	3;
				4	3;
				5	3;
				6	3;
				7	3;
				9	3;
				10	3;
				11	3;
				12	3;
				16	3;
				17	3;
				19	3;
				20	3;
				22	3;
				24	3;
				28	3;
				29	3;
				30	3;
				31	3;
				32	3;
				33	3;
				34	3;
				35	1;
				37	3;
				38	3;
				39	3;
				41	3;
				42	3;
				43	3;
				45	3;
				46	3;
				47	3;
				48	3;
				49	3;
				50	3;
				51	3;
				52	3;
				53	3;
				55	3;
				56	3;
				58	3;
				59	3;
				60	3;
				62	3;
				63	3;
				64	3;
				65	1;
				66	3;
				68	3;
				69	3;
				70	3;
				71	3;
				73	3;
				74	3;
				75	3;
				76	1;
				77	3;
				79	3;
				80	3;
				82	3;
				83	3;
				84	3;
				85	3;
				86	3;
				87	3;
				88	3;
				90	3;
				92	3;
				94	3;
				95	3;
				96	3;
				98	3;
				99	3;
				100	3;
				102	3;
				103	3;
				104	3;
				106	3;
				107	3;
				109	3;
				111	3;
				112	3;
				113	3;
				114	3;
                ];
            
%Distributed loads
%0 = YPQ, 1 = YI, 2 = YZ, 3=DPQ, 4=DI, 5=DZ
DistLoadsRAW=[];

%Line Lengths for dist - F T Dist Vlevel
LineLengths=[];
            
%Define all lines - F T Dist Config
AllLines=[      1	2	175	310;
				1	3	250	311;
				1	7	300	301;
				3	4	200	311;
				3	5	325	311;
				5	6	250	311;
				7	8	200	301;
				8	12	225	310;
				8	9	225	309;
				8	13	300	301;
				901	14	425	309;
				13	34	150	311;
				13	18	825	302;
				14	11	250	309;
				14	10	250	309;
				15	16	375	311;
				15	17	350	311;
				18	19	250	309;
				18	21	300	302;
				19	20	325	309;
				21	22	525	310;
				21	23	250	302;
				23	24	550	311;
				23	25	275	302;
				2501	26	350	307;
				25	28	200	302;
				26	27	275	307;
				26	31	225	311;
				27	33	500	309;
				28	29	300	302;
				29	30	350	302;
				30	250	200	302;
				31	32	300	311;
				34	15	100	311;
				35	36	650	308;
				35	40	250	301;
				36	37	300	309;
				36	38	250	310;
				38	39	325	310;
				40	41	325	311;
				40	42	250	301;
				42	43	500	310;
				42	44	200	301;
				44	45	200	309;
				44	47	250	301;
				45	46	300	309;
				47	48	150	304;
				47	49	250	304;
				49	50	250	304;
				50	51	250	304;
				51	151	500	304;
				52	53	200	301;
				53	54	125	301;
				54	55	275	301;
				54	57	350	303;
				55	56	275	301;
				57	58	250	310;
				57	60	750	303;
				58	59	250	310;
				60	61	550	305;
				60	62	250	312;
				62	63	175	312;
				63	64	350	312;
				64	65	425	312;
				65	66	325	312;
				67	68	200	309;
				67	72	275	303;
				67	97	250	303;
				68	69	275	309;
				69	70	325	309;
				70	71	275	309;
				72	73	275	311;
				72	76	200	303;
				73	74	350	311;
				74	75	400	311;
				76	77	400	306;
				76	86	700	303;
				77	78	100	306;
				78	79	225	306;
				78	80	475	306;
				80	81	475	306;
				81	82	250	306;
				81	84	675	311;
				82	83	250	306;
				84	85	475	311;
				86	87	450	306;
				87	88	175	309;
				87	89	275	306;
				89	90	225	310;
				89	91	225	306;
				91	92	300	311;
				91	93	225	306;
				93	94	275	309;
				93	95	300	306;
				95	96	200	310;
				97	98	275	303;
				98	99	550	303;
				99	100	300	303;
				100	450	800	303;
				101	102	225	311;
				101	105	275	303;
				102	103	325	311;
				103	104	700	311;
				105	106	225	310;
				105	108	325	303;
				106	107	575	310;
				108	109	450	309;
				108	300	1000	303;
				109	110	300	309;
				110	111	575	309;
				110	112	125	309;
				112	113	525	309;
				113	114	325	309;
				135	35	375	304;
				149	1	400	301;
				152	52	400	301;
				16001	67	350	306;
				197	101	250	303;
                ];

%Line configuration phase info - # ABC o/u
%Also includes regulator configs
LineConfigInformation=[301  1 1 1 0;
                       302  1 1 1 0;
                       303  1 1 1 0;
                       304  1 1 1 0;
					   305  1 1 1 0;
					   306  1 1 1 0;
					   307  1 0 1 0;
					   308  1 1 0 0;
					   309  1 0 0 0;
					   310  0 1 0 0;
					   311  0 0 1 0;
					   312  1 1 1 1;
                       501  1 1 1 0;
                       502  1 0 0 0;
                       503  1 0 1 0;
                       504  1 1 1 0];
            
%Transformer information - F T Config
TransformerInfo=[6101 610 500];
%				 9999 150 9999]; %Substation transformer

%Regulator information - F T Config
RegulatorInfo=[150 15001 501;
               9   901   502;
			   25  2501  503;
			   160 16001  504;
               ];
           
%Switch information - F T O/C
SwitchInfo=[13	152	1;
			18	135	1;
			60	160	1;
			61	6101	1;
			97	197	1;
			15001	149	1;
% 			250	251	0;
% 			450	451	0;
% 			54	94	0;
% 			151	300	0;
% 			300	350	0;
            ];
           
%Capacitor information (kvar) - Node A B C Vlevel
CapacitorInfo=[83 200 200 200 3;
               88 50  0   0   3;
			   90 0   50  0   3;
			   92 0   0   50  3];

%Convert SPOT Loads to base types
SpotLoadsCONV=zeros(size(SpotLoadsRAW,1),4);

%0 = YPQ, 1 = YI, 2 = YZ, 3=DPQ, 4=DI, 5=DZ
for lVals=1:size(SpotLoadsRAW,1)
    if (SpotLoadsRAW(lVals,1)==0)   %YPQ
        IntermedValue = reshape(SpotLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues = complex(IntermedValue(:,1),IntermedValue(:,2)).';
    elseif (SpotLoadsRAW(lVals,1)==1)   %YI
        IntermedValue=reshape(SpotLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj(complex(IntermedValue(:,1),IntermedValue(:,2))./VoltageVals(:,SpotLoadsLoc(lVals,2))).';
    elseif (SpotLoadsRAW(lVals,1)==2)   %YZ
        IntermedValue=reshape(SpotLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj((abs(VoltageVals(:,SpotLoadsLoc(lVals,2))).^2)./complex(IntermedValue(:,1),IntermedValue(:,2))).';
    elseif (SpotLoadsRAW(lVals,1)==3)   %DPQ
        IntermedValue = reshape(SpotLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues = complex(IntermedValue(:,1),IntermedValue(:,2)).';
    elseif (SpotLoadsRAW(lVals,1)==4)   %DI
        IntermedValue=reshape(SpotLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj(complex(IntermedValue(:,1),IntermedValue(:,2))./VoltageVals(:,SpotLoadsLoc(lVals,2))).';
    else %DZ, by default
        IntermedValue=reshape(SpotLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj((abs(VoltageVals(:,SpotLoadsLoc(lVals,2))).^2)./complex(IntermedValue(:,1),IntermedValue(:,2))).';
    end
    
    SpotLoadsCONV(lVals,:) = [SpotLoadsRAW(lVals,1) RawPowerValues];
end

%Convert distributed loads
DistLoadsCONV=zeros(size(DistLoadsRAW,1),4);
DistLoadsCONVOneThird=zeros(size(DistLoadsRAW,1),4);
DistLoadsCONVTwoThird=zeros(size(DistLoadsRAW,1),4);

%0 = YPQ, 1 = YI, 2 = YZ, 3=DPQ, 4=DI, 5=DZ
for lVals=1:size(DistLoadsRAW,1)
    if (DistLoadsRAW(lVals,1)==0)   %YPQ
        IntermedValue = reshape(DistLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues = complex(IntermedValue(:,1),IntermedValue(:,2)).';
        RawPowerValuesThird = RawPowerValues/3.0;
        RawPowerValuesTwoThird = RawPowerValuesThird*2.0;
    elseif (DistLoadsRAW(lVals,1)==1)   %YI
        IntermedValue=reshape(DistLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj(complex(IntermedValue(:,1),IntermedValue(:,2))./VoltageVals(:,LineLengths(lVals,4))).';
        RawPowerValuesThird = RawPowerValues/3.0;
        RawPowerValuesTwoThird = RawPowerValuesThird*2.0;
    elseif (DistLoadsRAW(lVals,1)==2)   %YZ
        IntermedValue=reshape(DistLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj((abs(VoltageVals(:,LineLengths(lVals,4))).^2)./complex(IntermedValue(:,1),IntermedValue(:,2))).';
        RawPowerValuesThird=conj((abs(VoltageVals(:,LineLengths(lVals,4))).^2)./(complex(IntermedValue(:,1),IntermedValue(:,2))/3)).';
        RawPowerValuesTwoThird=conj((abs(VoltageVals(:,LineLengths(lVals,4))).^2)./(complex(IntermedValue(:,1),IntermedValue(:,2))/3*2)).';
    elseif (DistLoadsRAW(lVals,1)==3)   %DPQ
        IntermedValue = reshape(DistLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues = complex(IntermedValue(:,1),IntermedValue(:,2)).';
        RawPowerValuesThird = RawPowerValues/3.0;
        RawPowerValuesTwoThird = RawPowerValuesThird*2.0;
    elseif (DistLoadsRAW(lVals,1)==4)   %DI
        IntermedValue=reshape(DistLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj(complex(IntermedValue(:,1),IntermedValue(:,2))./VoltageVals(:,LineLengths(lVals,4))).';
        RawPowerValuesThird = RawPowerValues/3.0;
        RawPowerValuesTwoThird = RawPowerValuesThird*2.0;
    else %DZ, by default
        IntermedValue=reshape(DistLoadsRAW(lVals,2:7),2,3).'*1000;
        RawPowerValues=conj((abs(VoltageVals(:,LineLengths(lVals,4))).^2)./complex(IntermedValue(:,1),IntermedValue(:,2))).';
        RawPowerValuesThird=conj((abs(VoltageVals(:,LineLengths(lVals,4))).^2)./(complex(IntermedValue(:,1),IntermedValue(:,2))/3)).';
        RawPowerValuesTwoThird=conj((abs(VoltageVals(:,LineLengths(lVals,4))).^2)./(complex(IntermedValue(:,1),IntermedValue(:,2))/3*2)).';
    end
    
    DistLoadsCONV(lVals,:) = [DistLoadsRAW(lVals,1) RawPowerValues];
    DistLoadsCONVOneThird(lVals,:) = [DistLoadsRAW(lVals,1) RawPowerValuesThird];
    DistLoadsCONVTwoThird(lVals,:) = [DistLoadsRAW(lVals,1) RawPowerValuesTwoThird];
end

%Convert out the infinite loads
SpotInfVals=isinf(real(SpotLoadsCONV));
DistInfVals=isinf(real(DistLoadsCONV));
DistThirdInfVals=isinf(real(DistLoadsCONVOneThird));
DistTwoThirdInfVals=isinf(real(DistLoadsCONVTwoThird));

SpotLoadsCONV(SpotInfVals)=0.0;
DistLoadsCONV(DistInfVals)=0.0;
DistLoadsCONVOneThird(DistThirdInfVals)=0.0;
DistLoadsCONVTwoThird(DistTwoThirdInfVals)=0.0;

%% Base information generation script

%Figure out the unique node list - MATLAB will be angry, but tough
UniqueNodeIndexList=[];
if (~isempty(AllLines))
    UniqueNodeIndexList=[UniqueNodeIndexList; AllLines(:,1); AllLines(:,2)];
end
if (~isempty(TransformerInfo))
    UniqueNodeIndexList=[UniqueNodeIndexList; TransformerInfo(:,1); TransformerInfo(:,2)];
end
if (~isempty(RegulatorInfo))
    UniqueNodeIndexList=[UniqueNodeIndexList; RegulatorInfo(:,1); RegulatorInfo(:,2)];
end
if (~isempty(SwitchInfo))
    UniqueNodeIndexList=[UniqueNodeIndexList; SwitchInfo(:,1); SwitchInfo(:,2)];
end
UniqueNodes=unique(UniqueNodeIndexList);

%Find out how many there are
NumUniqueNodes=length(UniqueNodes);
NumSpotLoads=size(SpotLoadsLoc,1);
NumDistLoads=size(LineLengths,1);
NumLines=size(AllLines,1);
NumTransformers=size(TransformerInfo,1);
NumRegulators=size(RegulatorInfo,1);
NumSwitches=size(SwitchInfo,1);
NumCapacitors=size(CapacitorInfo,1);

%Now search the lists and find the phases of each of these
UniqueNodesPhases=zeros(NumUniqueNodes,3);
UniqueNodesType=zeros(NumUniqueNodes,2);

%Loop through them
for nvals=1:NumUniqueNodes
    
    %Loop through the lines
    for lvals=1:NumLines
        if ((AllLines(lvals,1) == UniqueNodes(nvals)) || (AllLines(lvals,2) == UniqueNodes(nvals)))
            %Figure out which line configuration it is
            Idx=find(LineConfigInformation(:,1) == AllLines(lvals,4),1);
            UniqueNodesPhases(nvals,:) = UniqueNodesPhases(nvals,:) | LineConfigInformation(Idx,(2:4));
        end
    end
    
    %Do the same for transformers - assume three-phase
    for lvals=1:NumTransformers
        if ((TransformerInfo(lvals,1) == UniqueNodes(nvals)) || (TransformerInfo(lvals,2) == UniqueNodes(nvals)))
            UniqueNodesPhases(nvals,:) = [1 1 1];
        end
    end
    
    %And regulators the same way - again assume three-phase
    for lvals=1:NumRegulators
        if ((RegulatorInfo(lvals,1) == UniqueNodes(nvals)) || (RegulatorInfo(lvals,2) == UniqueNodes(nvals)))
            %Figure out which line configuration it is
            Idx=find(LineConfigInformation(:,1) == RegulatorInfo(lvals,3),1);
            UniqueNodesPhases(nvals,:) = UniqueNodesPhases(nvals,:) | LineConfigInformation(Idx,(2:4));
        end
    end
    
    %Switches are considered three phase too, treat them the same
    for lvals=1:NumSwitches
        if ((SwitchInfo(lvals,1) == UniqueNodes(nvals)) || (SwitchInfo(lvals,2) == UniqueNodes(nvals)))
            UniqueNodesPhases(nvals,:) = [1 1 1];
        end
    end
    
    %While we're in here, check if we're a load or not
    %Loop through distributed loads
    for lvals=1:NumDistLoads
        if (LineLengths(lvals,2) == UniqueNodes(nvals))
            UniqueNodesType(nvals,1)=1;
        end
    end
    
    %Loop through spot loads
    for lvals=1:NumSpotLoads
        if (SpotLoadsLoc(lvals,1) == UniqueNodes(nvals))
            UniqueNodesType(nvals,2)=1;
        end
    end
end%End Unique Nodes

%Loop through lines and figure out which ones are "unique" as well (not
%distributed loads)
OutputLines=ones(NumLines,1);

for lvals=1:NumLines
    
    %Loop through distributed loads
    for dvals=1:NumDistLoads
        %See if this line is a distributed load
        if (((AllLines(lvals,1) == LineLengths(dvals,1)) && (AllLines(lvals,2) == LineLengths(dvals,2))) || ...
            ((AllLines(lvals,2) == LineLengths(dvals,1)) && (AllLines(lvals,1) == LineLengths(dvals,2))))
            OutputLines(lvals)=0;
        end
    end
end


%% Create the output GLM-esque file

%Open the file
fHandle=fopen(OutputFile,'wt');

%Generic top matter stuff
fprintf(fHandle,'//123-node generated by script\n\n');
fprintf(fHandle,'#set pauseatexit=1\n');
fprintf(fHandle,'#set profiler=1\n\n');
fprintf(fHandle,'clock {\n');
fprintf(fHandle,'\ttimezone EST+5EDT;\n');
fprintf(fHandle,'\ttimestamp ''2001-01-01 0:00:00'';\n');
fprintf(fHandle,'}\n\n');
fprintf(fHandle,'module powerflow {\n');
fprintf(fHandle,'\tsolver_method NR;\n');
fprintf(fHandle,'\tline_capacitance true;\n');
fprintf(fHandle,'}\n\n');
fprintf(fHandle,'//include configurations\n');
fprintf(fHandle,'#include "configurations_123node.glm";\n\n');
fprintf(fHandle,'object voltdump {\n');
fprintf(fHandle,'\tfilename voltageout.csv;\n');
fprintf(fHandle,'\tgroup "nodevolts";\n');
fprintf(fHandle,'\tmode polar;\n');
fprintf(fHandle,'}\n\n');
fprintf(fHandle,'object currdump {\n');
fprintf(fHandle,'\tfilename currentout.csv;\n');
fprintf(fHandle,'\tmode rect;\n');
fprintf(fHandle,'}\n\n');

%See if the fault_check object is desired
if (IncludeFaultCheck==1)
    fprintf(fHandle,'object fault_check {\n');
    fprintf(fHandle,'\tname test_fault;\n');
    fprintf(fHandle,'\tcheck_mode ONCHANGE;\n');
    fprintf(fHandle,'\toutput_filename unsupported_nodes.txt;\n');
    fprintf(fHandle,'};\n\n');
end

fprintf(fHandle,'//Pure nodes\n\n');

%Start by writing pure nodes
for nvals=1:NumUniqueNodes
    
    %Make sure we aren't a load
    if ((UniqueNodesType(nvals,1)~=1) && (UniqueNodesType(nvals,2)~=1))
        fprintf(fHandle,'object node {\n');
        fprintf(fHandle,'\tname node_%s;\n',num2str(UniqueNodes(nvals)));
        fprintf(fHandle,'\tgroupid nodevolts;\n');
        fprintf(fHandle,'\tphases ');
        if (UniqueNodesPhases(nvals,1)==1)
            fprintf(fHandle,'A');
        end
        if (UniqueNodesPhases(nvals,2)==1)
            fprintf(fHandle,'B');
        end
        if (UniqueNodesPhases(nvals,3)==1)
            fprintf(fHandle,'C');
        end
        fprintf(fHandle,'N;\n');
        fprintf(fHandle,'\tnominal_voltage %.4f;\n',NomVoltageLNH);
        if (UniqueNodes(nvals)==SWINGNode)
            fprintf(fHandle,'\tbustype SWING;\n');
            fprintf(fHandle,'\tvoltage_A %f%+fj;\n',real(StartVoltages(1)),imag(StartVoltages(1)));
            fprintf(fHandle,'\tvoltage_B %f%+fj;\n',real(StartVoltages(2)),imag(StartVoltages(2)));
            fprintf(fHandle,'\tvoltage_C %f%+fj;\n',real(StartVoltages(3)),imag(StartVoltages(3)));
        end
        fprintf(fHandle,'}\n\n');
    end
end

fprintf(fHandle,'//Pure spot loads\n\n');

%Now write out pure loads
for nvals=1:NumUniqueNodes
    
    %Make sure we're just a spot load
    if ((UniqueNodesType(nvals,1)~=1) && (UniqueNodesType(nvals,2)==1))
        
        %Find our index in the load category
        Idx=find(SpotLoadsLoc(:,1)==UniqueNodes(nvals),1);

        %Output it
        fprintf(fHandle,'object load {\n');
        fprintf(fHandle,'\tname load_%s;\n',num2str(UniqueNodes(nvals)));
        fprintf(fHandle,'\tgroupid nodevolts;\n');
        fprintf(fHandle,'\tphases ');
        if (UniqueNodesPhases(nvals,1)==1)
            fprintf(fHandle,'A');
        end
        if (UniqueNodesPhases(nvals,2)==1)
            fprintf(fHandle,'B');
        end
        if (UniqueNodesPhases(nvals,3)==1)
            fprintf(fHandle,'C');
        end
        if (SpotLoadsCONV(Idx,1)>=3) %Wdelta
            fprintf(fHandle,'D;\n');
        else %Wye
            fprintf(fHandle,'N;\n');
        end
        
        %Check load types
        if ((SpotLoadsCONV(Idx,1)==0) || (SpotLoadsCONV(Idx,1)==3)) %PQ
            if (SpotLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_power_A %f%+fj;\n',real(SpotLoadsCONV(Idx,2)),imag(SpotLoadsCONV(Idx,2)));
            end
            if (SpotLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_power_B %f%+fj;\n',real(SpotLoadsCONV(Idx,3)),imag(SpotLoadsCONV(Idx,3)));
            end
            if (SpotLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_power_C %f%+fj;\n',real(SpotLoadsCONV(Idx,4)),imag(SpotLoadsCONV(Idx,4)));
            end
        elseif ((SpotLoadsCONV(Idx,1)==1) || (SpotLoadsCONV(Idx,1)==4)) %I
            if (SpotLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_current_A %f%+fj;\n',real(SpotLoadsCONV(Idx,2)),imag(SpotLoadsCONV(Idx,2)));
            end
            if (SpotLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_current_B %f%+fj;\n',real(SpotLoadsCONV(Idx,3)),imag(SpotLoadsCONV(Idx,3)));
            end
            if (SpotLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_current_C %f%+fj;\n',real(SpotLoadsCONV(Idx,4)),imag(SpotLoadsCONV(Idx,4)));
            end
        else %Must be impedance
            if (SpotLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_impedance_A %f%+fj;\n',real(SpotLoadsCONV(Idx,2)),imag(SpotLoadsCONV(Idx,2)));
            end
            if (SpotLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_impedance_B %f%+fj;\n',real(SpotLoadsCONV(Idx,3)),imag(SpotLoadsCONV(Idx,3)));
            end
            if (SpotLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_impedance_C %f%+fj;\n',real(SpotLoadsCONV(Idx,4)),imag(SpotLoadsCONV(Idx,4)));
            end
        end
        
        fprintf(fHandle,'\tnominal_voltage %.4f;\n',NomVoltageLNH);
        if (UniqueNodes(nvals)==SWINGNode)
            fprintf(fHandle,'\tbustype SWING;\n');
            fprintf(fHandle,'\tvoltage_A %f%+fj;\n',real(StartVoltages(1)),imag(StartVoltages(1)));
            fprintf(fHandle,'\tvoltage_B %f%+fj;\n',real(StartVoltages(2)),imag(StartVoltages(2)));
            fprintf(fHandle,'\tvoltage_C %f%+fj;\n',real(StartVoltages(3)),imag(StartVoltages(3)));
        end
        fprintf(fHandle,'}\n\n');
    end
end

fprintf(fHandle,'//distributed loads intermediates (2/3 load at 1/4 line)\n\n');

%Create the intermediate nodes for the distributed loads
for nvals=1:NumUniqueNodes
    
    %Make sure we're a distributed
    if (UniqueNodesType(nvals,1)==1)
        
        %Find our index in the load category
        Idx=find(LineLengths(:,2)==UniqueNodes(nvals),1);

        %Output it
        fprintf(fHandle,'object load {\n');
        fprintf(fHandle,'\tname load_%s_inter;\n',num2str(UniqueNodes(nvals)));
        fprintf(fHandle,'\tphases ');
        if (UniqueNodesPhases(nvals,1)==1)
            fprintf(fHandle,'A');
        end
        if (UniqueNodesPhases(nvals,2)==1)
            fprintf(fHandle,'B');
        end
        if (UniqueNodesPhases(nvals,3)==1)
            fprintf(fHandle,'C');
        end
        if (DistLoadsCONV(Idx,1)>=3) %Delta
            fprintf(fHandle,'D;\n');
        else %Wye
            fprintf(fHandle,'N;\n');
        end
        
        %Check load types
        if ((DistLoadsCONV(Idx,1)==0) || (DistLoadsCONV(Idx,1)==3)) %PQ
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_power_A %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,2)),imag(DistLoadsCONVTwoThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_power_B %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,3)),imag(DistLoadsCONVTwoThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_power_C %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,4)),imag(DistLoadsCONVTwoThird(Idx,4)));
            end
        elseif ((DistLoadsCONV(Idx,1)==1) || (DistLoadsCONV(Idx,1)==4)) %I
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_current_A %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,2)),imag(DistLoadsCONVTwoThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_current_B %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,3)),imag(DistLoadsCONVTwoThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_current_C %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,4)),imag(DistLoadsCONVTwoThird(Idx,4)));
            end
        else %Must be impedance
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_impedance_A %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,2)),imag(DistLoadsCONVTwoThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_impedance_B %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,3)),imag(DistLoadsCONVTwoThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_impedance_C %f%+fj;\n',real(DistLoadsCONVTwoThird(Idx,4)),imag(DistLoadsCONVTwoThird(Idx,4)));
            end
        end
        
        fprintf(fHandle,'\tnominal_voltage %.4f;\n',NomVoltageLNH);
        if (UniqueNodes(nvals)==SWINGNode)
            fprintf(fHandle,'\tbustype SWING;\n');
            fprintf(fHandle,'\tvoltage_A %f%+fj;\n',real(StartVoltages(1)),imag(StartVoltages(1)));
            fprintf(fHandle,'\tvoltage_B %f%+fj;\n',real(StartVoltages(2)),imag(StartVoltages(2)));
            fprintf(fHandle,'\tvoltage_C %f%+fj;\n',real(StartVoltages(3)),imag(StartVoltages(3)));
        end
        fprintf(fHandle,'}\n\n');
    end
end

fprintf(fHandle,'//pure distributed loads (1/3 load at end of line)\n\n');

%Pure distributed load end (no spot loads)
for nvals=1:NumUniqueNodes
    
    %Make sure we're a distributed
    if ((UniqueNodesType(nvals,1)==1) && (UniqueNodesType(nvals,2)==0))
        
        %Find our index in the load category
        Idx=find(LineLengths(:,2)==UniqueNodes(nvals),1);

        %Output it
        fprintf(fHandle,'object load {\n');
        fprintf(fHandle,'\tname load_%s;\n',num2str(UniqueNodes(nvals)));
        fprintf(fHandle,'\tgroupid nodevolts;\n');
        fprintf(fHandle,'\tphases ');
        if (UniqueNodesPhases(nvals,1)==1)
            fprintf(fHandle,'A');
        end
        if (UniqueNodesPhases(nvals,2)==1)
            fprintf(fHandle,'B');
        end
        if (UniqueNodesPhases(nvals,3)==1)
            fprintf(fHandle,'C');
        end
        if (DistLoadsCONV(Idx,1)>=3) %Delta
            fprintf(fHandle,'D;\n');
        else %Wye
            fprintf(fHandle,'N;\n');
        end
        
        %Check load types
        if ((DistLoadsCONV(Idx,1)==0) || (DistLoadsCONV(Idx,1)==3)) %PQ
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_power_A %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,2)),imag(DistLoadsCONVOneThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_power_B %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,3)),imag(DistLoadsCONVOneThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_power_C %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,4)),imag(DistLoadsCONVOneThird(Idx,4)));
            end
        elseif ((DistLoadsCONV(Idx,1)==1) || (DistLoadsCONV(Idx,1)==4)) %I
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_current_A %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,2)),imag(DistLoadsCONVOneThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_current_B %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,3)),imag(DistLoadsCONVOneThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_current_C %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,4)),imag(DistLoadsCONVOneThird(Idx,4)));
            end
        else %Must be impedance
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_impedance_A %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,2)),imag(DistLoadsCONVOneThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_impedance_B %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,3)),imag(DistLoadsCONVOneThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_impedance_C %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,4)),imag(DistLoadsCONVOneThird(Idx,4)));
            end
        end
        
        fprintf(fHandle,'\tnominal_voltage %.4f;\n',NomVoltageLNH);
        if (UniqueNodes(nvals)==SWINGNode)
            fprintf(fHandle,'\tbustype SWING;\n');
            fprintf(fHandle,'\tvoltage_A %f%+fj;\n',real(StartVoltages(1)),imag(StartVoltages(1)));
            fprintf(fHandle,'\tvoltage_B %f%+fj;\n',real(StartVoltages(2)),imag(StartVoltages(2)));
            fprintf(fHandle,'\tvoltage_C %f%+fj;\n',real(StartVoltages(3)),imag(StartVoltages(3)));
        end
        fprintf(fHandle,'}\n\n');
    end
end

fprintf(fHandle,'//combination loads (1/3 dist load and spot load)\n\n');

%Now do the others (both distributed load and spot load)
for nvals=1:NumUniqueNodes
    
    %Make sure we're a distributed
    if ((UniqueNodesType(nvals,1)==1) && (UniqueNodesType(nvals,2)==1))
        
        %Print the spot load portion
        %Find our index in the load category
        Idx=find(SpotLoadsLoc(:,1)==UniqueNodes(nvals),1);

        %Output it
        fprintf(fHandle,'object load {\n');
        fprintf(fHandle,'\tname load_%s;\n',num2str(UniqueNodes(nvals)));
        fprintf(fHandle,'\tgroupid nodevolts;\n');
        fprintf(fHandle,'\tphases ');
        if (UniqueNodesPhases(nvals,1)==1)
            fprintf(fHandle,'A');
        end
        if (UniqueNodesPhases(nvals,2)==1)
            fprintf(fHandle,'B');
        end
        if (UniqueNodesPhases(nvals,3)==1)
            fprintf(fHandle,'C');
        end
        if (SpotLoadsCONV(Idx,1)>=3) %Wdelta
            fprintf(fHandle,'D;\n');
        else %Wye
            fprintf(fHandle,'N;\n');
        end
        
        %Check load types
        if ((SpotLoadsCONV(Idx,1)==0) || (SpotLoadsCONV(Idx,1)==3)) %PQ
            if (SpotLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_power_A %f%+fj;\n',real(SpotLoadsCONV(Idx,2)),imag(SpotLoadsCONV(Idx,2)));
            end
            if (SpotLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_power_B %f%+fj;\n',real(SpotLoadsCONV(Idx,3)),imag(SpotLoadsCONV(Idx,3)));
            end
            if (SpotLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_power_C %f%+fj;\n',real(SpotLoadsCONV(Idx,4)),imag(SpotLoadsCONV(Idx,4)));
            end
        elseif ((SpotLoadsCONV(Idx,1)==1) || (SpotLoadsCONV(Idx,1)==4)) %I
            if (SpotLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_current_A %f%+fj;\n',real(SpotLoadsCONV(Idx,2)),imag(SpotLoadsCONV(Idx,2)));
            end
            if (SpotLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_current_B %f%+fj;\n',real(SpotLoadsCONV(Idx,3)),imag(SpotLoadsCONV(Idx,3)));
            end
            if (SpotLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_current_C %f%+fj;\n',real(SpotLoadsCONV(Idx,4)),imag(SpotLoadsCONV(Idx,4)));
            end
        else %Must be impedance
            if (SpotLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_impedance_A %f%+fj;\n',real(SpotLoadsCONV(Idx,2)),imag(SpotLoadsCONV(Idx,2)));
            end
            if (SpotLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_impedance_B %f%+fj;\n',real(SpotLoadsCONV(Idx,3)),imag(SpotLoadsCONV(Idx,3)));
            end
            if (SpotLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_impedance_C %f%+fj;\n',real(SpotLoadsCONV(Idx,4)),imag(SpotLoadsCONV(Idx,4)));
            end
        end
        
        fprintf(fHandle,'\tnominal_voltage %.4f;\n',NomVoltageLNH);
        if (UniqueNodes(nvals)==SWINGNode)
            fprintf(fHandle,'\tbustype SWING;\n');
            fprintf(fHandle,'\tvoltage_A %f%+fj;\n',real(StartVoltages(1)),imag(StartVoltages(1)));
            fprintf(fHandle,'\tvoltage_B %f%+fj;\n',real(StartVoltages(2)),imag(StartVoltages(2)));
            fprintf(fHandle,'\tvoltage_C %f%+fj;\n',real(StartVoltages(3)),imag(StartVoltages(3)));
        end
        fprintf(fHandle,'}\n\n');

        %%Distributed load portion
        %Find our index in the load category
        Idx=find(LineLengths(:,2)==UniqueNodes(nvals),1);

        %Output it
        fprintf(fHandle,'object load {\n');
        fprintf(fHandle,'\tname load_%s_dist;\n',num2str(UniqueNodes(nvals)));
        fprintf(fHandle,'\tparent load_%s;\n',num2str(UniqueNodes(nvals)));
        fprintf(fHandle,'\tphases ');
        if (UniqueNodesPhases(nvals,1)==1)
            fprintf(fHandle,'A');
        end
        if (UniqueNodesPhases(nvals,2)==1)
            fprintf(fHandle,'B');
        end
        if (UniqueNodesPhases(nvals,3)==1)
            fprintf(fHandle,'C');
        end
        if (DistLoadsCONV(Idx,1)>=3) %Delta
            fprintf(fHandle,'D;\n');
        else %Wye
            fprintf(fHandle,'N;\n');
        end
        
        %Check load types
        if ((DistLoadsCONV(Idx,1)==0) || (DistLoadsCONV(Idx,1)==3)) %PQ
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_power_A %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,2)),imag(DistLoadsCONVOneThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_power_B %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,3)),imag(DistLoadsCONVOneThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_power_C %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,4)),imag(DistLoadsCONVOneThird(Idx,4)));
            end
        elseif ((DistLoadsCONV(Idx,1)==1) || (DistLoadsCONV(Idx,1)==4)) %I
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_current_A %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,2)),imag(DistLoadsCONVOneThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_current_B %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,3)),imag(DistLoadsCONVOneThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_current_C %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,4)),imag(DistLoadsCONVOneThird(Idx,4)));
            end
        else %Must be impedance
            if (DistLoadsCONV(Idx,2)~=0)
                fprintf(fHandle,'\tconstant_impedance_A %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,2)),imag(DistLoadsCONVOneThird(Idx,2)));
            end
            if (DistLoadsCONV(Idx,3)~=0)
                fprintf(fHandle,'\tconstant_impedance_B %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,3)),imag(DistLoadsCONVOneThird(Idx,3)));
            end
            if (DistLoadsCONV(Idx,4)~=0)
                fprintf(fHandle,'\tconstant_impedance_C %f%+fj;\n',real(DistLoadsCONVOneThird(Idx,4)),imag(DistLoadsCONVOneThird(Idx,4)));
            end
        end
        
        fprintf(fHandle,'\tnominal_voltage %.4f;\n',NomVoltageLNH);
        if (UniqueNodes(nvals)==SWINGNode)
            fprintf(fHandle,'\tbustype SWING;\n');
            fprintf(fHandle,'\tvoltage_A %f%+fj;\n',real(StartVoltages(1)),imag(StartVoltages(1)));
            fprintf(fHandle,'\tvoltage_B %f%+fj;\n',real(StartVoltages(2)),imag(StartVoltages(2)));
            fprintf(fHandle,'\tvoltage_C %f%+fj;\n',real(StartVoltages(3)),imag(StartVoltages(3)));
        end
        fprintf(fHandle,'}\n\n');
    end
end

%Add in the pure lines

fprintf(fHandle,'//Pure lines (no distributed loads)\n\n');

for lval=1:NumLines
    
    %See if we're a pure load
    if (OutputLines(lval)==1)
        
        %Find our configuration index
        Idx=find(AllLines(lval,4)==LineConfigInformation(:,1),1);
        
        %Now find our from node
        IdxFrom=find(AllLines(lval,1)==UniqueNodes,1);
        
        %Do the same for our to
        IdxTo=find(AllLines(lval,2)==UniqueNodes,1);
        
        %Print us out
        if (LineConfigInformation(Idx,5)==0)
            fprintf(fHandle,'object overhead_line {\n');
        else
            fprintf(fHandle,'object underground_line {\n');
        end
        fprintf(fHandle,'\tname line%sto%s;\n',num2str(UniqueNodes(IdxFrom)),num2str(UniqueNodes(IdxTo)));
        fprintf(fHandle,'\tphases ');
        if (LineConfigInformation(Idx,2)==1)
            fprintf(fHandle,'A');
        end
        if (LineConfigInformation(Idx,3)==1)
            fprintf(fHandle,'B');
        end
        if (LineConfigInformation(Idx,4)==1)
            fprintf(fHandle,'C');
        end
        if (LineConfigInformation(Idx,5)==0)
            fprintf(fHandle,'N;\n');
        else
            fprintf(fHandle,';\n');
        end
        
        %From
        if ((UniqueNodesType(IdxFrom,1)==0) && (UniqueNodesType(IdxFrom,2)==0)) %Node
            fprintf(fHandle,'\tfrom node_%s;\n',num2str(UniqueNodes(IdxFrom)));
        else %load
            fprintf(fHandle,'\tfrom load_%s;\n',num2str(UniqueNodes(IdxFrom)));
        end
        
        %To
        if ((UniqueNodesType(IdxTo,1)==0) && (UniqueNodesType(IdxTo,2)==0)) %Node
            fprintf(fHandle,'\tto node_%s;\n',num2str(UniqueNodes(IdxTo)));
        else %load
            fprintf(fHandle,'\tto load_%s;\n',num2str(UniqueNodes(IdxTo)));
        end
        
        fprintf(fHandle,'\tlength %0.2f;\n',AllLines(lval,3));
        fprintf(fHandle,'\tconfiguration lc%s;\n',num2str(AllLines(lval,4)));
        fprintf(fHandle,'}\n\n');
    end
end

%Now for the distributed loads portions (with the intermediate nodes)
fprintf(fHandle,'//Lines with distributed loads\n\n');

for lval=1:NumLines
    
    %See if we're a distributed load line
    if (OutputLines(lval)==0)
        
        %Find our configuration index
        Idx=find(AllLines(lval,4)==LineConfigInformation(:,1),1);
        
        %Now find our from node
        IdxFrom=find(AllLines(lval,1)==UniqueNodes,1);
        
        %Do the same for our to
        IdxTo=find(AllLines(lval,2)==UniqueNodes,1);
        
        %Print us out
        if (LineConfigInformation(Idx,5)==0)
            fprintf(fHandle,'object overhead_line {\n');
        else
            fprintf(fHandle,'object underground_line {\n');
        end
        fprintf(fHandle,'\tname line%sto%s_quart;\n',num2str(UniqueNodes(IdxFrom)),num2str(UniqueNodes(IdxTo)));
        fprintf(fHandle,'\tphases ');
        if (LineConfigInformation(Idx,2)==1)
            fprintf(fHandle,'A');
        end
        if (LineConfigInformation(Idx,3)==1)
            fprintf(fHandle,'B');
        end
        if (LineConfigInformation(Idx,4)==1)
            fprintf(fHandle,'C');
        end
        if (LineConfigInformation(Idx,5)==0)
            fprintf(fHandle,'N;\n');
        else
            fprintf(fHandle,';\n');
        end
        
        %From
        if ((UniqueNodesType(IdxFrom,1)==0) && (UniqueNodesType(IdxFrom,2)==0)) %Node
            fprintf(fHandle,'\tfrom node_%s;\n',num2str(UniqueNodes(IdxFrom)));
        else %load
            fprintf(fHandle,'\tfrom load_%s;\n',num2str(UniqueNodes(IdxFrom)));
        end
        
        %To
        fprintf(fHandle,'\tto load_%s_inter;\n',num2str(UniqueNodes(IdxTo)));
        
        fprintf(fHandle,'\tlength %0.2f;\n',AllLines(lval,3)/4);
        fprintf(fHandle,'\tconfiguration lc%s;\n',num2str(AllLines(lval,4)));
        fprintf(fHandle,'}\n\n');
        
        %Now print ouf the secondary portion
        %Print us out - "intermediate" line first
        %Print us out
        if (LineConfigInformation(Idx,5)==0)
            fprintf(fHandle,'object overhead_line {\n');
        else
            fprintf(fHandle,'object underground_line {\n');
        end
        fprintf(fHandle,'\tname line%sto%s_3quart;\n',num2str(UniqueNodes(IdxFrom)),num2str(UniqueNodes(IdxTo)));
        fprintf(fHandle,'\tphases ');
        if (LineConfigInformation(Idx,2)==1)
            fprintf(fHandle,'A');
        end
        if (LineConfigInformation(Idx,3)==1)
            fprintf(fHandle,'B');
        end
        if (LineConfigInformation(Idx,4)==1)
            fprintf(fHandle,'C');
        end
        if (LineConfigInformation(Idx,5)==0)
            fprintf(fHandle,'N;\n');
        else
            fprintf(fHandle,';\n');
        end
        
        %From
        fprintf(fHandle,'\tfrom load_%s_inter;\n',num2str(UniqueNodes(IdxTo)));

        %To
        if ((UniqueNodesType(IdxTo,1)==0) && (UniqueNodesType(IdxTo,2)==0)) %Node
            fprintf(fHandle,'\tto node_%s;\n',num2str(UniqueNodes(IdxTo)));
        else %load
            fprintf(fHandle,'\tto load_%s;\n',num2str(UniqueNodes(IdxTo)));
        end
        
        fprintf(fHandle,'\tlength %0.2f;\n',AllLines(lval,3)*3/4);
        fprintf(fHandle,'\tconfiguration lc%s;\n',num2str(AllLines(lval,4)));
        fprintf(fHandle,'}\n\n');
    end
end

%Now do transformers
fprintf(fHandle,'//Transformers\n\n');

for lval=1:NumTransformers
    
    %Now find our from node
    IdxFrom=find(TransformerInfo(lval,1)==UniqueNodes,1);

    %Do the same for our to
    IdxTo=find(TransformerInfo(lval,2)==UniqueNodes,1);

    %Print us out
    fprintf(fHandle,'object transformer {\n');
    fprintf(fHandle,'\tname trans%sto%s;\n',num2str(UniqueNodes(IdxFrom)),num2str(UniqueNodes(IdxTo)));
    fprintf(fHandle,'\tphases ABCN;\n');
    %From
    if ((UniqueNodesType(IdxFrom,1)==0) && (UniqueNodesType(IdxFrom,2)==0)) %Node
        fprintf(fHandle,'\tfrom node_%s;\n',num2str(UniqueNodes(IdxFrom)));
    else %load
        fprintf(fHandle,'\tfrom load_%s;\n',num2str(UniqueNodes(IdxFrom)));
    end
        
    %To
    if ((UniqueNodesType(IdxTo,1)==0) && (UniqueNodesType(IdxTo,2)==0)) %Node
        fprintf(fHandle,'\tto node_%s;\n',num2str(UniqueNodes(IdxTo)));
    else %load
        fprintf(fHandle,'\tto load_%s;\n',num2str(UniqueNodes(IdxTo)));
    end
        
    fprintf(fHandle,'\tconfiguration tc%s;\n',num2str(TransformerInfo(lval,3)));
    fprintf(fHandle,'}\n\n');
end

%Now do regulators
fprintf(fHandle,'//Regulators\n\n');

for lval=1:NumRegulators

    %Find our configuration index
    Idx=find(RegulatorInfo(lval,3)==LineConfigInformation(:,1),1);
    
    %Now find our from node
    IdxFrom=find(RegulatorInfo(lval,1)==UniqueNodes,1);

    %Do the same for our to
    IdxTo=find(RegulatorInfo(lval,2)==UniqueNodes,1);

    %Print us out
    fprintf(fHandle,'object regulator {\n');
    fprintf(fHandle,'\tname reg%sto%s;\n',num2str(UniqueNodes(IdxFrom)),num2str(UniqueNodes(IdxTo)));
    
    fprintf(fHandle,'\tphases ');
    if (LineConfigInformation(Idx,2)==1)
        fprintf(fHandle,'A');
    end
    if (LineConfigInformation(Idx,3)==1)
        fprintf(fHandle,'B');
    end
    if (LineConfigInformation(Idx,4)==1)
        fprintf(fHandle,'C');
    end
    fprintf(fHandle,'N;\n');
    
    %From
    if ((UniqueNodesType(IdxFrom,1)==0) && (UniqueNodesType(IdxFrom,2)==0)) %Node
        fprintf(fHandle,'\tfrom node_%s;\n',num2str(UniqueNodes(IdxFrom)));
    else %load
        fprintf(fHandle,'\tfrom load_%s;\n',num2str(UniqueNodes(IdxFrom)));
    end
        
    %To
    if ((UniqueNodesType(IdxTo,1)==0) && (UniqueNodesType(IdxTo,2)==0)) %Node
        fprintf(fHandle,'\tto node_%s;\n',num2str(UniqueNodes(IdxTo)));
    else %load
        fprintf(fHandle,'\tto load_%s;\n',num2str(UniqueNodes(IdxTo)));
    end
        
    fprintf(fHandle,'\tconfiguration rc%s;\n',num2str(RegulatorInfo(lval,3)));
    fprintf(fHandle,'}\n\n');
end

%Print switches
fprintf(fHandle,'//Switches\n\n');

for lval=1:NumSwitches
    
    %Now find our from node
    IdxFrom=find(SwitchInfo(lval,1)==UniqueNodes,1);

    %Do the same for our to
    IdxTo=find(SwitchInfo(lval,2)==UniqueNodes,1);

    %Print us out
    fprintf(fHandle,'object switch {\n');
    fprintf(fHandle,'\tname sw%sto%s;\n',num2str(UniqueNodes(IdxFrom)),num2str(UniqueNodes(IdxTo)));
    fprintf(fHandle,'\tphases ABCN;\n');
    %From
    if ((UniqueNodesType(IdxFrom,1)==0) && (UniqueNodesType(IdxFrom,2)==0)) %Node
        fprintf(fHandle,'\tfrom node_%s;\n',num2str(UniqueNodes(IdxFrom)));
    else %load
        fprintf(fHandle,'\tfrom load_%s;\n',num2str(UniqueNodes(IdxFrom)));
    end
        
    %To
    if ((UniqueNodesType(IdxTo,1)==0) && (UniqueNodesType(IdxTo,2)==0)) %Node
        fprintf(fHandle,'\tto node_%s;\n',num2str(UniqueNodes(IdxTo)));
    else %load
        fprintf(fHandle,'\tto load_%s;\n',num2str(UniqueNodes(IdxTo)));
    end
    
    %Print status
    if (SwitchInfo(lval,3)==0)
        fprintf(fHandle,'\tstatus OPEN;\n');
    else
        fprintf(fHandle,'\tstatus CLOSED;\n');
    end
        
    fprintf(fHandle,'}\n\n');
end

%Capacitors now
fprintf(fHandle,'//Capacitors\n\n');

%Loop through them
for cval=1:NumCapacitors

    %Output it
    fprintf(fHandle,'object capacitor {\n');
    fprintf(fHandle,'\tname cap_%s;\n',num2str(CapacitorInfo(cval,1)));

    %Determine our parent type
    UniqueIdx=(find(UniqueNodes==CapacitorInfo(cval,1),1));
    
    %See what type of node we are
    if ((UniqueNodesType(UniqueIdx,1)==0) && (UniqueNodesType(UniqueIdx,2)==0))
        fprintf(fHandle,'\tparent node_%s;\n',num2str(CapacitorInfo(cval,1)));
    else
        fprintf(fHandle,'\tparent load_%s;\n',num2str(CapacitorInfo(cval,1)));
    end
    
    %Print the phases
    fprintf(fHandle,'\tphases ');
    if (CapacitorInfo(cval,2)~=0)
        fprintf(fHandle,'A');
    end
    if (CapacitorInfo(cval,3)~=0)
        fprintf(fHandle,'B');
    end
    if (CapacitorInfo(cval,4)~=0)
        fprintf(fHandle,'C');
    end
    fprintf(fHandle,';\n');
    
    %Do the phases connected -- assume it is the same
    %Print the phases
    fprintf(fHandle,'\tphases_connected ');
    if (CapacitorInfo(cval,2)~=0)
        fprintf(fHandle,'A');
    end
    if (CapacitorInfo(cval,3)~=0)
        fprintf(fHandle,'B');
    end
    if (CapacitorInfo(cval,4)~=0)
        fprintf(fHandle,'C');
    end
    fprintf(fHandle,';\n');
    
    %print the nominal voltage
    fprintf(fHandle,'\tnominal_voltage %.4f;\n',NomVoltageLNH);
    
    %control line
    fprintf(fHandle,'\tcontrol MANUAL;\n');
    
    %Capacitance values - adjust for "proper nominal"
    if (CapacitorInfo(cval,2)~=0)
        fprintf(fHandle,'\tcapacitor_A %.4f;\n',(CapacitorInfo(cval,2)*1000*NomVoltageLNH*NomVoltageLNH/(abs(VoltageVals(1,CapacitorInfo(cval,5)))^2)));
    end
    if (CapacitorInfo(cval,3)~=0)
        fprintf(fHandle,'\tcapacitor_B %.4f;\n',(CapacitorInfo(cval,3)*1000*NomVoltageLNH*NomVoltageLNH/(abs(VoltageVals(1,CapacitorInfo(cval,5)))^2)));
    end
    if (CapacitorInfo(cval,4)~=0)
        fprintf(fHandle,'\tcapacitor_C %.4f;\n',(CapacitorInfo(cval,4)*1000*NomVoltageLNH*NomVoltageLNH/(abs(VoltageVals(1,CapacitorInfo(cval,5)))^2)));
    end
    
    %and switch status -- assume all closed
    if (CapacitorInfo(cval,2)~=0)
        fprintf(fHandle,'\tswitchA CLOSED;\n');
    end
    if (CapacitorInfo(cval,3)~=0)
        fprintf(fHandle,'\tswitchB CLOSED;\n');
    end
    if (CapacitorInfo(cval,4)~=0)
        fprintf(fHandle,'\tswitchC CLOSED;\n');
    end
    
    %Close the capacitor
    fprintf(fHandle,'};\n\n');
end

%Close the file
fclose(fHandle);