#!/bin/bash 

# Exit immediately on error
set -e
# Save Previous Command 
trap 'previous_command=$this_command; this_command=$BASH_COMMAND' DEBUG

PSS=../pssac2
VG="valgrind --dsymutil=yes"
SACF=sample.sac

function gmt_cmd() {
gmt pstext $JRP -K -O -N -M  -F+f10p,Helvetica -Gwhite -W1,black <<EOF >> $PS
> $1 $2 13p 3i l
$previous_command
EOF
}

function gmt_end() {
gmt psxy -J -R -O  <<EOF >> ${PS}
-100 -1
EOF
}

# FILL -G
PS="pss_G.ps"
JRP="-JX3i/2i -R-1/12/0/2 -P"
B="-B2/1S"
M="-M2i"
DY="1i"
echo "TEST: -G > $PS"
${PSS} sample.sac ${JRP} $B -Entb $M -G255/1/1/0/0/10  -r -K > ${PS}
gmt_cmd 12 0.5
B="-B2/1s"
${PSS} sample.sac ${JRP} $B -Entb $M -g1/1/255/0/0/10 -r  -O -K -Y2i >> ${PS}
gmt_cmd 12 0.5
gmt_end

# STDIN
JRP="-JX5i/5i -R8/20/0/3 -P"
E="-Entz"
B="-B2/1WSne  "

PS=pss_stdin.ps
echo "TEST: STDIN > $PS"

${PSS} $JRP -M1i -Entz $B -K <<EOF > $PS
sample.sac
EOF
gmt_cmd 10 0.2
gmt_end

JRP="-JX2i/2i -R8/20/0/3 -P"
E="-Entz"
B="-B2/1WSne  "
PS=pss_M.ps
echo "TEST: -M > $PS"
# SCALE -M
${PSS} ${SACF} ${SACF} ${JRP} -M1i       $E $B  -K                   >  ${PS}
gmt_cmd 14 0.01
${PSS} ${SACF} ${SACF} ${JRP} -M2i       $E $B  -K -O -X2.6i         >> ${PS}
gmt_cmd 14 0.01
${PSS} ${SACF} ${SACF} ${JRP} -M0.5i     $E $B  -K -O -X-2.6i -Y2.7i >> ${PS}
gmt_cmd 14 0.01
${PSS} ${SACF} ${SACF} ${JRP} -M2.54c    $E $B  -K -O -X2.6i         >> ${PS}
gmt_cmd 14 0.01
${PSS} ${SACF} ${SACF} ${JRP} -M0.5/0    $E $B  -K -O -X-2.6i -Y2.7i >> ${PS}
gmt_cmd 14 0.01
${PSS} ${SACF} ${SACF} ${JRP} -M1e-3/1   $E $B  -K -O -X2.6i         >> ${PS}
gmt_cmd 14 0.01
${PSS} ${SACF} ${SACF} ${JRP} -M1e-4/1.5 $E $B  -K -O -X-2.6i -Y2.7i >> ${PS}
gmt_cmd 14 0.01
${PSS} ${SACF} ${SACF} ${JRP} -M5e-6/2   $E $B  -K -O -X2.6i         >> ${PS}
gmt_cmd 14 0.01
gmt_end

# PLOT TYPE -E
PS=pss_E.ps
JRP="-JX2i/2i -R8/20/100/900 -P"
B="-B2/100WSen"
M="-M1i"
echo "TEST: -E > $PS"
rm -f $PS
${PSS} dist/sample_?.sac sample.sac ${JRP} -Ektz $B  -M0.4i -K             >  ${PS}
gmt_cmd 14 901
JRP="-JX2i/2i -R8/20/0/8 -P"
B="-B2/1WSen"
${PSS} dist/sample_?.sac sample.sac ${JRP} -Edtz $B  -M0.4i -K -O -X2.9i  >>  ${PS}
gmt_cmd 14 9.1
JRP="-JX2i/2i -R8/20/0/360 -P"
B="-B2/60WSen"
${PSS} az/sample_*.sac sample.sac ${JRP} -Eatz $B  -M0.4i  -K -O -X-2.9i -Y2.9i  >>  ${PS}
gmt_cmd 14 361
${PSS} az/sample_*.sac sample.sac ${JRP} -Ebtz $B  -M0.4i  -K -O -X2.9i  >>  ${PS}
gmt_cmd 14 361
gmt_end

