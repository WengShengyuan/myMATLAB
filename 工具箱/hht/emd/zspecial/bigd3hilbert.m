echo on;
% --- BIGD3HILBERT loads files and plots their 3-D Hilbert spectrum.
% Data loaded is 'cp71301'-'cp713100'.
%
% Non MATLAB Library routines used are: NSPAB, FSPECIAL.
%
% See marked lines in the code to change cases.
%
% N. E. Huang (NASA GSFC)	08.Feb. 2001 Initial
% --- bigd3hilbert.m --- Version 08.Feb.2001 ----- %

clear;					% Start Fresh

load cp71301; cp71301=cp71301';		% Load HHT Results and Rotate
load cp71302; cp71302=cp71302';
load cp71303; cp71303=cp71303';
load cp71304; cp71304=cp71304';
load cp71305; cp71305=cp71305';
load cp71306; cp71306=cp71306';
load cp71307; cp71307=cp71307';
load cp71308; cp71308=cp71308';
load cp71309; cp71309=cp71309';
load cp713010; cp713010=cp713010'; 
load cp713011; cp713011=cp713011';
load cp713012; cp713012=cp713012';
load cp713013; cp713013=cp713013';
load cp713014; cp713014=cp713014';
load cp713015; cp713015=cp713015';
load cp713016; cp713016=cp713016';
load cp713017; cp713017=cp713017';
load cp713018; cp713018=cp713018';
load cp713019; cp713019=cp713019';
load cp713020; cp713020=cp713020';
load cp713021; cp713021=cp713021';					% Load HHT Results and Rotate
load cp713022; cp713022=cp713022';
load cp713023; cp713023=cp713023';
load cp713024; cp713024=cp713024';
load cp713025; cp713025=cp713025';
load cp713026; cp713026=cp713026';
load cp713027; cp713027=cp713027';
load cp713028; cp713028=cp713028';
load cp713029; cp713029=cp713029';
load cp713030; cp713030=cp713030'; 
load cp713031; cp713031=cp713031';
load cp713032; cp713032=cp713032';
load cp713033; cp713033=cp713033';
load cp713034; cp713034=cp713034';
load cp713035; cp713035=cp713035';
load cp713036; cp713036=cp713036';
load cp713037; cp713037=cp713037';
load cp713038; cp713038=cp713038';
load cp713039; cp713039=cp713039';
load cp713040; cp713040=cp713040';
load cp713041; cp713041=cp713041';					% Load HHT Results and Rotate
load cp713042; cp713042=cp713042';
load cp713043; cp713043=cp713043';
load cp713044; cp713044=cp713044';
load cp713045; cp713045=cp713045';
load cp713046; cp713046=cp713046';
load cp713047; cp713047=cp713047';
load cp713048; cp713048=cp713048';
load cp713049; cp713049=cp713049';
load cp713050; cp713050=cp713050'; 
load cp713051; cp713051=cp713051';
load cp713052; cp713052=cp713052';
load cp713053; cp713053=cp713053';
load cp713054; cp713054=cp713054';
load cp713055; cp713055=cp713055';
load cp713056; cp713056=cp713056';
load cp713057; cp713057=cp713057';
load cp713058; cp713058=cp713058';
load cp713059; cp713059=cp713059';
load cp713060; cp713060=cp713060';
load cp713061; cp713061=cp713061';					% Load HHT Results and Rotate
load cp713062; cp713062=cp713062';
load cp713063; cp713063=cp713063';
load cp713064; cp713064=cp713064';
load cp713065; cp713065=cp713065';
load cp713066; cp713066=cp713066';
load cp713067; cp713067=cp713067';
load cp713068; cp713068=cp713068';
load cp713069; cp713069=cp713069';
load cp713070; cp713070=cp713070'; 
load cp713071; cp713071=cp713071';
load cp713072; cp713072=cp713072';
load cp713073; cp713073=cp713073';
load cp713074; cp713074=cp713074';
load cp713075; cp713075=cp713075';
load cp713076; cp713076=cp713076';
load cp713077; cp713077=cp713077';
load cp713078; cp713078=cp713078';
load cp713079; cp713079=cp713079';
load cp713080; cp713080=cp713080';
load cp713081; cp713081=cp713081';					% Load HHT Results and Rotate
load cp713082; cp713082=cp713082';
load cp713083; cp713083=cp713083';
load cp713084; cp713084=cp713084';
load cp713085; cp713085=cp713085';
load cp713086; cp713086=cp713086';
load cp713087; cp713087=cp713087';
load cp713088; cp713088=cp713088';
load cp713089; cp713089=cp713089';
load cp713090; cp713090=cp713090'; 
load cp713091; cp713091=cp713091';
load cp713092; cp713092=cp713092';
load cp713093; cp713093=cp713093';
load cp713094; cp713094=cp713094';
load cp713095; cp713095=cp713095';
load cp713096; cp713096=cp713096';
load cp713097; cp713097=cp713097';
load cp713098; cp713098=cp713098';
load cp713099; cp713099=cp713099';
load cp7130100; cp7130100=cp7130100';

