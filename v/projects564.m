clear all

% IA is the Input Array, 12x12 of int16's
IA = [
-17469      18    7876    8741  -12150    3741   17742   10805    7687   -3602   -7128    5454  ;
  9953  -14508  -16901  -14364   14219   -6259    2114  -19009   13395   -5528  -15045    9127  ;
 19091   -7233    9035    7233    1931   -3460    4706  -16435    -771   -3646   -4808    4999  ;
  -474    7105    -453    8163  -15523    9040    3451    6962     516   11029   18439  -13133  ;
  5311  -14352    4374    -833    3643    7619  -11398   19714   13326  -15517  -10644    3173  ;
 18197   -1845    -994   -5405    7612  -17427  -16333   19347    3033   -2773  -16321    4594  ;
 18391  -10046    5265   -9412   -9930   18470  -12554    8291  -15318    -662   17681   -6095  ;
-19032   -7022  -18709    9843   16740  -17369   -2782  -14444   -2529   18349   -9378   10284  ;
-17243   -9862   16067  -17264    9011    6515    6451   16402    1196   -2556    1766    6343  ;
  1009    -989  -10060    7721  -17295  -17430   16130  -17059  -12597   16143   -5642   -5355  ;
 17763   -1348   13807  -12725  -10767    5712   18194   18801    2084  -16317  -11054   -4614  ;
-17261  -15027   -2530   -8721   18470   11732   17396  -15852  -12208   16652   -1085   -6671  ;
]
% B contains the 1x9 step 1 filters
B = [
 16652   17552   -7691    9128    3063  -10089   11903   16323   15434  ;
 -2450   17041    2273   17891   -2345   13548    4142   -6319   -7202  ;
  9069   -8401   -5257  -12764  -16373   11736   -6482   18070   -6081  ;
 -2705  -16522  -16651   11682    4378    5902   -8021    5246  -15848  ;
]

% M contains the 1x64 step 2 filters
M = [
   695   14517   17005   -8225  -11972  -15974   14041   -2924   15306  -10535   -2251   12724   11511   -7325   -4594    9417     557   -2654  -12823    9662    2775  -17673   16805    4030    2691  -16802   16981    6935  -12302   -7349   -7407   16342  -18715     186  -10626  -14372  -15162   18971  -16983   14164    7552  -15028   12754    5308    2047     293  -15869    3638  -13091   -2139   -3308   -2146    5858   -7884     580   -3597   -8255   13315   -9938   12356  -19367  -10550   -9711   -8836  
   186  -10626  -14372  -15162   18971  -16983   14164    7552  -15028   12754    5308    2047     293  -15869    3638  -13091   -2139   -3308   -2146    5858   -7884     580   -3597   -8255   13315   -9938   12356  -19367  -10550   -9711   -8836  -13155   -7194   -8239    5760    2959  -12708   11193   -8099   -7057  -10968   14898    4861   14619   17623   -2919   16282   13903   10001  -17173      96   14980   -1280   15007   10758   12881  -16930   19667    1670   -9259   -2161   -2642   -3270    8132  
 -8239    5760    2959  -12708   11193   -8099   -7057  -10968   14898    4861   14619   17623   -2919   16282   13903   10001  -17173      96   14980   -1280   15007   10758   12881  -16930   19667    1670   -9259   -2161   -2642   -3270    8132    9372   14205    4821    3305   14942    2376   -5744   17995   19496   12773    2010  -14544  -18716    9416   17063   15783    7531  -13025   19545   17830   19119    9635  -15146   -8113  -17982   14165   19198    5197   -4873   -5533   18540   -7057    6807  
  4821    3305   14942    2376   -5744   17995   19496   12773    2010  -14544  -18716    9416   17063   15783    7531  -13025   19545   17830   19119    9635  -15146   -8113  -17982   14165   19198    5197   -4873   -5533   18540   -7057    6807  -17286  -10564  -18008    3414   12823   14667   -5814   17774  -13983    2888   -4109  -18637   19675  -17258  -14718   -8394   15042   -6494   13476     721    2566   -5066   13121    5645    5700  -16132   -4013  -12293   14075   13809  -14015  -12704   -4376  
-18008    3414   12823   14667   -5814   17774  -13983    2888   -4109  -18637   19675  -17258  -14718   -8394   15042   -6494   13476     721    2566   -5066   13121    5645    5700  -16132   -4013  -12293   14075   13809  -14015  -12704   -4376    8660   -9669  -13965   -7720   12610    9401    4410   15957   -7768   -7362  -11703   -7519    1080   15856  -18001  -17938    2086   -4876  -17939  -18300  -18816   -4675   -9186   -9456  -11816     702    9012  -10446    6382   -1224    9036    1460   14069  
-13965   -7720   12610    9401    4410   15957   -7768   -7362  -11703   -7519    1080   15856  -18001  -17938    2086   -4876  -17939  -18300  -18816   -4675   -9186   -9456  -11816     702    9012  -10446    6382   -1224    9036    1460   14069   -9044   -1412     692   -3487  -14841   -1585    7570   -7964    5391  -12018   13131    -820   17611  -16025   -9819   -1277    5171  -17682  -13063   -9990    1750   -4154    9138   11393    6706    7826   17479  -19395    3739    -201  -19840   12277   10238  
   692   -3487  -14841   -1585    7570   -7964    5391  -12018   13131    -820   17611  -16025   -9819   -1277    5171  -17682  -13063   -9990    1750   -4154    9138   11393    6706    7826   17479  -19395    3739    -201  -19840   12277   10238  -19151   -8200  -16312   12202  -18436   -1572    6984    -383   11127  -17191    3305    9267   11620  -15088  -13716   16655  -14355   11112  -11940   -1309   -9473   -3528   11941   17133    1649   18443    6833     474    4589   18846   -7230    6437     575  
-16312   12202  -18436   -1572    6984    -383   11127  -17191    3305    9267   11620  -15088  -13716   16655  -14355   11112  -11940   -1309   -9473   -3528   11941   17133    1649   18443    6833     474    4589   18846   -7230    6437     575   -1674   13656    4088   18339  -13122  -16470  -14178   -8349   18453   -2549   -3610   -5981   -8902   16674    4824   -6111   10186   -3965    1423  -18507   12989   11617   16821  -18936   -2365   -8197    6900   10626  -13660    7560  -10757    9356   -5866  
]

