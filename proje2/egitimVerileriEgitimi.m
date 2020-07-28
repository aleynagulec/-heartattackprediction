
    Best_cost=100;
Best_fis=[];
sayac=0;
for i=1:1
    epoch_n = 1;
    egitim_in_fismat= genfis1(egitim_veri,3,'gaussmf');
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
    
    egitim_out_fismat = anfis(egitim_veri,egitim_in_fismat,epoch_n)
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
    
    deger = evalfis(egitim_veri(:,1:5),egitim_out_fismat);
    plot(egitim_veri(:,6),deger,'rs'); %performance in terms of cross plotting 
    pause(0.01);

    hata=egitim_veri(:,6)-deger;
    cost=sqrt(mse(hata));
    if cost<Best_cost Best_cost=cost; Best_fis=egitim_out_fismat; end
    
    sayac=sayac+1
    
end


deger = evalfis(egitim_veri(:,1:5),Best_fis);
%%tolerans aralýðý
    for m=1:1
        for n=1:200  %%deger aralýgýna göre burayý deðiþtirmeyi unutma.
            if (-0.25<deger(n)) && (deger(n)<=0.25)
                deger(n)=0;
            elseif  (0.75<deger(n)) && (deger(n)<=1.25)
                deger(n)=1;
            elseif  (1.75<deger(n)) && (deger(n)<=2.25)
                deger(n)=2; 
            elseif  (2.75<deger(n)) && (deger(n)<=3.25)
                deger(n)=3;
            elseif  (3.75<deger(n)) && (deger(n)<=4.25)
                deger(n)=4;
            end
        end
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
    
    %%egitimveri'nin cýkýsýndaki degerlere göre toplamlar
    egitimson=egitim_veri(:,6);
    esifir=0; ebir=0; eiki=0; euc=0; edort=0;
    for v=1:length(egitimson)
        if egitimson(v)>-1 && egitimson(v)<1
            esifir=esifir+1;
        elseif egitimson(v)>0 && egitimson(v)<2
            ebir=ebir+1;
        elseif egitimson(v)>1 && egitimson(v)<3
            eiki=eiki+1;
        elseif egitimson(v)>2 && egitimson(v)<4
            euc=euc+1;
        elseif egitimson(v)>3 && egitimson(v)<5
            edort=edort+1;
        end
    end
   
    %%egitim icin doðru-yanlis sayilari
    esifirDogru = sifir;
    esifirYanlis = abs(esifir-sifir);
    
    ebirDogru = bir;
    ebirYanlis = abs(bir-ebir);
    
    eikiDogru = iki;
    eikiYanlis = abs(iki-eiki);
    
    eucDogru = uc;
    eucYanlis = abs(uc-euc);
    
    edortDogru = dort;
    edortYanlis = abs(dort-edort);
    
    eDogruYanlis2 = [
        0 esifirDogru esifirYanlis;
        1 ebirDogru ebirYanlis;
        2 eikiDogru eikiYanlis;
        3 eucDogru eucYanlis;
        4 edortDogru edortYanlis];

    %%Egitim için doðruluk hesabý (accuracy cal.)
    acc_cal0=100*eDogruYanlis2(1,2)/(eDogruYanlis2(1,2)+eDogruYanlis2(1,3));
    acc_cal1=100*eDogruYanlis2(2,2)/(eDogruYanlis2(2,2)+eDogruYanlis2(2,3));
    acc_cal2=100*eDogruYanlis2(3,2)/(eDogruYanlis2(3,2)+eDogruYanlis2(3,3));
    acc_cal3=100*eDogruYanlis2(4,2)/(eDogruYanlis2(4,2)+eDogruYanlis2(4,3));
    acc_cal4=100*eDogruYanlis2(5,2)/(eDogruYanlis2(5,2)+eDogruYanlis2(5,3));

    eDogruYanlis = [string('Kalp Krizi') string('Doðru Sayýsý') string('Yanlýþ Sayýsý') string('Doðruluk Hesabý');
        0 esifirDogru esifirYanlis acc_cal0;
        1 ebirDogru ebirYanlis acc_cal1;
        2 eikiDogru eikiYanlis acc_cal2;
        3 eucDogru eucYanlis acc_cal3;
        4 edortDogru edortYanlis acc_cal4];
    
    
   
   