[n1, x, k]=nspab(cp71301(:, 1:4),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n2, x, k]=nspab(cp71302(:, 1:5),128, 0,5,0, 26.54); 
[n3, x, k]=nspab(cp71303(:, 1:6),128, 0,5,0, 26.54); 
[n4, x, k]=nspab(cp71304(:, 1:5),128, 0,5,0, 26.54); 
[n5, x, k]=nspab(cp71305(:, 1:6),128, 0,5,0, 26.54); 
[n6, x, k]=nspab(cp71306(:, 1:5),128, 0,5,0, 26.54); 
[n7, x, k]=nspab(cp71307(:, 1:5),128, 0,5,0, 26.54); 
[n8, x, k]=nspab(cp71308(:, 1:6),128, 0,5,0, 26.54); 
[n9, x, k]=nspab(cp71309(:, 1:5),128, 0,5,0, 26.54); 
[n10, x, k]=nspab(cp713010(:, 1:5),128, 0,5,0, 26.54); 
[n11, x, k]=nspab(cp713011(:, 1:5),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n12, x, k]=nspab(cp713012(:, 1:5),128, 0,5,0, 26.54); 
[n13, x, k]=nspab(cp713013(:, 1:6),128, 0,5,0, 26.54); 
[n14, x, k]=nspab(cp713014(:, 1:6),128, 0,5,0, 26.54); 
[n15, x, k]=nspab(cp713015(:, 1:6),128, 0,5,0, 26.54); 
[n16, x, k]=nspab(cp713016(:, 1:6),128, 0,5,0, 26.54); 
[n17, x, k]=nspab(cp713017(:, 1:5),128, 0,5,0, 26.54); 
[n18, x, k]=nspab(cp713018(:, 1:5),128, 0,5,0, 26.54); 
[n19, x, k]=nspab(cp713019(:, 1:5),128, 0,5,0, 26.54); 
[n20, x, k]=nspab(cp713020(:, 1:5),128, 0,5,0, 26.54); 
[n21, x, k]=nspab(cp713021(:, 1:5),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n22, x, k]=nspab(cp713022(:, 1:5),128, 0,5,0, 26.54); 
[n23, x, k]=nspab(cp713023(:, 1:5),128, 0,5,0, 26.54); 
[n24, x, k]=nspab(cp713024(:, 1:5),128, 0,5,0, 26.54); 
[n25, x, k]=nspab(cp713025(:, 1:6),128, 0,5,0, 26.54); 
[n26, x, k]=nspab(cp713026(:, 1:6),128, 0,5,0, 26.54); 
[n27, x, k]=nspab(cp713027(:, 1:6),128, 0,5,0, 26.54); 
[n28, x, k]=nspab(cp713028(:, 1:6),128, 0,5,0, 26.54); 
[n29, x, k]=nspab(cp713029(:, 1:6),128, 0,5,0, 26.54); 
[n30, x, k]=nspab(cp713030(:, 1:5),128, 0,5,0, 26.54); 
[n31, x, k]=nspab(cp713031(:, 1:6),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n32, x, k]=nspab(cp713032(:, 1:6),128, 0,5,0, 26.54); 
[n33, x, k]=nspab(cp713033(:, 1:6),128, 0,5,0, 26.54); 
[n34, x, k]=nspab(cp713034(:, 1:5),128, 0,5,0, 26.54); 
[n35, x, k]=nspab(cp713035(:, 1:5),128, 0,5,0, 26.54); 
[n36, x, k]=nspab(cp713036(:, 1:6),128, 0,5,0, 26.54); 
[n37, x, k]=nspab(cp713037(:, 1:5),128, 0,5,0, 26.54); 
[n38, x, k]=nspab(cp713038(:, 1:5),128, 0,5,0, 26.54); 
[n39, x, k]=nspab(cp713039(:, 1:5),128, 0,5,0, 26.54); 
[n40, x, k]=nspab(cp713040(:, 1:6),128, 0,5,0, 26.54); 
[n41, x, k]=nspab(cp713041(:, 1:5),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n42, x, k]=nspab(cp713042(:, 1:6),128, 0,5,0, 26.54); 
[n43, x, k]=nspab(cp713043(:, 1:6),128, 0,5,0, 26.54); 
[n44, x, k]=nspab(cp713044(:, 1:6),128, 0,5,0, 26.54); 
[n45, x, k]=nspab(cp713045(:, 1:5),128, 0,5,0, 26.54); 
[n46, x, k]=nspab(cp713046(:, 1:6),128, 0,5,0, 26.54); 
[n47, x, k]=nspab(cp713047(:, 1:6),128, 0,5,0, 26.54); 
[n48, x, k]=nspab(cp713048(:, 1:5),128, 0,5,0, 26.54); 
[n49, x, k]=nspab(cp713049(:, 1:5),128, 0,5,0, 26.54); 
[n50, x, k]=nspab(cp713050(:, 1:5),128, 0,5,0, 26.54); 
[n51, x, k]=nspab(cp713051(:, 1:5),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n52, x, k]=nspab(cp713052(:, 1:5),128, 0,5,0, 26.54); 
[n53, x, k]=nspab(cp713053(:, 1:5),128, 0,5,0, 26.54); 
[n54, x, k]=nspab(cp713054(:, 1:6),128, 0,5,0, 26.54); 
[n55, x, k]=nspab(cp713055(:, 1:6),128, 0,5,0, 26.54); 
[n56, x, k]=nspab(cp713056(:, 1:6),128, 0,5,0, 26.54); 
[n57, x, k]=nspab(cp713057(:, 1:6),128, 0,5,0, 26.54); 
[n58, x, k]=nspab(cp713058(:, 1:6),128, 0,5,0, 26.54); 
[n59, x, k]=nspab(cp713059(:, 1:5),128, 0,5,0, 26.54); 
[n60, x, k]=nspab(cp713060(:, 1:6),128, 0,5,0, 26.54); 
[n61, x, k]=nspab(cp713061(:, 1:6),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n62, x, k]=nspab(cp713062(:, 1:6),128, 0,5,0, 26.54); 
[n63, x, k]=nspab(cp713063(:, 1:6),128, 0,5,0, 26.54); 
[n64, x, k]=nspab(cp713064(:, 1:5),128, 0,5,0, 26.54); 
[n65, x, k]=nspab(cp713065(:, 1:6),128, 0,5,0, 26.54); 
[n66, x, k]=nspab(cp713066(:, 1:6),128, 0,5,0, 26.54); 
[n67, x, k]=nspab(cp713067(:, 1:6),128, 0,5,0, 26.54); 
[n68, x, k]=nspab(cp713068(:, 1:6),128, 0,5,0, 26.54); 
[n69, x, k]=nspab(cp713069(:, 1:6),128, 0,5,0, 26.54); 
[n70, x, k]=nspab(cp713070(:, 1:6),128, 0,5,0, 26.54); 
[n71, x, k]=nspab(cp713071(:, 1:5),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n72, x, k]=nspab(cp713072(:, 1:6),128, 0,5,0, 26.54); 
[n73, x, k]=nspab(cp713073(:, 1:5),128, 0,5,0, 26.54); 
[n74, x, k]=nspab(cp713074(:, 1:5),128, 0,5,0, 26.54); 
[n75, x, k]=nspab(cp713075(:, 1:5),128, 0,5,0, 26.54); 
[n76, x, k]=nspab(cp713076(:, 1:5),128, 0,5,0, 26.54); 
[n77, x, k]=nspab(cp713077(:, 1:5),128, 0,5,0, 26.54); 
[n78, x, k]=nspab(cp713078(:, 1:5),128, 0,5,0, 26.54); 
[n79, x, k]=nspab(cp713079(:, 1:6),128, 0,5,0, 26.54); 
[n80, x, k]=nspab(cp713080(:, 1:6),128, 0,5,0, 26.54); 
[n81, x, k]=nspab(cp713081(:, 1:6),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n82, x, k]=nspab(cp713082(:, 1:6),128, 0,5,0, 26.54); 
[n83, x, k]=nspab(cp713083(:, 1:6),128, 0,5,0, 26.54); 
[n84, x, k]=nspab(cp713084(:, 1:5),128, 0,5,0, 26.54); 
[n85, x, k]=nspab(cp713085(:, 1:6),128, 0,5,0, 26.54); 
[n86, x, k]=nspab(cp713086(:, 1:6),128, 0,5,0, 26.54); 
[n87, x, k]=nspab(cp713087(:, 1:6),128, 0,5,0, 26.54); 
[n88, x, k]=nspab(cp713088(:, 1:5),128, 0,5,0, 26.54); 
[n89, x, k]=nspab(cp713089(:, 1:5),128, 0,5,0, 26.54); 
[n90, x, k]=nspab(cp713090(:, 1:6),128, 0,5,0, 26.54); 
[n91, x, k]=nspab(cp713091(:, 1:6),128, 0,5,0, 26.54);		% Do Hilbert Spectra
[n92, x, k]=nspab(cp713092(:, 1:6),128, 0,5,0, 26.54); 
[n93, x, k]=nspab(cp713093(:, 1:6),128, 0,5,0, 26.54); 
[n94, x, k]=nspab(cp713094(:, 1:5),128, 0,5,0, 26.54); 
[n95, x, k]=nspab(cp713095(:, 1:5),128, 0,5,0, 26.54); 
[n96, x, k]=nspab(cp713096(:, 1:6),128, 0,5,0, 26.54); 
[n97, x, k]=nspab(cp713097(:, 1:5),128, 0,5,0, 26.54); 
[n98, x, k]=nspab(cp713098(:, 1:6),128, 0,5,0, 26.54); 
[n99, x, k]=nspab(cp713099(:, 1:6),128, 0,5,0, 26.54); 
[n100, x, k]=nspab(cp7130100(:, 1:6),128, 0,5,0, 26.54); 