# ALIGN -E
PS=pss_Et.ps
JRP="-JX6i/1i -R-10/70/0/2 -P"
B="-B10g10/1S"
DY="0.7i"
echo "TEST: -Et > $PS"
${PSS} sample.sac ${JRP} -Entb $B  -M0.4i  -K      >   ${PS}
gmt_cmd 3 1.5
B="-B10g10/1s"
${PSS} sample.sac ${JRP} $B -Ento -Wred   -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Enta -W1,blue   -M0.4i  -K -O  -Y$DY >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent0 -W1,purple  -M0.4i  -K -O  -Y$DY >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent1 -W1,yellow   -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent2 -W2,orchid   -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent3 -W1,gray  -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent4 -W1,firebrick   -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent5 -W1,chocolate  -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent6 -W1,lawngreen   -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent7 -W1,darkolivegreen  -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent8 -W1,cyan  -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
${PSS} sample.sac ${JRP} $B -Ent9 -W1,tomato   -M0.4i  -K -O -Y$DY  >>  ${PS}
gmt_cmd 3 1.5
gmt_end

# CUT -C
PS=pss_C.ps
JRP="-JX6i/1i -R8/30/0/2 -P"
B="-B3g1/2S"
M="-M0.4i"
DY="0.5i"
echo "TEST: -C > $PS"
${PSS} sample.sac ${JRP} $B -Entz $M -K           > ${PS}
gmt_cmd 24 1.5
B="-B3g1/1s"
${PSS} sample.sac ${JRP} $B -Entz $M -K -O -Y$DY -C5/15 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -K -O -Y$DY -C10/15 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -K -O -Y$DY -C11/15 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -K -O -Y$DY -C15/20 >> ${PS}
gmt_cmd 24 1.5

${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C10/30 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C17/30 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C19/30 >> ${PS}
gmt_cmd 24 1.5

${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C16/24 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C16/21 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C16/19 >> ${PS}
gmt_cmd 24 1.5

${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C16/20 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C17/21 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -C18/22 >> ${PS}
gmt_cmd 24 1.5

${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -Cta/t9 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -Ct4/ta >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -Ct4/t9 >> ${PS}
gmt_cmd 24 1.5
${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY -Ct9/te >> ${PS}
gmt_cmd 24 1.5

${PSS} sample.sac ${JRP} $B -Ent5 $M -K -O -Y$DY >> ${PS}
gmt_cmd 24 1.5

gmt_end
# SHIFT -S
PS="pss_A.ps"
JRP="-JX6i/1i -R6/20/0.5/1.5 -P"
B="-B2g1/1S"
M="-M2i"
DY="1i"
echo "TEST: -S > $PS"
${PSS} sample.sac ${JRP} $B -Entz $M -K > ${PS}
gmt_cmd 18 1.5
B="-B2g1/1s"
${PSS} sample.sac ${JRP} $B -Entz $M -r -O -K -Y$DY >> ${PS}
gmt_cmd 18 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -S-3 -K -O -Y$DY >> ${PS}
gmt_cmd 18 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -S-2 -K -O -Y$DY >> ${PS}
gmt_cmd 18 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -S-1 -K -O -Y$DY >> ${PS}
gmt_cmd 18 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -S0 -K -O -Y$DY >> ${PS}
gmt_cmd 18 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -S1 -K -O -Y$DY >> ${PS}
gmt_cmd 18 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -S2 -K -O -Y$DY >> ${PS}
gmt_cmd 18 1.5
${PSS} sample.sac ${JRP} $B -Entz $M -S3 -K -O -Y$DY >> ${PS}
gmt_cmd 18 1.5
gmt_end

# MAP PLOTS
PS="pss_map2.ps"
JRP="-JM6i -R-125/-115/45/50 -P"
B="-B2"
echo "TEST: -L -JM > $PS"
${PSS} sample.sac ${JRP} -M1i -Entb -L3 -Wdarkblue -K > ${PS}
gmt_cmd -120 47
gmt psxy $JRP -Si0.2i -Wblack -Gred $B -V -K -O <<EOF >> ${PS}
-122 48
EOF
gmt_end
