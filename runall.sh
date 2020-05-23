# run one by one 
bash 1-makedata.sh >  1-makedata.log  2>&1 &  
bash 2-scratch.sh >  2-scratch.log  2>&1 &  
bash 3-impact_from_small.sh >  3-impact_from_small.log  2>&1 & 
bash 4-impact_from_full.sh >  4-impact_from_full.log  2>&1 &  
bash 5-makedata_plusminustheta.sh >  5-makedata_plusminustheta.log  2>&1 &  
bash 6-plusminustheta.sh >  6-plusminustheta.log  2>&1 &  
bash 5-makedata_plusminus.sh >  5-makedata_plusminus.log  2>&1 &  
bash 6-plusminus.sh >  6-plusminus.log  2>&1 &  
bash 7-layer.sh >  7-layer.log  2>&1 &  
bash 8-makedata_layernew.sh >  8-makedata_layernew.log  2>&1 &  
bash 9-layernew.sh >   9-layernew.log  2>&1 &  