q=fspecial('ga', 7, 0.7);		  							% Make Filter

n1=filter2(q, n1);n1=filter2(q, n1);n1=filter2(q, n1);	% Apply Filter
n2=filter2(q, n2);n2=filter2(q, n2);n2=filter2(q, n2);
n3=filter2(q, n3);n3=filter2(q, n3);n3=filter2(q, n3);
n4=filter2(q, n4);n4=filter2(q, n4);n4=filter2(q, n4);
n5=filter2(q, n5);n5=filter2(q, n5);n5=filter2(q, n5);
n6=filter2(q, n6);n6=filter2(q, n6);n6=filter2(q, n6);
n7=filter2(q, n7);n7=filter2(q, n7);n7=filter2(q, n7);
n8=filter2(q, n8);n8=filter2(q, n8);n8=filter2(q, n8);
n9=filter2(q, n9);n9=filter2(q, n9);n9=filter2(q, n9);
n10=filter2(q, n10);n10=filter2(q, n10);n10=filter2(q, n10);
n11=filter2(q, n11);n11=filter2(q, n11);n11=filter2(q, n11);	% Apply Filter
n12=filter2(q, n12);n12=filter2(q, n12);n12=filter2(q, n12);
n13=filter2(q, n13);n13=filter2(q, n13);n13=filter2(q, n13);
n14=filter2(q, n14);n14=filter2(q, n14);n14=filter2(q, n14);
n15=filter2(q, n15);n15=filter2(q, n15);n15=filter2(q, n15);
n16=filter2(q, n16);n16=filter2(q, n16);n16=filter2(q, n16);
n17=filter2(q, n17);n17=filter2(q, n17);n17=filter2(q, n17);
n18=filter2(q, n18);n18=filter2(q, n18);n18=filter2(q, n18);
n19=filter2(q, n19);n19=filter2(q, n19);n19=filter2(q, n19);
n20=filter2(q, n20);n20=filter2(q, n20);n20=filter2(q, n20);
n21=filter2(q, n21);n21=filter2(q, n21);n21=filter2(q, n21);	% Apply Filter
n22=filter2(q, n22);n22=filter2(q, n22);n22=filter2(q, n22);
n23=filter2(q, n23);n23=filter2(q, n23);n23=filter2(q, n23);
n24=filter2(q, n24);n24=filter2(q, n24);n24=filter2(q, n24);
n25=filter2(q, n25);n25=filter2(q, n25);n25=filter2(q, n25);
n26=filter2(q, n26);n26=filter2(q, n26);n26=filter2(q, n26);
n27=filter2(q, n27);n27=filter2(q, n27);n27=filter2(q, n27);
n28=filter2(q, n28);n28=filter2(q, n28);n28=filter2(q, n28);
n29=filter2(q, n29);n29=filter2(q, n29);n29=filter2(q, n29);
n30=filter2(q, n30);n30=filter2(q, n30);n30=filter2(q, n30);
n31=filter2(q, n31);n31=filter2(q, n31);n31=filter2(q, n31);	% Apply Filter
n32=filter2(q, n32);n32=filter2(q, n32);n32=filter2(q, n32);
n33=filter2(q, n33);n33=filter2(q, n33);n33=filter2(q, n33);
n34=filter2(q, n34);n34=filter2(q, n34);n34=filter2(q, n34);
n35=filter2(q, n35);n35=filter2(q, n35);n35=filter2(q, n35);
n36=filter2(q, n36);n36=filter2(q, n36);n36=filter2(q, n36);
n37=filter2(q, n37);n37=filter2(q, n37);n37=filter2(q, n37);
n38=filter2(q, n38);n38=filter2(q, n38);n38=filter2(q, n38);
n39=filter2(q, n39);n39=filter2(q, n39);n39=filter2(q, n39);
n40=filter2(q, n40);n40=filter2(q, n40);n40=filter2(q, n40);
n41=filter2(q, n41);n41=filter2(q, n41);n41=filter2(q, n41);	% Apply Filter
n42=filter2(q, n42);n42=filter2(q, n42);n42=filter2(q, n42);
n43=filter2(q, n43);n43=filter2(q, n43);n43=filter2(q, n43);
n44=filter2(q, n44);n44=filter2(q, n44);n44=filter2(q, n44);
n45=filter2(q, n45);n45=filter2(q, n45);n45=filter2(q, n45);
n46=filter2(q, n46);n46=filter2(q, n46);n46=filter2(q, n46);
n47=filter2(q, n47);n47=filter2(q, n47);n47=filter2(q, n47);
n48=filter2(q, n48);n48=filter2(q, n48);n48=filter2(q, n48);
n49=filter2(q, n49);n49=filter2(q, n49);n49=filter2(q, n49);
n50=filter2(q, n50);n50=filter2(q, n50);n50=filter2(q, n50);
n51=filter2(q, n51);n51=filter2(q, n51);n51=filter2(q, n51);	% Apply Filter
n52=filter2(q, n52);n52=filter2(q, n52);n52=filter2(q, n52);
n53=filter2(q, n53);n53=filter2(q, n53);n53=filter2(q, n53);
n54=filter2(q, n54);n54=filter2(q, n54);n54=filter2(q, n54);
n55=filter2(q, n55);n55=filter2(q, n55);n55=filter2(q, n55);
n56=filter2(q, n56);n56=filter2(q, n56);n56=filter2(q, n56);
n57=filter2(q, n57);n57=filter2(q, n57);n57=filter2(q, n57);
n58=filter2(q, n58);n58=filter2(q, n58);n58=filter2(q, n58);
n59=filter2(q, n59);n59=filter2(q, n59);n59=filter2(q, n59);
n60=filter2(q, n60);n60=filter2(q, n60);n60=filter2(q, n60);
n61=filter2(q, n61);n61=filter2(q, n61);n61=filter2(q, n61);	% Apply Filter
n62=filter2(q, n62);n62=filter2(q, n62);n62=filter2(q, n62);
n63=filter2(q, n63);n63=filter2(q, n63);n63=filter2(q, n63);
n64=filter2(q, n64);n64=filter2(q, n64);n64=filter2(q, n64);
n65=filter2(q, n65);n65=filter2(q, n65);n65=filter2(q, n65);
n66=filter2(q, n66);n66=filter2(q, n66);n66=filter2(q, n66);
n67=filter2(q, n67);n67=filter2(q, n67);n67=filter2(q, n67);
n68=filter2(q, n68);n68=filter2(q, n68);n68=filter2(q, n68);
n69=filter2(q, n69);n69=filter2(q, n69);n69=filter2(q, n69);
n70=filter2(q, n70);n70=filter2(q, n70);n70=filter2(q, n70);
n71=filter2(q, n71);n71=filter2(q, n71);n71=filter2(q, n71);	% Apply Filter
n72=filter2(q, n72);n72=filter2(q, n72);n72=filter2(q, n72);
n73=filter2(q, n73);n73=filter2(q, n73);n73=filter2(q, n73);
n74=filter2(q, n74);n74=filter2(q, n74);n74=filter2(q, n74);
n75=filter2(q, n75);n75=filter2(q, n75);n75=filter2(q, n75);
n76=filter2(q, n76);n76=filter2(q, n76);n76=filter2(q, n76);
n77=filter2(q, n77);n77=filter2(q, n77);n77=filter2(q, n77);
n78=filter2(q, n78);n78=filter2(q, n78);n78=filter2(q, n78);
n79=filter2(q, n79);n79=filter2(q, n79);n79=filter2(q, n79);
n80=filter2(q, n80);n80=filter2(q, n80);n80=filter2(q, n80);
n81=filter2(q, n81);n81=filter2(q, n81);n81=filter2(q, n81);	% Apply Filter
n82=filter2(q, n82);n82=filter2(q, n82);n82=filter2(q, n82);
n83=filter2(q, n83);n83=filter2(q, n83);n83=filter2(q, n83);
n84=filter2(q, n84);n84=filter2(q, n84);n84=filter2(q, n84);
n85=filter2(q, n85);n85=filter2(q, n85);n85=filter2(q, n85);
n86=filter2(q, n86);n86=filter2(q, n86);n86=filter2(q, n86);
n87=filter2(q, n87);n87=filter2(q, n87);n87=filter2(q, n87);
n88=filter2(q, n88);n88=filter2(q, n88);n88=filter2(q, n88);
n89=filter2(q, n89);n89=filter2(q, n89);n89=filter2(q, n89);
n90=filter2(q, n90);n90=filter2(q, n90);n90=filter2(q, n90);
n91=filter2(q, n91);n91=filter2(q, n91);n91=filter2(q, n91);	% Apply Filter
n92=filter2(q, n92);n92=filter2(q, n92);n92=filter2(q, n92);
n93=filter2(q, n93);n93=filter2(q, n93);n93=filter2(q, n93);
n94=filter2(q, n94);n94=filter2(q, n94);n94=filter2(q, n94);
n95=filter2(q, n95);n95=filter2(q, n95);n95=filter2(q, n95);
n96=filter2(q, n96);n96=filter2(q, n96);n96=filter2(q, n96);
n97=filter2(q, n97);n97=filter2(q, n97);n97=filter2(q, n97);
n98=filter2(q, n98);n98=filter2(q, n98);n98=filter2(q, n98);
n99=filter2(q, n99);n99=filter2(q, n99);n99=filter2(q, n99);
n100=filter2(q, n100);n100=filter2(q, n100);n100=filter2(q, n100);

