    Best_cost=100;
    Best_fis=[];
    sayac=0;
    
for i=1:3
    epoch_n = 1;
    test_in_fismat= genfis1(test_veri,3,'gaussmf');
%     [x1,mf1] = plotmf(in_fismat,'input',1);
%     subplot(5,2,1),plot(x1,mf1);
%     title('EÐÝTÝM ÝÇÝN SONUÇLAR');
%     [x2,mf2] = plotmf(in_fismat,'input',2);
%     subplot(5,2,3),plot(x2,mf2);
%     [x3,mf3] = plotmf(in_fismat,'input',3);
%     subplot(5,2,5),plot(x3,mf3);
%     [x4,mf4] = plotmf(in_fismat,'input',4);
%     subplot(5,2,7),plot(x4,mf4);
%     [x5,mf5] = plotmf(in_fismat,'input',5);
%     subplot(5,2,9),plot(x5,mf5);
    
    test_out_fismat = anfis(test_veri,test_in_fismat,epoch_n)
%     [x1son,mf1son] = plotmf(out_fismat,'input',1);%Bu þekilde bütün giriþleri çizdirebilirsin.
%     subplot(5,2,2),plot(x1son,mf1son);
%     title('TEST ÝÇÝN SONUÇLAR');
%     [x2son,mf2son] = plotmf(out_fismat,'input',2);
%     subplot(5,2,4),plot(x2son,mf2son);
%     [x3son,mf3son] = plotmf(out_fismat,'input',3);
%     subplot(5,2,6),plot(x3son,mf3son);
%     [x4son,mf4son] = plotmf(out_fismat,'input',4);
%     subplot(5,2,8),plot(x4son,mf4son);
%     [x5son,mf5son] = plotmf(out_fismat,'input',5);
%     subplot(5,2,10),plot(x5son,mf5son);
%     f=figure(); 
    
    deger = evalfis(test_veri(:,1:5),test_out_fismat);

    plot(test_veri(:,6),deger,'rs');
    pause(0.01);
    
    hata=test_veri(:,6)-deger;
    cost=sqrt(mse(hata));
    if cost<Best_cost Best_cost=cost; Best_fis=test_out_fismat; end
    sayac=sayac+1
    
end

 %%deger'in 0 1 2 3 4 toplamlarý
    sifir=0; bir=0; iki=0; uc=0; dort=0;
    for z=1:length(deger)
        if deger(z)>-1 && deger(z)<1
            sifir=sifir+1;
        elseif deger(z)>0 && deger(z)<2
            bir=bir+1;
        elseif deger(z)>1 && deger(z)<3
            iki=iki+1;
        elseif deger(z)>2 && deger(z)<4
            uc=uc+1;
        elseif deger(z)>3 && deger(z)<5
            dort=dort+1;
        end
    end
    
    deger = evalfis(test_veri(:,1:5),Best_fis);

    
    %%tolerans aralýðý
    for c=1:1
        for d=1:97  %%deger aralýgýna göre burayý deðiþtirmeyi unutma.
            if (-0.25<deger(d)) && (deger(d)<=0.25)
                deger(d)=0;
            elseif  (0.75<deger(d)) && (deger(d)<=1.25)
                deger(d)=1;
            elseif  (1.75<deger(d)) && (deger(d)<=2.25)
                deger(d)=2; 
            elseif  (2.75<deger(d)) && (deger(d)<=3.25)
                deger(d)=3;
            elseif  (3.75<deger(d)) && (deger(d)<=4.25)
                deger(d)=4;
            end
        end
    end
     %%testveri'nin cýkýsýndaki degerlere göre toplamlar
    testson=test_veri(:,6);
    tsifir=0; tbir=0; tiki=0; tuc=0; tdort=0;
    for y=1:length(testson)
        if testson(y)>-1 && testson(y)<1
            tsifir=tsifir+1;
        elseif testson(y)>0 && testson(y)<2
            tbir=tbir+1;
        elseif testson(y)>1 && testson(y)<3
            tiki=tiki+1;
        elseif testson(y)>2 && testson(y)<4
            tuc=tuc+1;
        elseif testson(y)>3 && testson(y)<5
            tdort=tdort+1;
        end
    end
   
    %%test icin doðru-yanlis sayilari
    tsifirDogru = sifir;
    tsifirYanlis = abs(tsifir-sifir);
    
    tbirDogru = bir;
    tbirYanlis = abs(bir-tbir);
    
    tikiDogru = iki;
    tikiYanlis = abs(iki-tiki);
    
    tucDogru = uc;
    tucYanlis = abs(uc-tuc);
    
    tdortDogru = dort;
    tdortYanlis = abs(dort-tdort);
  
    tDogruYanlis2 = [
        0 tsifirDogru tsifirYanlis;
        1 tbirDogru tbirYanlis;
        2 tikiDogru tikiYanlis;
        3 tucDogru tucYanlis;
        4 tdortDogru tdortYanlis];

      %Test için doðruluk hesabý (accuracy cal.)
    acc_cal0_t=100*tDogruYanlis2(1,2)/(tDogruYanlis2(1,2)+tDogruYanlis2(1,3));
    acc_cal1_t=100*tDogruYanlis2(2,2)/(tDogruYanlis2(2,2)+tDogruYanlis2(2,3));
    acc_cal2_t=100*tDogruYanlis2(3,2)/(tDogruYanlis2(3,2)+tDogruYanlis2(3,3));
    acc_cal3_t=100*tDogruYanlis2(4,2)/(tDogruYanlis2(4,2)+tDogruYanlis2(4,3));
    acc_cal4_t=100*tDogruYanlis2(5,2)/(tDogruYanlis2(5,2)+tDogruYanlis2(5,3));
    
    tDogruYanlis = [string('Kalp Krizi') string('Doðru Sayýsý') string('Yanlýþ Sayýsý') string('Doðruluk Hesabý');
        0 tsifirDogru tsifirYanlis acc_cal0_t;
        1 tbirDogru tbirYanlis acc_cal1_t;
        2 tikiDogru tikiYanlis acc_cal2_t;
        3 tucDogru tucYanlis acc_cal3_t;
        4 tdortDogru tdortYanlis acc_cal4_t];