% Extract the four 6x6 regions of the input array, we will calls these Quadrants
Quadrant0 = IA(1:6,1:6)
Quadrant = Quadrant0
Quadrant(:,:,2) = IA(1:6,7:12)
Quadrant(:,:,3) = IA(7:12,1:6)
Quadrant(:,:,4) = IA(7:12,7:12)

% Perform a dot-product of the b-vector with each corner of the ROI

C = zeros(2,2);
for layer = 1:4
    for QuadrantN = 1:4
        
        A_1_1  = [Quadrant(1,1:3,QuadrantN) Quadrant(2,1:3,QuadrantN) Quadrant(3,1:3,QuadrantN)];
        A_1_2  = [Quadrant(1,4:6,QuadrantN) Quadrant(2,4:6,QuadrantN) Quadrant(3,4:6,QuadrantN)];
        A_2_1  = [Quadrant(4,1:3,QuadrantN) Quadrant(5,1:3,QuadrantN) Quadrant(6,1:3,QuadrantN)];
        A_2_2  = [Quadrant(4,4:6,QuadrantN) Quadrant(5,4:6,QuadrantN) Quadrant(6,4:6,QuadrantN)];
        C(1,1) = A_1_1*B(layer,:)';
        C(1,2) = A_1_2*B(layer,:)';
        C(2,1) = A_2_1*B(layer,:)';
        C(2,2) = A_2_2*B(layer,:)';
        
        % apply f(x) and truncate
        sign_C_1_1  = sign(C(1,1)) ;
        C_1_1  = dec2bin(abs(C(1,1)),32) ;
        C_1_1  = C_1_1(1:16) ;
        C_1_1  = bin2dec(C_1_1) ;
        C(1,1)  = sign_C_1_1*C_1_1;
        sign_C_1_2  = sign(C(1,2)) ;
        C_1_2  = dec2bin(abs(C(1,2)),32) ;
        C_1_2  = C_1_2(1:16) ;
        C_1_2  = bin2dec(C_1_2) ;
        C(1,2)  = sign_C_1_2*C_1_2;
        sign_C_2_1  = sign(C(2,1)) ;
        C_2_1  = dec2bin(abs(C(2,1)),32) ;
        C_2_1  = C_2_1(1:16) ;
        C_2_1  = bin2dec(C_2_1) ;
        C(2,1)  = sign_C_2_1*C_2_1;
        sign_C_2_2  = sign(C(2,2)) ;
        C_2_2  = dec2bin(abs(C(2,2)),32) ;
        C_2_2  = C_2_2(1:16) ;
        C_2_2  = bin2dec(C_2_2) ;
        C(2,2)  = sign_C_2_2*C_2_2;

        Z = max(0,C)
        
        Zq(:,:,layer,QuadrantN) = Z;
        
    end
end

% Now operate on the four 2x2x4 quadrants as if it were a 4x4x4 array
% Our matlab quadrant array is organized as (y,x,ROI,layer)
% So lets just merge them
% Remember, a layer is generated from each B vector
for layer = 1:4
    Zmerged(:,:,layer) = [Zq(:,:,layer,1) Zq(:,:,layer,2) ;
                          Zq(:,:,layer,3) Zq(:,:,layer,4) ]
end

% Create a 1x64 vector from a merged array
% We create the vector using row major layer by layer
%
% use reshape on the transpose because reshape uses column major
U = [];
for layer = 1:4
    U = [U reshape(Zmerged(:,:,layer)', [1 16])];
end

% Now dot-product Qv with each output m-vector
W = [];
for o = 1:8
    W = [W M(o,:)*U'];
end

% Now apply our f(x)
O = max(0,W);
% truncate
O = O/(2^16);
% Expected output
O