% ms1 = mspc(n1,k);								% Normalized Marginal Spectra
% ms2 = mspc(n2,k);
% ms3 = mspc(n3,k);
% ms4 = mspc(n4,k);
% ms5 = mspc(n5,k);
% ms6 = mspc(n6,k);
% ms7 = mspc(n7,k);
% ms8 = mspc(n8,k);
% ms9 = mspc(n9,k);
% ms10 = mspc(n10,k);

N=zeros(128,170, 100);			% Make & Assemble Data Volume

N(:, :, 1)=n1;
N(:, :, 2)=n2;
N(:, :, 3)=n3;
N(:, :, 4)=n4;
N(:, :, 5)=n5;
N(:, :, 6)=n6;
N(:, :, 7)=n7;
N(:, :, 8)=n8;
N(:, :, 9)=n9;
N(:, :, 10)=n10;
N(:, :, 11)=n11;
N(:, :, 12)=n12;
N(:, :, 13)=n13;
N(:, :, 14)=n14;
N(:, :, 15)=n15;
N(:, :, 16)=n16;
N(:, :, 17)=n17;
N(:, :, 18)=n18;
N(:, :, 19)=n19;
N(:, :, 20)=n20;
N(:, :, 21)=n21;
N(:, :, 22)=n22;
N(:, :, 23)=n23;
N(:, :, 24)=n24;
N(:, :, 25)=n25;
N(:, :, 26)=n26;
N(:, :, 27)=n27;
N(:, :, 28)=n28;
N(:, :, 29)=n29;
N(:, :, 30)=n30;
N(:, :, 31)=n31;
N(:, :, 32)=n32;
N(:, :, 33)=n33;
N(:, :, 34)=n34;
N(:, :, 35)=n35;
N(:, :, 36)=n36;
N(:, :, 37)=n37;
N(:, :, 38)=n38;
N(:, :, 39)=n39;
N(:, :, 40)=n40;
N(:, :, 41)=n41;
N(:, :, 42)=n42;
N(:, :, 43)=n43;
N(:, :, 44)=n44;
N(:, :, 45)=n45;
N(:, :, 46)=n46;
N(:, :, 47)=n47;
N(:, :, 48)=n48;
N(:, :, 49)=n49;
N(:, :, 50)=n50;
N(:, :, 51)=n51;
N(:, :, 52)=n52;
N(:, :, 53)=n53;
N(:, :, 54)=n54;
N(:, :, 55)=n55;
N(:, :, 56)=n56;
N(:, :, 57)=n57;
N(:, :, 58)=n58;
N(:, :, 59)=n59;
N(:, :, 60)=n60;
N(:, :, 61)=n61;
N(:, :, 62)=n62;
N(:, :, 63)=n63;
N(:, :, 64)=n64;
N(:, :, 65)=n65;
N(:, :, 66)=n66;
N(:, :, 67)=n67;
N(:, :, 68)=n68;
N(:, :, 69)=n69;
N(:, :, 70)=n70;
N(:, :, 71)=n71;
N(:, :, 72)=n72;
N(:, :, 73)=n73;
N(:, :, 74)=n74;
N(:, :, 75)=n75;
N(:, :, 76)=n76;
N(:, :, 77)=n77;
N(:, :, 78)=n78;
N(:, :, 79)=n79;
N(:, :, 80)=n80;
N(:, :, 81)=n81;
N(:, :, 82)=n82;
N(:, :, 83)=n83;
N(:, :, 84)=n84;
N(:, :, 85)=n85;
N(:, :, 86)=n86;
N(:, :, 87)=n87;
N(:, :, 88)=n88;
N(:, :, 89)=n89;
N(:, :, 90)=n90;
N(:, :, 91)=n91;
N(:, :, 92)=n92;
N(:, :, 93)=n93;
N(:, :, 94)=n94;
N(:, :, 95)=n95;
N(:, :, 96)=n96;
N(:, :, 97)=n97;
N(:, :, 98)=n98;
N(:, :, 99)=n99;
N(:, :, 100)=n100;

% --- Averaging Section --- %

N(:, :, 1) = (N(:, :, 1) + N(:, :, 2)) ./ 2.;
N(:, :, 100) = (N(:, :, 99) + N(:, :, 100)) ./ 2.;
N(:, :, 2) = (4. .* N(:, :, 2) + N(:, :, 1) + N(:, :, 3)) ./ 6.;
N(:, :, 99) = (4. .* N(:, :, 99) + N(:, :, 98) + N(:, :, 100)) ./ 6.;

for i = 3:98;
	N(:, :,i) = (6. .* N(:, :, i) + 2. .* (N(:, :, i-1) +  N(:, :, i+1)) ...
	             +  N(:, :, i-2) +  N(:, :, i+2)) ./ 12.;
end;

save Nvar N x k;

tt=linspace(15, 25, 100)';


% --- Change this Value -----> x.xxx <---------- Change this Value -- %
p = patch(isosurface(x,k,tt,N, 0.01));
% ------------------------------------------------------------------- %
isonormals(x,k, tt, N, p)
set(p, 'FaceColor', 'cyan', 'EdgeColor', 'none');
daspect([.5 .2 0.25])
campos([114 33.4 92]);
lighting phong;
grid on;
camlight left

% --- Change the Title ---> Case   Frames  Line No. Contour Level --- %
title( 'X Distance: 0-26 cm; Y Distance: 15-25 cm; Wavenumber: 0-4 1/cm')
toptitle('3D Hilbert Spectrum: NEH-07 F130 L193 to 492 C.01')

% --- Bigd3Hilbert.m Ends Normally --- %

